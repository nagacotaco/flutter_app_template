import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';

/// モーダルボトムシートの共通レイアウト（DESIGN.md §5 BottomSheet）。
/// 文言は画面側の l10n キーを渡す（この widget 内で文言を持たない）。
///
/// 見た目（上端 radius 16 / ハンドル 34×3 / elevation 0）はテーマ側に
/// 持たせてあるので、この widget が持つのは**内側のレイアウト**だけ:
/// 左右パディング＝画面と同じ 24、見出しは titleMedium、下端は SafeArea。
/// 左右パディングはこの widget が持つので、呼び出し側で重ねてつけないこと。
///
/// 選択肢の列挙には ListTile を並べる（ログイン方法の切り替えが実例）。
/// 画面の高さを超えうる長い内容は、呼び出し側で children を
/// `Flexible(child: ListView(...))` にして渡す。
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, this.title, required this.children});

  /// シート冒頭の小見出し。省略すればハンドルの下にそのまま内容が並ぶ。
  final String? title;

  final List<Widget> children;

  /// [showModalBottomSheet] の薄いラッパー。[children] の行から
  /// `Navigator.of(sheetContext).pop(...)` できるよう、builder 形式で受ける。
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required List<Widget> Function(BuildContext sheetContext) children,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (sheetContext) =>
          AppBottomSheet(title: title, children: children(sheetContext)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          0,
          AppSpacing.screenHorizontal,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Text(title!, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.lg),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}
