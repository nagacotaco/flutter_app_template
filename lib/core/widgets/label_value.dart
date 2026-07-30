import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';

/// ラベル＋値の2段ペア（DESIGN.md §5）。
///
/// 設定・プロフィール・ホーム・アイテム詳細で繰り返し出てくる最小単位。
/// Pure Mono では枠も面も使わないので、「小さい薄いラベル」と「大きい濃い値」の
/// コントラストだけがこのペアを1つの塊に見せている。上下の余白を詰めないこと。
///
/// [mono] を true にすると値が Archivo（tabular）になる。
/// 数値・日付・メールアドレス・バージョンなど、桁や字形が揃ってほしいものに使う。
class LabelValue extends StatelessWidget {
  const LabelValue({
    required this.label,
    required this.value,
    this.trailing,
    this.mono = false,
    super.key,
  });

  final String label;
  final String value;

  /// ドロップダウンの「▼」など、値の右に添えるもの。
  final Widget? trailing;

  final bool mono;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final valueStyle = mono
        ? textTheme.titleMedium.archivo
        : textTheme.titleMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: textTheme.labelSmall),
        const SizedBox(height: AppSpacing.labelToValue),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Flexible(
              child: Text(
                value,
                style: valueStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              trailing!,
            ],
          ],
        ),
      ],
    );
  }
}
