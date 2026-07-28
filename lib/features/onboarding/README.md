# onboarding

初回起動時のウォークスルー（3ページの PageView。内容はプレースホルダーで、コピー先アプリで差し替える）。

- 完了フラグは shared_preferences（キー `onboarding.completed`）。`data/onboarding_providers.dart` の `OnboardingCompleted` が保持し、router の redirect が未完了時に `/onboarding` へ誘導する
- 完了/スキップすると redirect が次の画面（未ログインならログイン、ログイン済みならホーム）へ進める
- ページの追加・削除は `presentation/onboarding_screen.dart` の `pages` リストと arb の `onboardingTitle*` / `onboardingBody*` を編集する

## この機能を削除する手順

1. `lib/features/onboarding/` を削除する
2. `test/features/onboarding/` を削除する
3. `lib/core/router/routes.dart` から onboarding_screen の import と `OnboardingRoute`（`@TypedGoRoute` ブロック含む）を削除する
4. `lib/core/router/app_router.dart` から onboarding_providers の import、`onboardingCompletedProvider` の listen 1行、redirect のオンボーディング分岐（先頭の if 2つ）を削除する
5. arb から `onboarding` で始まるキー（ja は `@onboarding...` も）を削除する
6. `test/widget_test.dart` / `test/auth_redirect_test.dart` の `SharedPreferences.setMockInitialValues` から `onboarding.completed` を削除する
7. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
8. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
