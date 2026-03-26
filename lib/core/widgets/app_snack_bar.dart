import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

enum AppSnackBarVariant { info, success, warning, error }

/// アプリ共通スナックバーユーティリティ。
///
/// ```dart
/// AppSnackBar.show(context, message: '保存しました', variant: AppSnackBarVariant.success);
/// ```
abstract final class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackBarVariant variant = AppSnackBarVariant.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final colors = _resolveColors(variant);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          backgroundColor: colors.$1,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderMd,
          ),
          margin: const EdgeInsets.all(AppSpacing.md),
          content: Text(
            message,
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: colors.$2,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
  }

  /// (backgroundColor, textColor)
  static (Color, Color) _resolveColors(AppSnackBarVariant variant) =>
      switch (variant) {
        AppSnackBarVariant.success => (const Color(0xFFEAF5EC), const Color(0xFF2A7A3B)),
        AppSnackBarVariant.warning => (const Color(0xFFFEF3E2), const Color(0xFF9A5F10)),
        AppSnackBarVariant.error => (const Color(0xFFFDECEA), const Color(0xFF9B2B2B)),
        AppSnackBarVariant.info => (const Color(0xFF2D2926), Colors.white),
      };
}
