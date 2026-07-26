# 画面アーキテクチャルール

画面（Screen）と状態管理の書き方を定める厳格ルール。**画面を新規作成・変更する前に必ず読むこと。**

- このルールと見本実装（`features/items/`、Phase 1 で作成）がズレた場合は**見本実装が正**。ズレに気づいたらこのドキュメントを直す
- ルールの変更はこのファイルの更新をもって行う。コードレビュー時の指摘根拠もこのファイル

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
    final current = state.valueOrNull;
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
- AsyncValue の分岐は上記の `switch` パターンに統一。エラー表示・ローディング表示は共通ウィジェット（`core/widgets/`）を使う
- 画面内の部分 Widget は同ファイル内のプライベートクラス（`_Body` 等）に切り出す。ビルダーメソッド（`Widget _buildBody()`）は禁止

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

## 6. その他の禁止事項

- feature をまたぐ import（`features/a/` から `features/b/` を import）は禁止。画面遷移は router 経由、データ共有は `core/` または Repository 経由
- Screen から Repository・Supabase クライアントを直接呼ばない。必ず ViewModel を経由する
- グローバルな状態（ログインユーザー等）は画面の ViewModel に持たせず、`core/` 配下の専用 Provider に置く
