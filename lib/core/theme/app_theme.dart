import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_color_scheme.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';

/// アプリ全体のテーマ。デザイン方針は Pure Mono（DESIGN.md が正）。
///
/// **絶対に崩さない3点**
/// 1. 色は無彩色のみ（有彩色は [AppColorScheme] の primary / onPrimary 差し替え時のみ）
/// 2. カード・境界線・影・Divider で階層を作らない。階層は余白 × 字の太さ × 字の大きさ
/// 3. 状態を色で表さない（エラー＝太字＋下線＋「！」／無効＝不透明度 30%／選択＝塗り）
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colors = AppColorScheme.of(brightness);
    final textTheme = AppTextTheme.of(colors);
    final tokens = brightness == Brightness.light
        ? AppTokens.light
        : AppTokens.dark;

    return ThemeData(
      colorScheme: colors,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.surface,
      extensions: [tokens],

      // 面を作らないので影は全廃する
      shadowColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      iconTheme: IconThemeData(color: colors.onSurface, size: AppSize.icon),

      // Divider は使わない。ListView.separated の区切りは SizedBox(height: 20)
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
        thickness: 0,
        space: 0,
      ),

      appBarTheme: AppBarThemeData(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        // 左寄せ。長い日本語タイトルは body 側で大型タイポとして再掲する
        centerTitle: false,
        titleTextStyle: textTheme.titleSmall,
        iconTheme: IconThemeData(color: colors.onSurface, size: AppSize.icon),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: AppSize.navigationBar,
        // ラベルなし・アイコンのみ。選択は「塗り／輪郭」で示す
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: AppSize.icon,
            color: states.contains(WidgetState.selected)
                ? colors.onSurface
                : colors.onSurfaceVariant,
          ),
        ),
      ),

      // 高さ 48 / radius 8 / elevation 0。無効は塗り 30%
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(double.infinity, AppSize.minTarget),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? colors.primary.withValues(alpha: 0.3)
                : colors.primary,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? colors.onPrimary.withValues(alpha: 0.55)
                : colors.onPrimary,
          ),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          elevation: const WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
            ),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(
            Size(double.infinity, AppSize.minTarget),
          ),
          foregroundColor: WidgetStatePropertyAll(colors.onSurface),
          textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
          side: WidgetStatePropertyAll(BorderSide(color: colors.outline)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
            ),
          ),
        ),
      ),

      // 太字＋下線。破壊的操作（退会など）にもこれを使う
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, AppSize.minTarget)),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          foregroundColor: WidgetStatePropertyAll(colors.onSurface),
          textStyle: WidgetStatePropertyAll(
            textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
            ),
          ),
        ),
      ),

      // 塗りつぶさず下線のみ。ラベルは floatingLabel を使わず外側に labelSmall を置く
      inputDecorationTheme: InputDecorationThemeData(
        filled: false,
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 5, bottom: 8),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.onSurface, width: 2),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.outline.withValues(alpha: 0.3)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.onSurface, width: 2),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.onSurface, width: 2),
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(color: colors.outline),
        // エラー文言は入力欄の外に InlineError で出すため、枠内の文字は使わない
        errorStyle: const TextStyle(height: 0, fontSize: 0),
      ),

      // leading アイコン・trailing chevron は使わない前提で余白を殺す
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: AppSpacing.md,
        minLeadingWidth: 20,
        iconColor: colors.onSurfaceVariant,
        titleTextStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        subtitleTextStyle: textTheme.bodySmall,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.dialog),
          side: BorderSide(color: colors.outlineVariant),
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        showDragHandle: true,
        dragHandleColor: colors.outline,
        dragHandleSize: const Size(34, 3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.bottomSheet),
          ),
        ),
      ),

      // 送信中に画面上部へ出す 2px のバー
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.onSurface,
        linearTrackColor: colors.outlineVariant,
        linearMinHeight: 2,
        circularTrackColor: Colors.transparent,
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.onSurface,
        selectionHandleColor: colors.onSurface,
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.titleMedium,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(colors.surface),
          elevation: const WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.dialog),
              side: BorderSide(color: colors.outlineVariant),
            ),
          ),
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.dialog),
          side: BorderSide(color: colors.outlineVariant),
        ),
      ),
    );
  }
}

/// 既定の ButtonStyle から外れる用途のスタイル。
/// 画面側で色・サイズ・ウェイトを直接書かないための逃がし場所（docs/ARCHITECTURE.md）。
abstract final class AppButtonStyles {
  /// 主導線ではないテキストリンク（「パスワードをお忘れの方」など）。
  /// 既定の TextButton（太字＋下線）より一段弱い、細字＋下線の変種。
  static ButtonStyle subtleText(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton.styleFrom(
      foregroundColor: theme.colorScheme.onSurfaceVariant,
      textStyle: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
