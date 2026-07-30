import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_state.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アイテム詳細画面。`/items/:id` のディープリンクで直接開ける。
///
/// AppBar のタイトルは小さいまま据え置き、**本文の上にタイトルを大型タイポで再掲**する
/// （AppBar だけだと長い日本語タイトルが省略されて読めないため。DESIGN.md §6）。
class ItemDetailScreen extends HookConsumerWidget {
  const ItemDetailScreen({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailViewModelProvider(itemId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.value?.item.title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: switch (state) {
          AsyncData(:final value) => _Body(state: value),
          AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(itemDetailViewModelProvider(itemId)),
          ),
          // スピナーではなく本文の形をしたスケルトンを出す（DESIGN.md §6）
          _ => const SkeletonListView(variant: SkeletonVariant.detail),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final ItemDetailState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final item = state.item;

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Text(item.title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.md),
        Text(
          context.l10n.itemsDetailMeta(item.id),
          style: theme.textTheme.bodySmall.archivo,
        ),
        const SizedBox(height: AppSpacing.section),
        Text(item.description, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
