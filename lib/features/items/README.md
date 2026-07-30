# items

リスト画面 → 詳細画面（`/items/:id`、ディープリンク対応）のサンプル feature。
Screen/ViewModel/State + Repository 構成の**見本実装（正）**。アーキテクチャルールは docs/ARCHITECTURE.md。

- `domain/item.dart` — ドメインモデル
- `data/item_repository.dart` — インメモリ Repository（実アプリでは Supabase 呼び出しに置き換える）
- `presentation/` — 一覧・詳細の Screen / ViewModel / State
- `test/features/items/` — ViewModel ユニットテストの見本

## この機能を削除する手順

1. `lib/features/items/` を削除する
2. `test/features/items/` を削除する
3. `lib/core/router/routes.dart` から以下を削除する
   - `item_detail_screen.dart` / `item_list_screen.dart` の import 2行
   - `TypedStatefulShellBranch<ItemsBranch>(...)` のブロック
   - `ItemsBranch` / `ItemsRoute` / `ItemDetailRoute` クラス
4. `lib/core/router/app_shell.dart` からアイテムタブの `NavigationDestination`（`itemsTitle` を使う項目）を削除する
5. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `items` で始まるキー（ja は `@items...` も）を削除する
6. `lib/features/home/presentation/home_screen.dart` の空状態 CTA（`ItemsRoute` への遷移）を差し替える
7. `test/design_layout_test.dart` の `screens` から `'itemList'` / `'itemDetail'` の行と、`itemRepositoryProvider` の override を削除する
8. 再生成する: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
9. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する

削除後は見本実装がなくなるため、画面の書き方は docs/ARCHITECTURE.md のコード例が正になる。
