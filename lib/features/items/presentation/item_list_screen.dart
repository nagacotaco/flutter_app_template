import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_state.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アイテム一覧画面。
/// このファイル一式（screen / view_model / state）がテンプレートの見本実装（正）。
/// 画面の書き方に迷ったらここを丸写しする（docs/ARCHITECTURE.md）。
class ItemListScreen extends HookConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemListViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.itemsTitle)),
      body: switch (state) {
        AsyncData(:final value) => _Body(state: value),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.read(itemListViewModelProvider.notifier).refresh(),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final ItemListState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.read(itemListViewModelProvider.notifier).refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = state.items[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(
              item.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => ItemDetailRoute(id: item.id).go(context),
          );
        },
      ),
    );
  }
}
