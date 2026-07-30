import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';

/// リストが空のとき等に使う共通の空状態表示（docs/ARCHITECTURE.md / DESIGN.md §5）。
/// 文言は画面側の l10n キーを渡す（この widget 内で文言を持たない）。
///
/// Pure Mono ではアイコンを使わない。空であることは**見出しの大きさと余白**で示す。
/// 中央寄せもしない（本文と同じ左端に揃え、画面の一部として読ませる）。
/// 左右パディングはこの widget が持つので、呼び出し側で重ねてつけないこと。
class EmptyView extends StatelessWidget {
  const EmptyView({required this.title, this.body, this.action, super.key});

  /// 見出し（headlineSmall）。
  final String title;

  /// 説明文（bodyMedium / onSurfaceVariant）。
  final String? body;

  /// 「追加する」等の行動を促すボタンを置きたい場合に渡す。
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineSmall),
          if (body != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              body!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: AppSpacing.xl),
            action!,
          ],
        ],
      ),
    );
  }
}
