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
- **電話番号**: 同 Phone を有効化。SMS 契約不要のテスト電話番号 + 固定 OTP を登録して確認する（実 SMS は Blaze プラン必須）。iOS 実機で本番利用する場合は APNs 設定が別途必要
- **Google**: 同 Google を有効化。表示される Web クライアント ID を `env/*.json` の `GOOGLE_WEB_CLIENT_ID` に設定（Android で必須）。iOS は `GOOGLE_IOS_CLIENT_ID` も設定し、Info.plist に reversed client ID の URL scheme を追加
- **Apple**: 同 Apple を有効化し、Xcode で Runner に Capability「Sign in with Apple」を追加
- **退会**: 最終ログインから時間が経つと requires-recent-login エラーになる（再ログイン後に退会し直す仕様）

## 動作に必要な設定（Supabase 使用時）

- **メール / 電話番号**: `env/dev.json` に `SUPABASE_URL` / `SUPABASE_ANON_KEY` を設定。電話番号は SMS プロバイダ未契約でも Supabase ダッシュボード（Auth > Providers > Phone）のテスト用電話番号+OTP で確認できる
- **パスワード再設定**: メール内リンクは Web で開く。アプリ内で完結させたい場合はディープリンク設定（docs/DEEP_LINKS.md）後に redirectTo を指定する
- **Google**: Google Cloud Console で OAuth クライアント（Web + iOS + Android）を作成し、Web クライアント ID を Supabase（Auth > Providers > Google）と `env/*.json` の `GOOGLE_WEB_CLIENT_ID` に設定。iOS は `GOOGLE_IOS_CLIENT_ID` も設定し、Info.plist に reversed client ID の URL scheme を追加
- **Apple**: Apple Developer で Sign in with Apple を有効化し、Xcode で Runner に Capability「Sign in with Apple」を追加。Supabase（Auth > Providers > Apple）にも設定
- **退会**: `supabase/migrations/` の `delete_account` 関数をマイグレーション適用しておくこと

## 使わないバックエンドを削除する手順

- **Supabase を削除**（Firebase 採用時）: `lib/core/auth/supabase_auth_repository.dart` と `lib/core/supabase/` を削除し、`auth_repository.dart` の switch と import、`lib/core/backend.dart` の enum 値、`main.dart` の Supabase 分岐を削除。pubspec から `supabase_flutter` を削除。`supabase/` ディレクトリも削除。profile feature は現状 Supabase 依存のため対応方針を決めてから消すこと
- **Firebase を削除**（Supabase 採用時）: `lib/core/auth/firebase_auth_repository.dart` と `lib/core/firebase/`、`firebase.json` を削除し、同様に switch / enum / main.dart の分岐を削除。pubspec から `firebase_core` / `firebase_auth` を削除

## 機能を部分的に削除する手順

ログイン方式単位で消せる。

- **電話番号ログイン**: `phone_login_*.dart` 3ファイル削除、routes.dart の `PhoneLoginRoute`、login_screen.dart の該当ボタン、auth_repository.dart の `sendPhoneOtp` / `verifyPhoneOtp`、arb の `phone*` / `authPhone*` / `authOtp*` キー
- **Google ログイン**: login_screen.dart の該当ボタン、login_view_model.dart の `signInWithGoogle`、auth_repository.dart の `signInWithGoogle`、pubspec の `google_sign_in`、arb の `loginWithGoogle`、AppEnv と env/*.json の `GOOGLE_*`
- **Apple ログイン**: 同様に `signInWithApple` 関連と pubspec の `sign_in_with_apple`、arb の `loginWithApple`

## この機能を丸ごと削除する手順（認証なしアプリにする）

1. `lib/features/auth/` を削除する
2. `lib/core/auth/` を削除する（settings のログアウト/退会、profile も認証前提のため同時に削除が必要）
3. `lib/core/router/routes.dart` から auth 画面の import 4行と `LoginRoute` / `SignupRoute` / `PasswordResetRoute` / `PhoneLoginRoute`（`@TypedGoRoute` ブロック含む）を削除する
4. `lib/core/router/app_router.dart` の redirect と refreshListenable、auth_providers の import を削除する
5. `lib/main.dart` の `Supabase.initialize` を削除する（Supabase 自体を使わない場合）
6. pubspec.yaml から `google_sign_in` / `sign_in_with_apple` / `crypto`（他で未使用なら）を削除する
7. arb から `login*` / `signup*` / `passwordReset*` / `phone*` / `auth*` キーを削除する
8. `test/widget_test.dart` の認証 override を削除する
9. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
10. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
