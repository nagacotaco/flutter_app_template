import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';

/// 確認・警告ダイアログの共通レイアウト（DESIGN.md §5 Dialog）。
/// 文言は画面側の l10n キーを渡す（この widget 内で文言を持たない）。
///
/// 見た目（radius 12 / 1px 枠 / elevation 0）はテーマ側に持たせてあるので、
/// この widget が持つのは**ボタンを縦積みにするレイアウト**だけ。
/// Material 標準の actions（右下横並び）は使わない。
///
/// ボタンの階層で誤タップを防ぐ（モノクロでは色で危険を示せない）:
/// 破壊的操作（退会など）では **FilledButton を「キャンセル」に割り当て**、
/// 実行ボタンを TextButton（太字＋下線）に降格する。通常の確認では逆でよい。
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    required this.actions,
  });

  final String title;

  /// 本文。bodyMedium（onSurfaceVariant）はテーマ側で当たる。
  final String? message;

  /// 本文の下に挟む任意ウィジェット（入力欄など）。
  final Widget? content;

  /// 縦積みにするボタン列。FilledButton / TextButton をそのまま渡す。
  final List<Widget> actions;

  /// [showDialog] の薄いラッパー。[actions] のボタンから
  /// `Navigator.of(dialogContext).pop(...)` できるよう、builder 形式で受ける。
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    String? message,
    Widget? content,
    required List<Widget> Function(BuildContext dialogContext) actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (dialogContext) => AppDialog(
        title: title,
        message: message,
        content: content,
        actions: actions(dialogContext),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (message != null) Text(message!),
          if (content != null) ...[
            if (message != null) const SizedBox(height: AppSpacing.lg),
            content!,
          ],
          const SizedBox(height: AppSpacing.xl),
          ...actions,
        ],
      ),
    );
  }
}
