import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';

/// AsyncValue のエラー分岐で使う共通エラー表示
/// （docs/ARCHITECTURE.md / DESIGN.md §5）。
///
/// モノクロなので赤は使えない。異常であることは
/// **大きな「！」＋下線付きの見出し**という字の形だけで示す。
/// 左右パディングはこの widget が持つので、呼び出し側で重ねてつけないこと。
class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, this.onRetry, super.key});

  /// 発生したエラー。将来クラッシュレポート連携で使うため保持する。
  final Object error;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 記号なので l10n には置かない
          Text('！', style: theme.textTheme.displayMedium.archivo),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.errorMessage,
            style: theme.textTheme.headlineSmall?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.errorRetryBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.xl),
            FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ],
      ),
    );
  }
}
