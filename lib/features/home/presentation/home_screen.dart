import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/widgets/display_header.dart';
import 'package:flutter_app_template/core/widgets/empty_view.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/label_value.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/home/presentation/home_state.dart';
import 'package:flutter_app_template/features/home/presentation/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面（ボトムナビの1タブ）。
///
/// **差し替え前提の雛形**。「主数値（displayLarge）＋ LabelValue 2個＋直近3件＋
/// 差し替え領域」という骨格だけを持ち、作り込みはしない（DESIGN.md §6）。
/// データは `features/home/data/home_summary_repository.dart` のダミー値。
/// コピー先アプリでは Repository の中身と `homePlaceholder*` の文言を置き換える。
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final l10n = context.l10n;
    final count = state.value?.summary.primaryCount;

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
                title: l10n.homeTitle,
                meta: MaterialLocalizations.of(
                  context,
                ).formatFullDate(DateTime.now()),
                display: count?.toString(),
                displayUnit: count == null
                    ? null
                    : l10n.homePlaceholderPendingUnit,
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            Expanded(
              child: switch (state) {
                AsyncData(:final value) => _Body(state: value),
                AsyncError(:final error) => ErrorView(
                  error: error,
                  onRetry: () =>
                      ref.read(homeViewModelProvider.notifier).refresh(),
                ),
                _ => const SkeletonListView(itemCount: 4),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final summary = state.summary;

    if (summary.isEmpty) {
      return EmptyView(
        title: l10n.homeEmptyTitle,
        body: l10n.homeEmptyBody,
        action: FilledButton(
          onPressed: () => const ItemsRoute().go(context),
          child: Text(l10n.homePlaceholderViewItems),
        ),
      );
    }

    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LabelValue(
                label: l10n.homePlaceholderWeeklyDone,
                value: summary.weeklyDoneCount.toString(),
                mono: true,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: LabelValue(
                label: l10n.homePlaceholderLastSync,
                value: summary.lastSyncLabel,
                mono: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.section),
        Text(
          l10n.homePlaceholderRecentItems,
          style: theme.textTheme.labelSmall,
        ),
        const SizedBox(height: AppSpacing.md),
        for (final item in summary.recentItems)
          ListTile(title: Text(item.title), subtitle: Text(item.subtitle)),
        const SizedBox(height: AppSpacing.section),
        // 差し替え領域。コピー先アプリのメインウィジェットをここへ置く。
        // 枠線やプレースホルダー文言は置かない（面を作らないため）。
        const AspectRatio(aspectRatio: 16 / 9, child: SizedBox.expand()),
      ],
    );
  }
}
