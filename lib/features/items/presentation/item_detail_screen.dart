import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アイテム詳細画面。`/items/:id` のディープリンクで直接開ける。
class ItemDetailScreen extends HookConsumerWidget {
  const ItemDetailScreen({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailViewModelProvider(itemId));

    return Scaffold(
      appBar: AppBar(title: Text(state.value?.item.title ?? '')),
      body: switch (state) {
        AsyncData(:final value) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text(value.item.description),
          ),
        AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () =>
                ref.invalidate(itemDetailViewModelProvider(itemId)),
          ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
