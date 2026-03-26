import 'package:flutter/material.dart';

import 'app_text_styles.dart';

/// ThemeData をまとめて提供するクラス
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D2926)),
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
          ),
          elevation: 0,
        ),
        // bottomNavigationBar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFC4622D),
          selectedLabelStyle: AppTextStyles.bodySmall,
          selectedIconTheme: const IconThemeData(
            fill: 1,
          ),
          enableFeedback: true,
          unselectedItemColor: const Color(0xFFA09B97),
          unselectedLabelStyle: AppTextStyles.bodySmall,
        ),
      );
}
