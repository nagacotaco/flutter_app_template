import 'package:flutter/material.dart';

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
        AppChipVariant.success => const Color(0xFFEAF5EC),
        AppChipVariant.warning => const Color(0xFFFEF3E2),
        AppChipVariant.error => const Color(0xFFFDECEA),
        AppChipVariant.neutral => const Color(0xFFF0EDE9),
      };

  Color get _textColor => switch (variant) {
        AppChipVariant.success => const Color(0xFF2A7A3B),
        AppChipVariant.warning => const Color(0xFF9A5F10),
        AppChipVariant.error => const Color(0xFF9B2B2B),
        AppChipVariant.neutral => const Color(0xFF6B6460),
      };

  Color get _dotColor => switch (variant) {
        AppChipVariant.success => const Color(0xFF3DA050),
        AppChipVariant.warning => const Color(0xFFE08A1E),
        AppChipVariant.error => const Color(0xFFD93535),
        AppChipVariant.neutral => const Color(0xFFA09B97),
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
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
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
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
