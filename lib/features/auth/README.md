# auth

Supabase 認証の画面群（メール+パスワード / 電話番号 OTP / Google / Apple）。
認証操作の実体は `lib/core/auth/auth_repository.dart`、ログイン状態は `lib/core/auth/auth_providers.dart`（settings / profile も使うため core 配下）。
未ログイン時の `/login` への誘導は `lib/core/router/app_router.dart` の redirect。

## 動作に必要な設定

- **メール / 電話番号**: `env/dev.json` に `SUPABASE_URL` / `SUPABASE_ANON_KEY` を設定。電話番号は SMS プロバイダ未契約でも Supabase ダッシュボード（Auth > Providers > Phone）のテスト用電話番号+OTP で確認できる
- **パスワード再設定**: メール内リンクは Web で開く。アプリ内で完結させたい場合はディープリンク設定（docs/DEEP_LINKS.md）後に redirectTo を指定する
- **Google**: Google Cloud Console で OAuth クライアント（Web + iOS + Android）を作成し、Web クライアント ID を Supabase（Auth > Providers > Google）と `env/*.json` の `GOOGLE_WEB_CLIENT_ID` に設定。iOS は `GOOGLE_IOS_CLIENT_ID` も設定し、Info.plist に reversed client ID の URL scheme を追加
- **Apple**: Apple Developer で Sign in with Apple を有効化し、Xcode で Runner に Capability「Sign in with Apple」を追加。Supabase（Auth > Providers > Apple）にも設定
- **退会**: `supabase/migrations/` の `delete_account` 関数をマイグレーション適用しておくこと

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
