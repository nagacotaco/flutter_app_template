import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/purchase/paywall_package.dart';
import 'package:flutter_app_template/core/purchase/purchase_providers.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/core/widgets/empty_view.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/core/widgets/inline_error.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/purchase/presentation/paywall_state.dart';
import 'package:flutter_app_template/features/purchase/presentation/paywall_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ペイウォール画面（雛形）。`/paywall` に全画面 push で開く。
///
/// 現在の Offering のパッケージ一覧 → 選択 → 購入 → 復元までの配管を持つ。
/// 商品が未設定（テンプレート状態）でも壊れず EmptyView になる。
/// 訴求文・特典リストなどの中身はコピー先アプリで作り込む
/// （lib/features/purchase/README.md）。
class PaywallScreen extends HookConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paywallViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.paywallTitle)),
      body: SafeArea(
        child: switch (state) {
          AsyncData(:final value) => _Body(state: value),
          AsyncError(:final error) => ErrorView(
            error: error,
            onRetry: () => ref.invalidate(paywallViewModelProvider),
          ),
          _ => const SkeletonListView(),
        },
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final PaywallState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    // 購入済み（購入・復元の直後も CustomerInfo リスナー経由でここに切り替わる）
    if (ref.watch(isProProvider)) {
      return ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.paywallProActive, style: theme.textTheme.headlineSmall),
        ],
      );
    }

    // 商品が読み込めない（テンプレート状態・ダッシュボード未設定）。
    // 機種変更ユーザーのために復元だけは常にできるようにしておく
    if (state.packages.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: EmptyView(
              title: l10n.paywallUnavailableTitle,
              body: l10n.paywallUnavailableBody,
            ),
          ),
          Padding(
            padding: AppSpacing.screenPadding,
            child: _RestoreSection(state: state),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      );
    }

    final viewModel = ref.read(paywallViewModelProvider.notifier);
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        const SizedBox(height: AppSpacing.lg),
        for (final package in state.packages) ...[
          _PackageRow(
            package: package,
            selected: package.id == state.selectedPackageId,
            onTap: state.isProcessing
                ? null
                : () => viewModel.select(package.id),
          ),
          const SizedBox(height: AppSpacing.item),
        ],
        const SizedBox(height: AppSpacing.md),
        FilledButton(
          onPressed: state.isProcessing || state.selectedPackageId == null
              ? null
              : viewModel.purchase,
          child: Text(l10n.paywallPurchaseButton),
        ),
        // エラーは SnackBar ではなく、原因になった操作の近くにインライン表示する
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppSpacing.md),
          InlineError(message: state.errorMessage!),
        ],
        const SizedBox(height: AppSpacing.item),
        _RestoreSection(state: state),
      ],
    );
  }
}

/// 「購入を復元」リンクと、その結果のインライン表示。
class _RestoreSection extends HookConsumerWidget {
  const _RestoreSection({required this.state});

  final PaywallState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            style: AppButtonStyles.subtleText(context),
            onPressed: state.isProcessing
                ? null
                : ref.read(paywallViewModelProvider.notifier).restore,
            child: Text(l10n.paywallRestore),
          ),
        ),
        if (state.restoreNotFound) ...[
          const SizedBox(height: AppSpacing.xs),
          InlineError(message: l10n.paywallRestoreNotFound),
        ],
      ],
    );
  }
}

/// パッケージ1件の行。選択は色ではなく**塗り**で示す（DESIGN.md §4。角丸 0）。
class _PackageRow extends StatelessWidget {
  const _PackageRow({
    required this.package,
    required this.selected,
    required this.onTap,
  });

  final PaywallPackage package;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = selected
        ? theme.colorScheme.surface
        : theme.colorScheme.onSurface;
    final secondary = selected
        ? theme.colorScheme.surface
        : theme.colorScheme.onSurfaceVariant;

    return Opacity(
      // 無効（処理中）は不透明度 30% で示す（DESIGN.md §4）
      opacity: onTap == null && !selected ? 0.3 : 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: selected ? theme.colorScheme.onSurface : null,
          constraints: const BoxConstraints(minHeight: AppSize.minTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: foreground,
                      ),
                    ),
                    if (package.description.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        package.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: secondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                package.priceString,
                style: theme.textTheme.titleMedium.archivo?.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
