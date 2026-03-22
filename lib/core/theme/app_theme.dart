import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dialog_theme.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

/// ThemeData をまとめて提供するクラス
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.dark),
        textTheme: AppTextStyles.textTheme,
        // 波紋エフェクト（Ripple）を無くす
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        // タップ時の背景ハイライトを薄いグレーに変更
        highlightColor: Colors.grey.withValues(alpha: .15),

        // appBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.cream,
            textStyle: AppTextStyles.titleSmall.copyWith(
              color: AppColors.cream,
            ),
          ),
        ),

        // dialog
        dialogTheme: AppDialogTheme.data,

        // bottomNavigationBar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.accent,
          selectedLabelStyle: AppTextStyles.bodySmall,
          selectedIconTheme: const IconThemeData(
            color: AppColors.accent,
            fill: 1,
          ),
          enableFeedback: true,
          unselectedItemColor: AppColors.textTertiary,
          unselectedLabelStyle: AppTextStyles.bodySmall,
        ),
      );
}
