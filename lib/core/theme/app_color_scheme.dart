import 'package:flutter/material.dart';

/// Pure Mono のカラートークン（DESIGN.md §2 が正）。
///
/// 色は無彩色のみ。**面（カード・境界線・影）で階層を作らないため、
/// surfaceContainer 系はすべて surface と同色**にしている。
/// コピー先アプリで着色するときは [AppColorScheme.light] / [dark] の
/// `primary` / `onPrimary` と [seedColor] の3値だけを差し替える。
/// surface 系を有彩色にすると「面を作らない」という設計意図が崩れるので変更しない。
abstract final class AppColorScheme {
  /// Material 3 の ColorScheme 生成に使う種色。無彩色を指定して有彩色を殺している。
  static const Color seedColor = Color(0xFF111111);

  // ライト
  static const Color _lightSurface = Color(0xFFF1F1EF);
  static const Color _lightOnSurface = Color(0xFF111111);
  static const Color _lightOnSurfaceVariant = Color(0xFF6E6E6B);
  static const Color _lightOutline = Color(0xFFB5B5B1);
  static const Color _lightOutlineVariant = Color(0xFFD8D8D4);

  // ダーク
  static const Color _darkSurface = Color(0xFF1C1C1C);
  static const Color _darkOnSurface = Color(0xFFF2F2F0);
  static const Color _darkOnSurfaceVariant = Color(0xFF9A9A97);
  static const Color _darkOutline = Color(0xFF5A5A58);
  static const Color _darkOutlineVariant = Color(0xFF333331);

  /// dynamicColor（Material You）は使わない。端末の壁紙色に引きずられると
  /// 無彩色前提のこのデザインが成立しないため。
  static ColorScheme of(Brightness brightness) =>
      brightness == Brightness.light ? light : dark;

  static final ColorScheme light = ColorScheme.fromSeed(seedColor: seedColor)
      .copyWith(
        surface: _lightSurface,
        onSurface: _lightOnSurface,
        onSurfaceVariant: _lightOnSurfaceVariant,
        primary: _lightOnSurface,
        onPrimary: _lightSurface,
        secondary: _lightOnSurface,
        onSecondary: _lightSurface,
        outline: _lightOutline,
        outlineVariant: _lightOutlineVariant,
        // エラーも無彩色。色ではなく太字＋下線＋「！」で示す（DESIGN.md §4）
        error: _lightOnSurface,
        onError: _lightSurface,
        errorContainer: _lightSurface,
        onErrorContainer: _lightOnSurface,
        // 面を作らないため、コンテナ系はすべて surface と同色にする
        surfaceContainerLowest: _lightSurface,
        surfaceContainerLow: _lightSurface,
        surfaceContainer: _lightSurface,
        surfaceContainerHigh: _lightSurface,
        surfaceContainerHighest: _lightSurface,
        surfaceDim: _lightSurface,
        surfaceBright: _lightSurface,
        inverseSurface: _lightOnSurface,
        onInverseSurface: _lightSurface,
      );

  static final ColorScheme dark =
      ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ).copyWith(
        surface: _darkSurface,
        onSurface: _darkOnSurface,
        onSurfaceVariant: _darkOnSurfaceVariant,
        primary: _darkOnSurface,
        onPrimary: _darkSurface,
        secondary: _darkOnSurface,
        onSecondary: _darkSurface,
        outline: _darkOutline,
        outlineVariant: _darkOutlineVariant,
        error: _darkOnSurface,
        onError: _darkSurface,
        errorContainer: _darkSurface,
        onErrorContainer: _darkOnSurface,
        surfaceContainerLowest: _darkSurface,
        surfaceContainerLow: _darkSurface,
        surfaceContainer: _darkSurface,
        surfaceContainerHigh: _darkSurface,
        surfaceContainerHighest: _darkSurface,
        surfaceDim: _darkSurface,
        surfaceBright: _darkSurface,
        inverseSurface: _darkOnSurface,
        onInverseSurface: _darkSurface,
      );
}

/// ColorScheme に載らない Pure Mono 固有のトークン。
/// いまはスケルトンの2色のみ。明度差を抑える（8% → 3%）ために
/// surfaceContainer 系ではなく専用の値を持つ（DESIGN.md §5 SkeletonListView）。
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.skeletonBase,
    required this.skeletonHighlight,
  });

  static const AppTokens light = AppTokens(
    skeletonBase: Color(0xFFDEDEDA),
    skeletonHighlight: Color(0xFFE8E8E4),
  );

  static const AppTokens dark = AppTokens(
    skeletonBase: Color(0xFF2C2C2A),
    skeletonHighlight: Color(0xFF333331),
  );

  static AppTokens of(BuildContext context) =>
      Theme.of(context).extension<AppTokens>() ?? light;

  final Color skeletonBase;
  final Color skeletonHighlight;

  @override
  AppTokens copyWith({Color? skeletonBase, Color? skeletonHighlight}) =>
      AppTokens(
        skeletonBase: skeletonBase ?? this.skeletonBase,
        skeletonHighlight: skeletonHighlight ?? this.skeletonHighlight,
      );

  @override
  AppTokens lerp(covariant AppTokens? other, double t) {
    if (other == null) return this;
    return AppTokens(
      skeletonBase: Color.lerp(skeletonBase, other.skeletonBase, t)!,
      skeletonHighlight: Color.lerp(
        skeletonHighlight,
        other.skeletonHighlight,
        t,
      )!,
    );
  }
}
