# settings

設定画面。テーマ切替・言語切替、プロフィールへの導線、利用規約/プライバシーポリシーリンク、アプリバージョン表示、ログアウト、退会を持つ。

- テーマ・言語の状態と永続化（shared_preferences）はグローバル状態のため `lib/core/settings/` にある
- ログアウト/退会は `lib/core/auth/auth_repository.dart` を呼ぶ
- 規約等の URL は `lib/core/constants/app_links.dart`（コピー先で必ず差し替える）

## この機能を削除する手順

1. `lib/features/settings/` を削除する
2. `test/features/settings/` を削除する
3. `lib/core/router/routes.dart` から以下を削除する
   - `settings_screen.dart` の import
   - `TypedStatefulShellBranch<SettingsBranch>(...)` のブロック（Profile ルートを含むため、profile feature も同時に削除するか別タブへ移す）
   - `SettingsBranch` / `SettingsRoute` クラス
4. `lib/core/router/app_shell.dart` から設定タブの `NavigationDestination`（`settingsTitle` を使う項目）を削除する
5. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `settings` で始まるキーと `commonCancel`（他で未使用なら。ja は対応する `@...` も）を削除する
6. pubspec.yaml から `url_launcher` / `package_info_plus` を削除し（他で未使用なら）、`lib/core/constants/app_links.dart` を削除する
7. テーマ・言語のグローバル状態ごと不要な場合のみ、追加で以下を行う
   - `lib/core/settings/` を削除する
   - `lib/app/app.dart` から `appSettingsProvider` の watch と `themeMode:` / `locale:` を削除する
   - `lib/main.dart` と `test/widget_test.dart` から `sharedPreferencesProvider` の override を削除する
   - pubspec.yaml から `shared_preferences` を削除する
8. `test/design_layout_test.dart` の `screens` から `'settings'` の行を削除する
9. 再生成する: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
10. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
