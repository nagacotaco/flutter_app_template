import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';

/// アプリ共通カード。
///
/// [onTap] を指定するとタップ可能なカードになる。
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.borderMd;
    final bg = backgroundColor ?? Colors.white;
    final effectiveElevation = elevation ?? AppElevation.level1;

    return Material(
      elevation: effectiveElevation,
      shadowColor: Colors.black12,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: padding ??
              const EdgeInsets.all(AppSpacing.md),
          child: child,
        ),
      ),
    );
  }
}
