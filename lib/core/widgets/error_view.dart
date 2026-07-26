import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';

/// AsyncValue のエラー分岐で使う共通エラー表示（docs/ARCHITECTURE.md）。
class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, this.onRetry, super.key});

  /// 発生したエラー。将来クラッシュレポート連携で使うため保持する。
  final Object error;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l10n.errorMessage),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: Text(context.l10n.retry),
            ),
          ],
        ],
      ),
    );
  }
}
