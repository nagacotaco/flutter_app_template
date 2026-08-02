# 画面アーキテクチャルール

画面（Screen）と状態管理の書き方を定める厳格ルール。**画面を新規作成・変更する前に必ず読むこと。**

- このルールと見本実装（`features/items/`、Phase 1 で作成）がズレた場合は**見本実装が正**。ズレに気づいたらこのドキュメントを直す
- ルールの変更はこのファイルの更新をもって行う。コードレビュー時の指摘根拠もこのファイル
- **このファイルは「構造」の正、`DESIGN.md` は「見た目」の正。** 色・タイポグラフィ・余白・共通コンポーネントの見え方は `DESIGN.md`（Pure Mono）に従う。衝突したらこのファイルが優先で、`DESIGN.md` 側を直す

---

## 1. feature 内の層構造と依存の向き

1つの feature は最大3層で構成する。

```
features/items/
├── domain/       # ドメインモデル（Item 等）。画面と無関係に存在するビジネスデータの定義
├── data/         # Repository。Supabase 等の外部サービスとのやりとり
└── presentation/ # Screen / ViewModel / State。画面表示の関心事すべて
```

- **依存の向きは presentation → data → domain の一方向のみ。** 逆向きの import（domain から presentation 等）は禁止
- **画面 State とドメインモデルを混同しない。** `ItemListState` が `List<Item>` を持つのは正しい。`Item` クラス自体を presentation 配下に定義したら違反（domain/ に置く）
- Repository は `@riverpod` でプロバイダ化し、ViewModel から `ref` 経由で取得する
- 静的画面のみ等で domain/ data が不要な feature は presentation/ だけでよい。空ディレクトリを作らない
- 複数 feature から使うモデル・Repository（ログインユーザー等）は feature に置かず `core/` に置く

## 2. 基本形: 1画面 = 3ファイル

1つの画面は次の3ファイルで構成する。配置は `features/<feature>/presentation/`。

```
features/home/presentation/
├── home_screen.dart       # 画面。HookConsumerWidget
├── home_view_model.dart   # ViewModel。@riverpod の Notifier クラス
└── home_state.dart        # 画面状態。freezed の不変クラス
```

命名は `<画面名>_screen` / `<画面名>_view_model` / `<画面名>_state` で固定。クラス名は `HomeScreen` / `HomeViewModel` / `HomeState`。

### 責務の分離（違反禁止）

| ファイル | やること | 禁止事項 |
|---|---|---|
| Screen | UI 構築、ViewModel の watch、ユーザー操作を ViewModel のメソッド呼び出しに変換 | ビジネスロジック、Repository/Supabase の直接呼び出し、状態の保持 |
| ViewModel | 状態の生成・更新、Repository 呼び出し、ビジネスロジック | BuildContext への依存、Widget の import |
| State | 画面状態の定義のみ | ロジック（導出値の getter は可） |

## 3. 各ファイルの書き方

### State（freezed）

```dart
// home_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Item> items,
    @Default('') String searchQuery,
  }) = _HomeState;

  const HomeState._();

  // 導出値は getter で持つ（Screen 側で計算しない）
  bool get hasResults => items.isNotEmpty;
}
```

- 状態は必ず1クラスに集約する。ViewModel に State 以外のフィールドを生やさない
- `isLoading` / `hasError` のような bool フラグの乱立は禁止。ローディング/エラーは AsyncValue（下記）で表現する

### ViewModel（riverpod_generator）

初期表示に非同期取得が必要な画面（大半がこれ）は `Future<State> build()` にする。
ローディング/エラー表現は Riverpod の `AsyncValue` に任せる。

```dart
// home_view_model.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final items = await ref.watch(itemRepositoryProvider).fetchItems();
    return HomeState(items: items);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await ref.read(itemRepositoryProvider).fetchItems();
      return HomeState(items: items);
    });
  }

  void updateSearchQuery(String query) {
    // Riverpod 3 では AsyncValue.value が null 許容（旧 valueOrNull 相当）
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(searchQuery: query));
  }
}
```

- 非同期取得が一切ない画面のみ同期 `HomeState build()` でよい
- 更新系の失敗は `AsyncValue.guard` で state に反映する。try-catch の握りつぶし禁止

### Screen（HookConsumerWidget）

```dart
// home_screen.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.homeTitle)),
      body: switch (state) {
        AsyncData(:final value) => _Body(state: value),
        AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () => ref.read(homeViewModelProvider.notifier).refresh(),
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
```

- 基底クラスは `HookConsumerWidget` に統一（hooks を使わない画面でも同じ。基底クラスの選択で迷わない）
- `StatefulWidget` / `setState` は全面禁止。一時的な UI 状態（TextEditingController、タブ index 等）は flutter_hooks（`useTextEditingController` 等）を使う
- AsyncValue の分岐は上記の `switch` パターンに統一。エラー・ローディング・空状態は共通ウィジェット（`core/widgets/`）を使う
  - エラー: `ErrorView(error:, onRetry:)`。画面遷移を伴わない操作の失敗（保存・ログイン等）は画面を潰さず `InlineError(message:)` を該当箇所の直下に出す。**SnackBar は使わない**
  - ローディング: リスト画面は `SkeletonListView()`、詳細・プロフィール系は `SkeletonListView(variant: SkeletonVariant.detail)`。この2形で足りないレイアウトのみ実レイアウトを `Skeletonizer(enabled: true, child: ...)` で包む（skeletonizer パッケージ）。スピナー（CircularProgressIndicator）はダイアログ内などスケルトンが作れない場面のみ
  - 空状態: `EmptyView(title: context.l10n.xxx, body:, action:)`。データが空のときに素のリストを出さない
  - `EmptyView` / `ErrorView` / `SkeletonListView` は左右パディングを自分で持つ。呼び出し側で重ねてつけない
- ダイアログは `AppDialog.show<T>(context, title:, message:, actions: (dialogContext) => [...])`、ボトムシートは `AppBottomSheet.show<T>(context, title:, children: (sheetContext) => [...])` を使う。`AlertDialog` / `showModalBottomSheet` を画面側で直接組まない（ボタン縦積み・パディング・SafeArea の統一を core 側に閉じるため）
- 入力欄は `LabeledField(label:, child: TextField(...))` で組む（floatingLabel は使わない）。ラベル＋値の表示は `LabelValue(label:, value:, mono:)`、画面冒頭の見出しは `DisplayHeader(title:, meta:, display:, displayUnit:)`
- ネットワーク画像は `AppNetworkImage(url:)` / アバターは `AppAvatar(url:, size:, initials:)`（core/widgets）を使う。`size` は直径。`Image.network` / `NetworkImage` / `CachedNetworkImage` を feature 側で直接使わない（ディスクキャッシュの統一と、画像パッケージの差し替え・削除を core 1ファイルに閉じるため）
- 画面内の部分 Widget は同ファイル内のプライベートクラス（`_Body` 等）に切り出す。ビルダーメソッド（`Widget _buildBody()`）は禁止
- 色・文字サイズ・ウェイト・余白を画面側にハードコードしない。色と字は `Theme.of(context).colorScheme` / `textTheme`、余白は `AppSpacing` / `AppRadius` / `AppSize` 経由で参照し、値の定義は `lib/core/theme/` に閉じる（トークンとコンポーネント仕様は `DESIGN.md` §2〜§5 が正）
- 画面を追加したら `test/design_layout_test.dart` の `screens` に1行足す。全画面をライト/ダーク × 日本語/英語で描画し、はみ出し（RenderFlex overflow）が出ないことを見るテスト

## 4. ViewModel を共有してよい判断基準

デフォルトは **1画面 = 1 ViewModel**。以下を**すべて**満たす場合のみ、複数画面で1つの ViewModel を共有してよい。

| 基準 | 条件 |
|---|---|
| 画面間の関係 | 1つのフロー（複数ステップの入力フォーム、ウィザード）である |
| 状態のライフサイクル | フロー全体で同じデータを引き回し、同時に生成・破棄される |
| 画面数 | 最大3画面。4画面以上になったら分割を検討する |
| 変更頻度 | 各画面が独立に拡張される見込みが薄い（確認画面・完了画面など） |

共有する場合、ファイルはフローのディレクトリ直下に置く:

```
features/signup/presentation/
├── signup_flow_view_model.dart   # 共有 ViewModel
├── signup_flow_state.dart
├── signup_input_screen.dart
├── signup_confirm_screen.dart
└── signup_complete_screen.dart
```

迷ったら分ける。共有は「明確に該当する」場合の例外である。

## 5. ViewModel を省略してよい条件

状態を一切持たない静的画面（リンク一覧だけの設定画面、利用規約表示など）は Screen 単体でよい。
ただし基底クラスは `HookConsumerWidget` のまま（後から状態が増えたときの差分を最小にする）。

1つでも状態や非同期取得が入った時点で、3ファイル構成に移行すること。中間形態（Screen 内に状態を持つ等）を作らない。

## 6. ViewModel のユニットテスト

ViewModel を追加したら、対応するユニットテストを `test/features/<feature>/presentation/` に置く（lib と同じディレクトリ構成をミラーする）。見本は `test/features/items/`。

書き方の標準パターン:

- Repository は**手書きの fake** に差し替える（mockito 等のモックパッケージは使わない）。fake は `test/features/<feature>/fake_xxx_repository.dart` に置く
- コンテナは `test/helpers/create_container.dart` の `createContainer(overrides: [...])` で作る（テスト終了時に自動 dispose。Riverpod 3 のビルド失敗時自動リトライも無効化済み）
- `@riverpod` は autoDispose のため、`container.listen(provider, (_, _) {})` で provider を保持してから検証する
- 初期表示は `await container.read(provider.future)` で取得した State を検証する
- 更新系メソッドは notifier 経由で呼び、`container.read(provider)` の AsyncValue を検証する。失敗系（`AsyncError` になること）も必ず1本書く

```dart
test('build: Repository から取得したアイテムが state に入る', () async {
  final repository = FakeItemRepository();
  final container = createContainer(
    overrides: [itemRepositoryProvider.overrideWithValue(repository)],
  );
  container.listen(itemListViewModelProvider, (_, _) {});

  final state = await container.read(itemListViewModelProvider.future);

  expect(state.items, FakeItemRepository.defaultItems);
});
```

注意: Riverpod 3 では `Override` 型は `package:hooks_riverpod/misc.dart` からエクスポートされる（`hooks_riverpod.dart` には含まれない）。

## 7. その他の禁止事項

- feature をまたぐ import（`features/a/` から `features/b/` を import）は禁止。画面遷移は router 経由、データ共有は `core/` または Repository 経由
- Screen から Repository・Supabase クライアントを直接呼ばない。必ず ViewModel を経由する
- グローバルな状態（ログインユーザー等）は画面の ViewModel に持たせず、`core/` 配下の専用 Provider に置く
