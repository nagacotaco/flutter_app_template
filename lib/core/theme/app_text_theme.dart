import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pure Mono のタイポグラフィ（DESIGN.md §3 が正）。
///
/// - 和文: Noto Sans JP（TextTheme 全体のベース）
/// - 欧文・数字・日付・メール・バージョン: Archivo（[ArchivoTextStyleX.archivo] で個別に差し替える）
///
/// letterSpacing は em ではなく論理ピクセルなので、仕様の em 値 × フォントサイズで持つ。
/// 日本語は行間を欧文より +0.15 確保している（bodyMedium 1.65 等）。
abstract final class AppTextTheme {
  static TextTheme of(ColorScheme colors) {
    final base = TextStyle(color: colors.onSurface);
    final variant = TextStyle(color: colors.onSurfaceVariant);

    return GoogleFonts.notoSansJpTextTheme(
      TextTheme(
        // 件数・ステップ番号などの「数値」専用。画面見出しには使わない
        displayLarge: base.copyWith(
          fontSize: 68,
          fontWeight: FontWeight.w800,
          height: 1,
          letterSpacing: 68 * -0.05,
        ),
        displayMedium: base.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          height: 1.2,
          letterSpacing: 32 * -0.04,
        ),
        headlineSmall: base.copyWith(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          height: 1.25,
          letterSpacing: 27 * -0.035,
        ),
        titleLarge: base.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.3,
          letterSpacing: 20 * -0.02,
        ),
        titleMedium: base.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          height: 1.4,
        ),
        titleSmall: base.copyWith(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
        bodyLarge: base.copyWith(fontSize: 14, height: 1.7),
        bodyMedium: base.copyWith(fontSize: 13, height: 1.65),
        bodySmall: variant.copyWith(fontSize: 11, height: 1.6),
        // ボタン
        labelLarge: base.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
        labelMedium: variant.copyWith(fontSize: 11),
        // ラベル（LabelValue の上段など）
        labelSmall: variant.copyWith(fontSize: 10),
      ),
    ).apply(displayColor: colors.onSurface, bodyColor: colors.onSurface);
  }

  /// displayLarge は数値専用なので Archivo に固定する。
  /// TextTheme 経由（`textTheme.displayLarge`）で取ると和文フォントになるため、
  /// 大型数値を出すウィジェットはこちらを使う（DisplayHeader / オンボーディング番号）。
  static TextStyle display(TextTheme textTheme) =>
      textTheme.displayLarge.archivo!;
}

/// 数字・日付・メールアドレス・バージョン等を Archivo（tabular）に差し替える。
///
/// ```dart
/// Text(version, style: Theme.of(context).textTheme.titleMedium.archivo)
/// ```
///
/// 桁が揃う tabular figures を有効にしているので、数値の並びがガタつかない。
extension ArchivoTextStyleX on TextStyle? {
  TextStyle? get archivo {
    final style = this;
    if (style == null) return null;
    return GoogleFonts.archivo(
      textStyle: style,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
