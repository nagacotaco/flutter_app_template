import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';

enum AppLoadingSize { sm, md, lg }

/// アプリ共通ローディングインジケータ。
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = AppLoadingSize.md,
    this.color,
    this.strokeWidth = 3.0,
  });

  final AppLoadingSize size;
  final Color? color;
  final double strokeWidth;

  double get _dimension => switch (size) {
        AppLoadingSize.sm => AppSize.iconSm,
        AppLoadingSize.md => AppSize.iconMd,
        AppLoadingSize.lg => AppSize.iconLg,
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _dimension,
      width: _dimension,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? AppColors.accent,
      ),
    );
  }
}

/// 画面全体をオーバーレイするローディング表示。
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({super.key, required this.child, this.isLoading = false});

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const ColoredBox(
            color: Colors.black26,
            child: Center(child: AppLoadingIndicator()),
          ),
      ],
    );
  }
}
