import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

enum AppChipVariant { success, warning, error, neutral }

/// ステータスを示すラベルチップ。
///
/// [AppChipVariant] に対応する背景色・テキスト色・ドット色を自動的に適用する。
class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.label,
    required this.variant,
    this.showDot = true,
  });

  final String label;
  final AppChipVariant variant;
  final bool showDot;

  Color get _bgColor => switch (variant) {
        AppChipVariant.success => AppColors.successBg,
        AppChipVariant.warning => AppColors.warningBg,
        AppChipVariant.error => AppColors.errorBg,
        AppChipVariant.neutral => AppColors.surfaceMuted,
      };

  Color get _textColor => switch (variant) {
        AppChipVariant.success => AppColors.successText,
        AppChipVariant.warning => AppColors.warningText,
        AppChipVariant.error => AppColors.errorText,
        AppChipVariant.neutral => AppColors.textSecondary,
      };

  Color get _dotColor => switch (variant) {
        AppChipVariant.success => AppColors.successDot,
        AppChipVariant.warning => AppColors.warningDot,
        AppChipVariant.error => AppColors.errorDot,
        AppChipVariant.neutral => AppColors.textTertiary,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: AppRadius.borderMax,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: AppSize.dotSm,
              height: AppSize.dotSm,
              decoration: BoxDecoration(
                color: _dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(color: _textColor),
          ),
        ],
      ),
    );
  }
}

/// 汎用フィルターチップ。
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.avatar,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      avatar: avatar,
    );
  }
}
