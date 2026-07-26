import 'package:flutter/material.dart';

/// アプリ全体のテーマ。色は seed カラーから Material 3 の ColorScheme を生成する。
class AppTheme {
  AppTheme._();

  /// コピー先のアプリではこの1箇所をブランドカラーに変更する。
  static const Color _seedColor = Color(0xFF2962FF);

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}
