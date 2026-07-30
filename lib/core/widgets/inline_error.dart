import 'package:flutter/material.dart';

/// 画面内インラインのエラー表示（DESIGN.md §4・§5）。
///
/// **SnackBar は使わない。** モノクロでは色で危険を示せないので、
/// エラーは「！＋太字＋下線」という**字の形**だけで示し、
/// 原因になった入力欄や操作の直下に置いて位置で対象を示す。
///
/// 色は onSurface のまま（error ロールも無彩色にしてある）。ここで赤を使わないこと。
class InlineError extends StatelessWidget {
  const InlineError({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      // 「！」は文言ではなく記号なので l10n には置かない
      '！ $message',
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
