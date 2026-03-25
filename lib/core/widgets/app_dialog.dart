import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// アプリ共通ダイアログユーティリティ。
abstract final class AppDialog {
  // ── スタイル定数 ────────────────────────────────────────────────────────────

  static const _shape = RoundedRectangleBorder(
    borderRadius: AppRadius.borderLg,
  );

  static const _titleTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: 1.27,
    color: AppColors.textPrimary,
  );

  static const _contentTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    color: AppColors.textSecondary,
  );

  static const _insetPadding = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.xxl,
  );

  static const _actionsPadding = EdgeInsets.fromLTRB(
    AppSpacing.md,
    AppSpacing.xs,
    AppSpacing.md,
    AppSpacing.md,
  );

  // ── 共通ボタンスタイル ───────────────────────────────────────────────────────

  static ButtonStyle get _confirmButtonStyle => FilledButton.styleFrom(
        backgroundColor: AppColors.dark,
        foregroundColor: AppColors.textOnDark,
        textStyle: AppTextStyles.labelLarge,
      );

  // ── show メソッド ────────────────────────────────────────────────────────────

  /// 確認ダイアログ（キャンセル + 確定の 2 ボタン）を表示する。
  static Future<bool?> showConfirm(
    BuildContext context, {
    String? title,
    required String message,
    String confirmLabel = 'OK',
    String cancelLabel = 'キャンセル',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level2,
        shadowColor: Colors.black12,
        shape: _shape,
        titleTextStyle: _titleTextStyle,
        contentTextStyle: _contentTextStyle,
        insetPadding: _insetPadding,
        actionsPadding: _actionsPadding,
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(cancelLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: _confirmButtonStyle,
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }

  /// 情報ダイアログ（OK ボタン 1 つ）を表示する。
  static Future<void> showInfo(
    BuildContext context, {
    String? title,
    required String message,
    String closeLabel = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level2,
        shadowColor: Colors.black12,
        shape: _shape,
        titleTextStyle: _titleTextStyle,
        contentTextStyle: _contentTextStyle,
        insetPadding: _insetPadding,
        actionsPadding: _actionsPadding,
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: _confirmButtonStyle,
            child: Text(closeLabel),
          ),
        ],
      ),
    );
  }

  /// 破壊的アクションの確認ダイアログを表示する。
  ///
  /// 確定ボタンはエラーカラーで表示される。
  static Future<bool?> showDestructive(
    BuildContext context, {
    String? title,
    required String message,
    String confirmLabel = '削除する',
    String cancelLabel = 'キャンセル',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level2,
        shadowColor: Colors.black12,
        shape: _shape,
        titleTextStyle: _titleTextStyle,
        contentTextStyle: _contentTextStyle,
        insetPadding: _insetPadding,
        actionsPadding: _actionsPadding,
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.errorText),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
