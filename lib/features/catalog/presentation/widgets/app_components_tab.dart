import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/core/widgets/app_avatar.dart';
import 'package:flutter_app_template/core/widgets/app_card.dart';
import 'package:flutter_app_template/core/widgets/app_chip.dart';
import 'package:flutter_app_template/core/widgets/app_divider.dart';
import 'package:flutter_app_template/core/widgets/app_gap.dart';
import 'package:flutter_app_template/core/widgets/app_loading_indicator.dart';

import 'catalog_card.dart';
import 'section_label.dart';

class AppComponentsTab extends StatefulWidget {
  const AppComponentsTab({super.key});

  @override
  State<AppComponentsTab> createState() => _AppComponentsTabState();
}

class _AppComponentsTabState extends State<AppComponentsTab> {
  bool _chipA = true;
  bool _chipB = false;
  bool _chipC = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        // ── AppStatusChip ──────────────────────────────────────
        const SectionLabel(title: 'AppStatusChip', desc: 'success / warning / error / neutral'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppStatusChip — ステータスラベル',
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: const [
              AppStatusChip(label: '公開中', variant: AppChipVariant.success),
              AppStatusChip(label: '審査中', variant: AppChipVariant.warning),
              AppStatusChip(label: 'エラー', variant: AppChipVariant.error),
              AppStatusChip(label: '下書き', variant: AppChipVariant.neutral),
              AppStatusChip(
                label: 'ドットなし',
                variant: AppChipVariant.success,
                showDot: false,
              ),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppFilterChip — フィルターチップ',
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppFilterChip(
                label: 'カテゴリ A',
                selected: _chipA,
                onSelected: (v) => setState(() => _chipA = v),
              ),
              AppFilterChip(
                label: 'カテゴリ B',
                selected: _chipB,
                onSelected: (v) => setState(() => _chipB = v),
              ),
              AppFilterChip(
                label: 'カテゴリ C',
                selected: _chipC,
                onSelected: (v) => setState(() => _chipC = v),
              ),
            ],
          ),
        ),
        AppSpacing.gapVLg,

        // ── AppAvatar ──────────────────────────────────────────
        const SectionLabel(title: 'AppAvatar', desc: 'xs / sm / md / lg'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppAvatar — サイズバリエーション',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _avatarWithLabel('xs', const AppAvatar(size: AppAvatarSize.xs)),
              _avatarWithLabel('sm', const AppAvatar(size: AppAvatarSize.sm)),
              _avatarWithLabel('md', const AppAvatar(size: AppAvatarSize.md)),
              _avatarWithLabel('lg', const AppAvatar(size: AppAvatarSize.lg)),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppAvatar — イニシャル',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _avatarWithLabel(
                'initials',
                const AppAvatar(initials: 'AB', size: AppAvatarSize.lg),
              ),
              _avatarWithLabel(
                'initials',
                AppAvatar(
                  initials: 'YK',
                  size: AppAvatarSize.lg,
                  backgroundColor: AppColors.accent.withValues(alpha: 0.15),
                ),
              ),
              _avatarWithLabel(
                'no image',
                const AppAvatar(size: AppAvatarSize.lg),
              ),
            ],
          ),
        ),
        AppSpacing.gapVLg,

        // ── AppCard ────────────────────────────────────────────
        const SectionLabel(title: 'AppCard', desc: 'elevation / onTap'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppCard — タップ可能',
          child: AppCard(
            onTap: () {},
            child: Row(
              children: [
                const AppAvatar(initials: 'JD'),
                const AppGap.md(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe', style: AppTextStyles.titleSmall),
                      Text(
                        'タップして詳細を表示',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ),
        ),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppCard — elevation バリエーション',
          child: Column(
            children: [
              AppCard(
                elevation: 0,
                child: const Text('elevation: 0（枠線なし・影なし）'),
              ),
              const AppGap.sm(),
              AppCard(
                child: const Text('elevation: 1（デフォルト）'),
              ),
              const AppGap.sm(),
              AppCard(
                elevation: 4,
                child: const Text('elevation: 4'),
              ),
            ],
          ),
        ),
        AppSpacing.gapVLg,

        // ── AppDivider ─────────────────────────────────────────
        const SectionLabel(title: 'AppDivider', desc: 'horizontal / vertical'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppDivider — 水平',
          child: const Column(
            children: [
              Text('セクション A'),
              AppGap.md(),
              AppDivider(),
              AppGap.md(),
              Text('セクション B'),
              AppGap.md(),
              AppDivider(indent: 16),
              AppGap.md(),
              Text('インデントあり'),
            ],
          ),
        ),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppVerticalDivider — 垂直',
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Left'),
                AppVerticalDivider(),
                Text('Center'),
                AppVerticalDivider(),
                Text('Right'),
              ],
            ),
          ),
        ),
        AppSpacing.gapVLg,

        // ── AppLoadingIndicator ────────────────────────────────
        const SectionLabel(title: 'AppLoadingIndicator', desc: 'sm / md / lg'),
        AppSpacing.gapVSm,
        const Divider(color: AppColors.border),
        AppSpacing.gapVMd,

        CatalogCard(
          label: 'AppLoadingIndicator — サイズ',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _indicatorWithLabel('sm', const AppLoadingIndicator(size: AppLoadingSize.sm)),
              _indicatorWithLabel('md', const AppLoadingIndicator(size: AppLoadingSize.md)),
              _indicatorWithLabel('lg', const AppLoadingIndicator(size: AppLoadingSize.lg)),
              _indicatorWithLabel(
                'custom',
                const AppLoadingIndicator(
                  size: AppLoadingSize.lg,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }

  Widget _avatarWithLabel(String label, Widget avatar) {
    return Column(
      children: [
        avatar,
        const AppGap.xs(),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _indicatorWithLabel(String label, Widget indicator) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        indicator,
        const AppGap.xs(),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}
