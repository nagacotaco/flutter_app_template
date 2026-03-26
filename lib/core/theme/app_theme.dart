import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// ThemeData をまとめて提供するクラス
abstract final class AppTheme {
  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,

    // ── Primary ──────────────────────────────────────────────────────────────
    /// アプリの主役カラー。FAB・アクティブなボトムナビ・主要ボタンの背景など
    /// 画面内で最も目立たせたい操作要素に使う。使いすぎると視覚的ノイズになるため
    /// 本当に重要な UI にだけ適用する。
    primary: AppColors.primary,

    /// primary の上に乗るテキスト・アイコンの色。
    /// primary との十分なコントラストが保証される色を設定する。
    onPrimary: Colors.white,

    /// primary より柔らかいコンテナ背景色。
    /// Badge・選択チップ・アイコンボタンの背景など「強調はしたいが主役ではない」要素に使う。
    primaryContainer: AppColors.primaryContainer,

    /// primaryContainer の上に乗るテキスト・アイコンの色。
    onPrimaryContainer: AppColors.onPrimaryContainerLight,

    // ── Secondary ────────────────────────────────────────────────────────────
    /// 補助的なアクセントカラー。フィルターチップ・トグル・セカンダリボタンなど
    /// primary ほど強調しない UI 要素に使う。
    secondary: AppColors.secondaryLight,

    /// secondary の上に乗るテキスト・アイコンの色。
    onSecondary: Colors.white,

    /// secondary より柔らかいコンテナ背景色。
    /// タグ・ラベル背景など secondary ロールの軽い強調に使う。
    secondaryContainer: AppColors.secondaryContainerLight,

    /// secondaryContainer の上に乗るテキスト・アイコンの色。
    onSecondaryContainer: AppColors.onSecondaryContainerLight,

    // ── Tertiary ─────────────────────────────────────────────────────────────
    /// 第3のアクセントカラー。primary・secondary とのバランスをとる補完色。
    /// カレンダーのハイライト・特定カテゴリの色分けなど、用途を絞って使う。
    tertiary: AppColors.tertiaryLight,

    /// tertiary の上に乗るテキスト・アイコンの色。
    onTertiary: Colors.white,

    /// tertiary より柔らかいコンテナ背景色。
    tertiaryContainer: AppColors.tertiaryContainerLight,

    /// tertiaryContainer の上に乗るテキスト・アイコンの色。
    onTertiaryContainer: AppColors.onTertiaryContainerLight,

    // ── Surface ───────────────────────────────────────────────────────────────
    /// カード・シート・ダイアログ・メニューなどコンテンツを載せる主要な背景色。
    /// Scaffold の背景にも使われる。
    surface: AppColors.backgroundLight,

    /// surface の上に乗る主要テキスト・アイコンの色。本文・見出しなどに使う。
    onSurface: AppColors.textPrimaryLight,

    /// surface より少し濃いバリアント背景。テキストフィールドの塗り・
    /// 無効状態のチップ背景など、surface との対比が欲しい箇所に使う。
    surfaceContainerHighest: AppColors.surfaceVariantLight,

    /// surfaceContainerHighest の上に乗るサブテキスト・アイコンの色。
    /// プレースホルダー・補足ラベルなど優先度の低い情報に使う。
    onSurfaceVariant: AppColors.textSecondaryLight,

    /// surface より僅かに低い強調度のコンテナ背景。
    /// サイドバー・ボトムナビ背景など広い面積を占める領域に使う。
    surfaceContainerLow: AppColors.surfaceLight,

    // ── Outline ───────────────────────────────────────────────────────────────
    /// 視覚的な区切りに使うボーダー色。テキストフィールドの枠・カード枠など
    /// 「明確に境界を示したい」要素に使う。
    outline: AppColors.borderLight,

    /// outline より控えめなボーダー色。
    /// 区切り線・装飾的なセパレーターなど強調度を下げたい境界線に使う。
    outlineVariant: AppColors.surfaceVariantLight,

    // ── Error ─────────────────────────────────────────────────────────────────
    /// エラー状態を示す色。バリデーションエラーのテキストフィールド枠・
    /// エラーアイコンなどに使う。
    error: AppColors.errorLight,

    /// error の上に乗るテキスト・アイコンの色。
    onError: Colors.white,

    /// エラー関連コンポーネントのコンテナ背景。
    /// エラーバナー・エラーメッセージの背景色などに使う。
    errorContainer: AppColors.errorBgLight,

    /// errorContainer の上に乗るテキスト・アイコンの色。
    onErrorContainer: AppColors.onErrorContainerLight,

    // ── Shadow / Scrim ────────────────────────────────────────────────────────
    /// ドロップシャドウに使う色。elevation の視覚的表現に使われる。
    shadow: Colors.black,

    /// モーダル・BottomSheet 表示時の背景オーバーレイ（スクリム）色。
    scrim: Colors.black,

    // ── Inverse ───────────────────────────────────────────────────────────────
    /// 通常 surface と逆の明度を持つ背景色。
    /// SnackBar など、通常の surface から際立たせたいコンポーネントの背景に使う。
    inverseSurface: AppColors.backgroundDark,

    /// inverseSurface の上に乗るテキスト・アイコンの色。
    onInverseSurface: AppColors.textPrimaryDark,

    /// inverseSurface 上のアクションボタン色。
    /// SnackBar のアクションラベルなどに使う。
    inversePrimary: AppColors.primaryLight,
  );

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,

    // ── Primary ──────────────────────────────────────────────────────────────
    /// ダーク背景上での主役カラー。暗い背景でも視認性を確保するため
    /// ライトモードより明るめの青を使う。
    primary: AppColors.primaryLight,

    /// primary の上に乗るテキスト・アイコンの色。
    onPrimary: AppColors.onPrimaryDark,

    /// primary より柔らかいコンテナ背景色（ダーク）。
    primaryContainer: AppColors.primaryContainerDark,

    /// primaryContainer の上に乗るテキスト・アイコンの色。
    onPrimaryContainer: AppColors.primaryContainer,

    // ── Secondary ────────────────────────────────────────────────────────────
    /// 補助アクセントカラー（ダーク）。
    secondary: AppColors.secondaryDark,

    /// secondary の上に乗るテキスト・アイコンの色。
    onSecondary: AppColors.onSecondaryDark,

    /// secondary コンテナ背景（ダーク）。
    secondaryContainer: AppColors.secondaryContainerDark,

    /// secondaryContainer の上に乗るテキスト・アイコンの色。
    onSecondaryContainer: AppColors.onSecondaryContainerDark,

    // ── Tertiary ─────────────────────────────────────────────────────────────
    /// 第3アクセントカラー（ダーク）。
    tertiary: AppColors.tertiaryDark,

    /// tertiary の上に乗るテキスト・アイコンの色。
    onTertiary: AppColors.onTertiaryDark,

    /// tertiary コンテナ背景（ダーク）。
    tertiaryContainer: AppColors.tertiaryContainerDark,

    /// tertiaryContainer の上に乗るテキスト・アイコンの色。
    onTertiaryContainer: AppColors.primaryContainer,

    // ── Surface ───────────────────────────────────────────────────────────────
    /// カード・シート等のメイン背景色（ダーク）。
    surface: AppColors.backgroundDark,

    /// surface の上に乗る主要テキスト・アイコンの色（ダーク）。
    onSurface: AppColors.textPrimaryDark,

    /// surface より少し明るいバリアント背景（ダーク）。
    surfaceContainerHighest: AppColors.surfaceVariantDark,

    /// surfaceContainerHighest 上のサブテキスト・アイコンの色（ダーク）。
    onSurfaceVariant: AppColors.textSecondaryDark,

    /// 広い面積向けの低強調コンテナ背景（ダーク）。
    surfaceContainerLow: AppColors.surfaceDark,

    // ── Outline ───────────────────────────────────────────────────────────────
    /// 境界線・枠線の色（ダーク）。
    outline: AppColors.borderDark,

    /// 低強調な区切り線の色（ダーク）。
    outlineVariant: AppColors.surfaceVariantDark,

    // ── Error ─────────────────────────────────────────────────────────────────
    /// エラー状態を示す色（ダーク）。
    error: AppColors.errorDark,

    /// error の上に乗るテキスト・アイコンの色（ダーク）。
    onError: AppColors.onErrorDark,

    /// エラーコンテナ背景（ダーク）。
    errorContainer: AppColors.errorBgDark,

    /// errorContainer の上に乗るテキスト・アイコンの色（ダーク）。
    onErrorContainer: AppColors.onErrorContainerDark,

    // ── Shadow / Scrim ────────────────────────────────────────────────────────
    /// ドロップシャドウ色（ダーク）。
    shadow: Colors.black,

    /// モーダル背景オーバーレイ色（ダーク）。
    scrim: Colors.black,

    // ── Inverse ───────────────────────────────────────────────────────────────
    /// 通常 surface と逆の明度の背景色（ダーク → ライト）。
    /// SnackBar など際立たせたいコンポーネントの背景に使う。
    inverseSurface: AppColors.backgroundLight,

    /// inverseSurface の上に乗るテキスト・アイコンの色。
    onInverseSurface: AppColors.textPrimaryLight,

    /// inverseSurface 上のアクションボタン色（ダーク）。
    inversePrimary: AppColors.primary,
  );

  static ThemeData get light => _buildTheme(_lightScheme);
  static ThemeData get dark => _buildTheme(_darkScheme);

  static ThemeData _buildTheme(ColorScheme scheme) {
    final isDark = scheme.brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: AppTextStyles.textTheme,
      scaffoldBackgroundColor: scheme.surface,
      // 波紋エフェクト（Ripple）を無くす
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      // タップ時の背景ハイライト
      highlightColor: scheme.onSurface.withValues(alpha: .06),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        titleTextStyle: AppTextStyles.titleMedium.copyWith(
          color: scheme.onSurface,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: scheme.primary,
        selectedLabelStyle: AppTextStyles.bodySmall,
        selectedIconTheme: const IconThemeData(fill: 1),
        enableFeedback: true,
        unselectedItemColor: isDark
            ? AppColors.textTertiaryDark
            : AppColors.textTertiaryLight,
        unselectedLabelStyle: AppTextStyles.bodySmall,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: scheme.outline,
        thickness: 1,
        space: 1,
      ),

      // Card
      cardTheme: CardThemeData(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outline),
        ),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.surfaceVariantDark : AppColors.surfaceVariantLight,
        side: BorderSide(color: scheme.outline),
        labelStyle: AppTextStyles.labelMedium.copyWith(
          color: scheme.onSurface,
        ),
      ),
    );
  }
}
