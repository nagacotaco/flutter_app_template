# home

ボトムナビゲーションの初期タブとなるホーム画面。
現状は状態を持たない静的画面のため `presentation/` のみ・ViewModel なし（docs/ARCHITECTURE.md §5）。状態や非同期取得が入った時点で Screen/ViewModel/State の3ファイル構成に移行すること。

## この機能を削除する手順

ホームは初期表示タブ（`lib/core/router/app_router.dart` の `initialLocation`）のため、単純削除ではなく**別画面への置き換え**を基本とする。

1. `lib/features/home/` を削除する
2. `lib/core/router/routes.dart` から以下を削除する
   - `home_screen.dart` の import
   - `TypedStatefulShellBranch<HomeBranch>(...)` のブロック
   - `HomeBranch` / `HomeRoute` クラス
3. `lib/core/router/app_router.dart` の `initialLocation` を、初期表示にしたい feature のルートへ変更する
4. `lib/core/router/app_shell.dart` からホームタブの `NavigationDestination`（`homeTitle` を使う項目）を削除する
5. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `homeTitle`（ja は `@homeTitle` も）を削除する
6. `test/widget_test.dart` の検証文言を新しい初期画面に合わせて修正する
7. 再生成する: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
8. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
