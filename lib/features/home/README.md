# home

ボトムナビゲーションの初期タブとなるホーム画面。**差し替え前提の雛形**。

「主数値（大型タイポ）＋ラベル値ペア2個＋直近3件＋差し替え領域」という骨格だけを持つ（DESIGN.md §6）。

- `domain/home_summary.dart` — ホームに出す概要のモデル
- `data/home_summary_repository.dart` — **中身が固定のダミー Repository**
- `presentation/` — Screen / ViewModel / State
- `test/features/home/` — ViewModel ユニットテスト

他 feature（items 等）を参照していないのは意図的。feature 間 import は禁止で、`features/items/` を削除してもホームが壊れないようにするため（docs/ARCHITECTURE.md §7）。

## コピー先アプリでの作り替え

1. `data/home_summary_repository.dart` の中身を自分の API / DB 呼び出しに置き換える
2. `domain/home_summary.dart` のフィールド名を自分のドメインに合わせる
3. `lib/core/l10n/arb/` の `homePlaceholder*` 5件を実際の文言に差し替える（ARB 末尾に1ブロックで固めてある）
4. 画面の骨格（DisplayHeader / LabelValue / 直近リスト / 差し替え領域）は残す

## この機能を削除する手順

ホームは初期表示タブ（`lib/core/router/app_router.dart` の `initialLocation`）のため、単純削除ではなく**別画面への置き換え**を基本とする。

1. `lib/features/home/` と `test/features/home/` を削除する
2. `lib/core/router/routes.dart` から以下を削除する
   - `home_screen.dart` の import
   - `TypedStatefulShellBranch<HomeBranch>(...)` のブロック
   - `HomeBranch` / `HomeRoute` クラス
3. `lib/core/router/app_router.dart` の `initialLocation` を、初期表示にしたい feature のルートへ変更する
4. `lib/core/router/app_shell.dart` からホームタブの `NavigationDestination`（`homeTitle` を使う項目）を削除する
5. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `homeTitle` / `homeEmptyTitle` / `homeEmptyBody` / `homePlaceholder*` 5件（ja は `@` 付きの説明も）を削除する
6. `test/widget_test.dart` の検証文言を新しい初期画面に合わせて修正する
7. `test/design_layout_test.dart` の `screens` から `'home'` の行を削除する
8. 再生成する: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
9. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
