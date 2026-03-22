import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

/// ダイアログテーマ定数
abstract final class AppDialogTheme {
  static const DialogThemeData data = DialogThemeData(
    backgroundColor: AppColors.cardBackground,
    surfaceTintColor: Colors.transparent,
    elevation: AppElevation.level2,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.borderLg,
    ),
    // titleLarge (22sp) ベース、少し太めに
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      height: 1.27,
      color: AppColors.textPrimary,
    ),
    // bodyMedium (14sp) ベース
    contentTextStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.43,
      letterSpacing: 0.25,
      color: AppColors.textSecondary,
    ),
    insetPadding: EdgeInsets.symmetric(
      horizontal: AppSpacing.xl,
      vertical: AppSpacing.xxl,
    ),
    actionsPadding: EdgeInsets.fromLTRB(
      AppSpacing.md,
      AppSpacing.xs,
      AppSpacing.md,
      AppSpacing.md,
    ),
  );
}
