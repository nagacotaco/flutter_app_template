import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/theme/app_colors.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouter);
    return MaterialApp.router(
      title: 'Flutter App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D2926)),
        textTheme: AppTextStyles.textTheme,
        // 波紋エフェクト（Ripple）を無くす
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        // タップ時の背景ハイライトを薄いグレーに変更
        highlightColor: Colors.grey.withValues(alpha: .15),

        // bottomNavigationBar
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.accent,
          selectedLabelStyle: AppTextStyles.bodySmall,
          selectedIconTheme: IconThemeData(
            color: AppColors.accent,
            fill: 1, // 塗りつぶし
          ),
          unselectedItemColor: AppColors.textTertiary,
          unselectedLabelStyle: AppTextStyles.bodySmall,
        ),
      ),
      routerConfig: router,
    );
  }
}
