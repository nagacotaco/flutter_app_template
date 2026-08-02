# auth

認証の画面群（メール+パスワード / 電話番号 OTP / Google / Apple）。
認証操作の実体は `lib/core/auth/`（settings / profile も使うため core 配下）:

- `auth_repository.dart` — 抽象インターフェース + `AuthFailure` + 実装切替 provider
- `supabase_auth_repository.dart` / `firebase_auth_repository.dart` — 各バックエンド実装
- `auth_providers.dart` — ログイン状態（`AppUser`）のグローバル provider

未ログイン時の `/login` への誘導は `lib/core/router/app_router.dart` の redirect。

## バックエンドの切り替え

`lib/core/backend.dart` の `appBackend` 定数で Supabase / Firebase を切り替える（現在: firebase）。
main.dart の初期化と AuthRepository の実装が連動して切り替わる。画面・ViewModel は無変更で動く。

## 動作に必要な設定（Firebase 使用時）

- **初期設定**: `flutterfire configure` 済み（`lib/core/firebase/firebase_options_{dev,prod}.dart`）。Dart オプション初期化のため google-services.json / GoogleService-Info.plist は不要。コピー先アプリでは Bundle ID 変更後に `flutterfire configure` を再実行して2ファイルを再生成する
- **iOS 最低バージョン**: Firebase iOS SDK の要件で deployment target は 15.0 以上（ios/Runner.xcodeproj に設定済み。13.0 に下げると Firebase 使用時にビルドできない）
- **メール**: Firebase Console > Authentication > Sign-in method で Email/Password を有効化
- **電話番号**: 同 Phone を有効化。SMS 契約不要のテスト電話番号 + 固定 OTP を登録して確認する（実 SMS は Blaze プラン必須）。iOS 実機で本番利用する場合は後述「電話番号認証の iOS 本番設定」を実施する
- **Google**: 後述「Google ログインの設定手順」を実施
- **Apple**: 同 Apple を有効化する。Xcode 側の Capability「Sign in with Apple」は `ios/Runner/Runner.entitlements` に設定済み（追加作業不要）。Apple Developer の App ID への capability 反映は、自動署名なら次回実機ビルド時に Xcode が行う
- **退会**: 最終ログインから時間が経つと requires-recent-login エラーになる（再ログイン後に退会し直す仕様）

### Google ログインの設定手順

**テンプレート本体は下記すべて設定済み（2026-08-02。Google / Apple プロバイダ有効化・
クライアント ID 設定込み）。** 設定不備の検出は `integration_test/social_login_smoke_test.dart`
（シミュレータでネイティブ UI 起動まで確認。Apple の完全な確認は実機で行う）。
以下はコピー先アプリで新しい Firebase プロジェクトを作ったときの再実施手順。

**リポジトリ / Firebase プロジェクトに設定済み（追加作業不要）:**

- Info.plist の URL scheme（`$(GOOGLE_REVERSED_CLIENT_ID)`。値は flavor 別 xcconfig `ios/Flutter/{dev,prod}{Debug,Profile,Release}.xcconfig` で定義）
- debug keystore の SHA-1 を dev / prod 両 Android アプリに登録済み（2026-08-02）。**リリースビルド用の keystore を作ったら、その SHA-1 も `firebase apps:android:sha:create <appId> <sha1>` で追加すること**

**手動で必要な作業（Firebase Console）:**

1. Firebase Console > Authentication > Sign-in method で Google を有効化（サポートメールを選んで保存）
2. 有効化すると OAuth クライアントが自動作成される。`fvm flutter pub global run flutterfire_cli:flutterfire configure` を再実行するか、`firebase apps:sdkconfig ios <iOS appId>` で `CLIENT_ID` / `REVERSED_CLIENT_ID` を取得する
3. `env/dev.json` / `env/prod.json` に設定: `GOOGLE_WEB_CLIENT_ID`（ウェブクライアント ID。Android で必須）と `GOOGLE_IOS_CLIENT_ID`（iOS クライアント ID）
4. flavor 別 xcconfig の `GOOGLE_REVERSED_CLIENT_ID=` に reversed client ID（iOS クライアント ID を逆順にした `com.googleusercontent.apps.xxx`）を設定

### 電話番号認証の iOS 本番設定（APNs / reCAPTCHA フォールバック）

Firebase の iOS 電話番号認証は、まずサイレントプッシュ（APNs）でアプリの正当性を検証し、
届かない場合に reCAPTCHA（URL scheme でアプリに戻る）へフォールバックする。

**リポジトリに設定済み（追加作業不要）:**

- `ios/Runner/Runner.entitlements`（`aps-environment: development`。App Store 配布時のアーカイブで自動的に production へ置換される）
- Info.plist の `UIBackgroundModes: remote-notification` と `CFBundleURLTypes: $(FIREBASE_APP_ID_SCHEME)`
- flavor 別 xcconfig（`ios/Flutter/{dev,prod}{Debug,Profile,Release}.xcconfig`）の `FIREBASE_APP_ID_SCHEME`。値は Firebase iOS appId のコロンをハイフンにした `app-1-64933516130-ios-<suffix>` 形式。**コピー先アプリでは `flutterfire configure` 再実行後に新しい appId で書き換えること**

**手動で必要な作業（Apple Developer / Firebase Console）:**

1. [Apple Developer](https://developer.apple.com/account/resources/authkeys/list) > Keys で APNs 認証キー（.p8）を作成しダウンロード（Key ID と Team ID を控える）
2. Firebase Console > プロジェクト設定 > Cloud Messaging > 「Apple アプリの構成」に .p8 / Key ID / Team ID をアップロード（dev / prod 両アプリ分）
3. Apple Developer > Identifiers で対象 App ID の Push Notifications capability を有効化（Xcode の自動署名を使っていれば entitlements から自動で反映される）
4. 確認: 実機ビルドで電話番号ログイン → 実 SMS が届けば APNs 経路が動作。reCAPTCHA が表示された場合も、完了後アプリに戻り OTP 入力まで進めれば URL scheme は正しい

補足: APNs キーはプッシュ通知（`lib/core/notifications/`）と共用。既に FCM 用にアップロード済みなら手順 1〜2 は不要。

- **メール / 電話番号**: `env/dev.json` に `SUPABASE_URL` / `SUPABASE_ANON_KEY` を設定。電話番号は SMS プロバイダ未契約でも Supabase ダッシュボード（Auth > Providers > Phone）のテスト用電話番号+OTP で確認できる
- **パスワード再設定**: メール内リンクは Web で開く。アプリ内で完結させたい場合はディープリンク設定（docs/DEEP_LINKS.md）後に redirectTo を指定する
- **Google**: Google Cloud Console で OAuth クライアント（Web + iOS + Android）を作成し、Web クライアント ID を Supabase（Auth > Providers > Google）と `env/*.json` の `GOOGLE_WEB_CLIENT_ID` に設定。iOS は `GOOGLE_IOS_CLIENT_ID` も設定し、Info.plist に reversed client ID の URL scheme を追加
- **Apple**: Apple Developer で Sign in with Apple を有効化し、Xcode で Runner に Capability「Sign in with Apple」を追加。Supabase（Auth > Providers > Apple）にも設定
- **退会**: `supabase/migrations/` の `delete_account` 関数をマイグレーション適用しておくこと

## 使わないバックエンドを削除する手順

- **Supabase を削除**（Firebase 採用時）: `lib/core/auth/supabase_auth_repository.dart` と `lib/core/supabase/`、`lib/features/profile/data/supabase_profile_repository.dart` を削除し、`auth_repository.dart` / `profile_repository.dart` の switch と import、`lib/core/backend.dart` の enum 値、`main.dart` の Supabase 分岐を削除。pubspec から `supabase_flutter` を削除。`supabase/` ディレクトリも削除
- **Firebase を削除**（Supabase 採用時）: `lib/core/auth/firebase_auth_repository.dart` と `lib/core/firebase/`、`lib/features/profile/data/firebase_profile_repository.dart`、`firebase.json` を削除し、同様に switch / enum / main.dart の分岐を削除。pubspec から `firebase_core` / `firebase_auth` を削除

## 機能を部分的に削除する手順

ログイン方式単位で消せる。

Google / Apple / 電話番号は login_screen.dart の `_showOtherMethods`（ボトムシート）に集約してあるので、
消すのはその中の `ListTile` 1つ。**画面本体にログインボタンを平置きしないこと**（DESIGN.md §6 でボタン数を1つに絞った構成）。

- **電話番号ログイン**: `phone_login_*.dart` 3ファイル削除、routes.dart の `PhoneLoginRoute`、login_screen.dart のボトムシート内 `ListTile`、auth_repository.dart の `sendPhoneOtp` / `verifyPhoneOtp`、arb の `phone*` / `authPhone*` / `authOtp*` キー、`test/design_layout_test.dart` の `'phoneLogin'` 行
- **Google ログイン**: login_screen.dart のボトムシート内 `ListTile`、login_view_model.dart の `signInWithGoogle`、auth_repository.dart の `signInWithGoogle`、pubspec の `google_sign_in`、arb の `loginWithGoogle`、AppEnv と env/*.json の `GOOGLE_*`
- **Apple ログイン**: 同様に `signInWithApple` 関連と pubspec の `sign_in_with_apple`、arb の `loginWithApple`
- 3つすべて消す場合は「他の方法でログイン」の TextButton と `_showOtherMethods`、arb の `authOtherMethods` も消す

## この機能を丸ごと削除する手順（認証なしアプリにする）

1. `lib/features/auth/` を削除する
2. `lib/core/auth/` を削除する（settings のログアウト/退会、profile も認証前提のため同時に削除が必要）
3. `lib/core/router/routes.dart` から auth 画面の import 4行と `LoginRoute` / `SignupRoute` / `PasswordResetRoute` / `PhoneLoginRoute`（`@TypedGoRoute` ブロック含む）を削除する
4. `lib/core/router/app_router.dart` の redirect と refreshListenable、auth_providers の import を削除する
5. `lib/main.dart` の `Supabase.initialize` を削除する（Supabase 自体を使わない場合）
6. pubspec.yaml から `google_sign_in` / `sign_in_with_apple` / `crypto`（他で未使用なら）を削除する
7. arb から `login*` / `signup*` / `passwordReset*` / `phone*` / `auth*` キーを削除する
8. `test/widget_test.dart` の認証 override を削除する
9. `test/design_layout_test.dart` の `screens` から auth 4画面の行と認証系 override を削除する
10. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
11. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
