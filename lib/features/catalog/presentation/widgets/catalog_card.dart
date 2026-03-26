import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';

class CatalogCard extends StatelessWidget {
  const CatalogCard({super.key, required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2DDD8)),
        borderRadius: AppRadius.borderLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            decoration: const BoxDecoration(
              color: Color(0xFFF0EDE9),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
              border: Border(bottom: BorderSide(color: Color(0xFFE2DDD8))),
            ),
            child: Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: const Color(0xFFA09B97),
                letterSpacing: AppLetterSpacing.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ],
      ),
    );
  }
}
