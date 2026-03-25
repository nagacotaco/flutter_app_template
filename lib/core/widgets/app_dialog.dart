import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// アプリ共通ダイアログユーティリティ。
///
/// [AppDialogTheme] のスタイルを自動的に継承する。
abstract final class AppDialog {
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
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(cancelLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.dark,
            ),
            child: Text(
              confirmLabel,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textOnDark,
              ),
            ),
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
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.dark,
            ),
            child: Text(
              closeLabel,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textOnDark,
              ),
            ),
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
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.errorText,
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
