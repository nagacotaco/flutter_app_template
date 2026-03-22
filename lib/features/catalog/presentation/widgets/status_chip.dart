import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    required this.dotColor,
  });
  final String label;
  final Color color;
  final Color textColor;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration:
          BoxDecoration(color: color, borderRadius: AppRadius.borderMax),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: AppSize.dotSm,
              height: AppSize.dotSm,
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          AppSpacing.gapHXs,
          Text(label,
              style: AppTextStyles.labelMedium.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
