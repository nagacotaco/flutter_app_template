import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.title, required this.desc});
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTextStyles.labelMedium.copyWith(
            letterSpacing: AppLetterSpacing.normal,
          ),
        ),
        AppSpacing.gapHSm,
        Text(
          desc,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
