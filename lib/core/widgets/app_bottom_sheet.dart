import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// アプリ共通ボトムシートユーティリティ。
///
/// ```dart
/// AppBottomSheet.show(
///   context,
///   title: '並び替え',
///   child: Column(...),
/// );
/// ```
abstract final class AppBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      builder: (ctx) => _AppBottomSheetContent(
        title: title,
        child: child,
      ),
    );
  }
}

class _AppBottomSheetContent extends StatelessWidget {
  const _AppBottomSheetContent({
    required this.child,
    this.title,
  });

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ドラッグハンドル
            Center(
              child: Container(
                width: AppSpacing.xl,
                height: AppSpacing.xs,
                decoration: BoxDecoration(
                  borderRadius: AppRadius.borderMax,
                ),
              ),
            ),
            if (title != null) ...[
              // const SizedBox(height: AppSpacing.md),
              AppSpacing.gapVMd,
              Text(title!, style: AppTextStyles.titleMedium),
              AppSpacing.gapVSm,
            ] else
              AppSpacing.gapHMd,
            child,
          ],
        ),
      ),
    );
  }
}
