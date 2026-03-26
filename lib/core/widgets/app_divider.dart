import 'package:flutter/material.dart';

/// アプリ共通区切り線。
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.thickness = 0.5,
    this.color,
  });

  final double? indent;
  final double? endIndent;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      height: thickness,
    );
  }
}

/// 縦方向の区切り線。
class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
    this.thickness = 0.5,
    this.color,
  });

  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      thickness: thickness,
      width: thickness,
    );
  }
}
