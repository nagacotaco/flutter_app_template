import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      routerConfig: appRouter,
    );
  }
}
