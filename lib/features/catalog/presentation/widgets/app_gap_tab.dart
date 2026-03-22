import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/core/widgets/app_gap.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/catalog_card.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/section_label.dart';

class AppGapTab extends StatelessWidget {
  const AppGapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      children: [
        const SectionLabel(title: 'AppGap', desc: '親 Flex の方向を自動検出するギャップ'),
        AppSpacing.gapVMd,
        CatalogCard(
          label: 'Column 内での使用（垂直ギャップ）',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GapBox(label: 'Item A'),
              const AppGap.xs(),
              _GapBox(label: 'xs (4dp)'),
              const AppGap.sm(),
              _GapBox(label: 'sm (8dp)'),
              const AppGap.md(),
              _GapBox(label: 'md (16dp)'),
              const AppGap.lg(),
              _GapBox(label: 'lg (24dp)'),
            ],
          ),
        ),
        AppSpacing.gapVMd,
        CatalogCard(
          label: 'Row 内での使用（水平ギャップ）',
          child: Row(
            children: [
              _GapBox(label: 'A'),
              const AppGap.xs(),
              _GapBox(label: 'xs'),
              const AppGap.sm(),
              _GapBox(label: 'sm'),
              const AppGap.md(),
              _GapBox(label: 'md'),
              const AppGap.lg(),
              _GapBox(label: 'lg'),
            ],
          ),
        ),
        AppSpacing.gapVMd,
        CatalogCard(
          label: '任意サイズ AppGap(value)',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GapBox(label: 'Top'),
              AppGap(AppSpacing.xxl),
              _GapBox(label: 'xxl (40dp) 下'),
            ],
          ),
        ),
        AppSpacing.gapVXl,
      ],
    );
  }
}

class _GapBox extends StatelessWidget {
  const _GapBox({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.borderSm,
      ),
      child: Text(label, style: AppTextStyles.labelSmall),
    );
  }
}
