# settings

テーマ切替・言語切替を行う設定画面。

設定値の状態と永続化（shared_preferences）は複数箇所（`lib/app/app.dart` の themeMode / locale）から参照されるグローバル状態のため、この feature ではなく `lib/core/settings/` にある。この feature が持つのは画面（`presentation/`）のみ。

## この機能を削除する手順

1. `lib/features/settings/` を削除する
2. `lib/core/router/routes.dart` から以下を削除する
   - `settings_screen.dart` の import
   - `TypedStatefulShellBranch<SettingsBranch>(...)` のブロック
   - `SettingsBranch` / `SettingsRoute` クラス
3. `lib/core/router/app_shell.dart` から設定タブの `NavigationDestination`（`settingsTitle` を使う項目）を削除する
4. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `settings` で始まるキー（ja は対応する `@settings...` も）を削除する
5. テーマ・言語のグローバル状態ごと不要な場合のみ、追加で以下を行う
   - `lib/core/settings/` を削除する
   - `lib/app/app.dart` から `appSettingsProvider` の watch と `themeMode:` / `locale:` を削除する
   - `lib/main.dart` と `test/widget_test.dart` から `sharedPreferencesProvider` の override を削除する
   - pubspec.yaml から `shared_preferences` を削除する
6. 再生成する: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
7. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
