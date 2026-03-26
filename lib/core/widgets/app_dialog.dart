import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

/// アプリ共通ダイアログユーティリティ。
abstract final class AppDialog {
  // ── スタイル定数 ────────────────────────────────────────────────────────────

  static const _shape = RoundedRectangleBorder(
    borderRadius: AppRadius.borderLg,
  );

  static final _titleTextStyle = AppTextStyles.titleLarge.copyWith(
  );

  static final _contentTextStyle = AppTextStyles.bodyMedium.copyWith(
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
        backgroundColor: const Color(0xFF2D2926),
        foregroundColor: Colors.white,
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
        backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
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
            style: TextButton.styleFrom(foregroundColor: const Color(0xFF9B2B2B)),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
