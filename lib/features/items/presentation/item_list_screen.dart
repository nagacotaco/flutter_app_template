import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/widgets/display_header.dart';
import 'package:flutter_app_template/core/widgets/empty_view.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_state.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アイテム一覧画面。
/// このファイル一式（screen / view_model / state）がテンプレートの見本実装（正）。
/// 画面の書き方に迷ったらここを丸写しする（docs/ARCHITECTURE.md）。
///
/// 見た目は Pure Mono（DESIGN.md §6）。AppBar は置かず、画面の主張は冒頭の
/// [DisplayHeader]（小見出し＋日付＋件数の大型数値）が担う。
/// 行は Divider も chevron も持たず、**行間 20 と字の太さだけ**で区切る。
class ItemListScreen extends HookConsumerWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemListViewModelProvider);
    final l10n = context.l10n;
    // 取得前は件数を出さない（0 と読み違えさせないため）
    final count = state.value?.items.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.xl,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: DisplayHeader(
                title: l10n.itemsTitle,
                meta: MaterialLocalizations.of(
                  context,
                ).formatFullDate(DateTime.now()),
                display: count?.toString(),
                displayUnit: count == null ? null : l10n.itemsCountUnit,
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            Expanded(
              child: switch (state) {
                AsyncData(:final value) => _Body(state: value),
                AsyncError(:final error) => ErrorView(
                  error: error,
                  onRetry: () =>
                      ref.read(itemListViewModelProvider.notifier).refresh(),
                ),
                // リスト画面のローディングは共通スケルトンを使う（docs/ARCHITECTURE.md）
                _ => const SkeletonListView(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final ItemListState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 空状態は共通の EmptyView を使う（docs/ARCHITECTURE.md）
    if (state.items.isEmpty) {
      return EmptyView(
        title: context.l10n.itemsEmptyMessage,
        body: context.l10n.itemsEmptyBody,
      );
    }
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onSurface,
      backgroundColor: Theme.of(context).colorScheme.surface,
      onRefresh: () => ref.read(itemListViewModelProvider.notifier).refresh(),
      child: ListView.separated(
        padding: AppSpacing.screenPadding,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.items.length,
        // Divider は使わない。区切りは余白だけ（DESIGN.md §4）
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSpacing.item),
        itemBuilder: (context, index) {
          final item = state.items[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(
              item.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => ItemDetailRoute(id: item.id).go(context),
          );
        },
      ),
    );
  }
}
