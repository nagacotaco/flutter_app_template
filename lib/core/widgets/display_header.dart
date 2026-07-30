import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';

/// 画面冒頭の「小見出し＋日付＋大型数値」（DESIGN.md §5）。
///
/// ホーム・アイテム一覧・設定の先頭がすべてこの形になる。
/// AppBar のタイトルを小さいまま据え置き、**画面の主張はここの大型数値が担う**。
/// [display] を渡さなければ小見出しだけの軽いヘッダーになる。
class DisplayHeader extends StatelessWidget {
  const DisplayHeader({
    required this.title,
    this.meta,
    this.display,
    this.displayUnit,
    super.key,
  });

  /// 小見出し（AppBar タイトルと同じ文言でよい）。
  final String title;

  /// 日付など。Archivo で表示する。
  final String? meta;

  /// 大型数値。件数・ステップ番号など**数値のみ**を入れる（displayLarge は数値専用）。
  final String? display;

  /// 大型数値の単位（「件」など）。ベースラインを数値に揃える。
  final String? displayUnit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: textTheme.titleSmall),
        if (meta != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(meta!, style: textTheme.bodySmall.archivo),
        ],
        if (display != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(display!, style: AppTextTheme.display(textTheme)),
              if (displayUnit != null) ...[
                const SizedBox(width: AppSpacing.sm),
                Flexible(
                  child: Text(
                    displayUnit!,
                    style: textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
