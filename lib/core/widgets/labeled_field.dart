import 'package:flutter/material.dart';

/// 入力欄とその外側ラベル（DESIGN.md §5 TextField）。
///
/// Material の floatingLabel は使わない。ラベルが入力状態で動くと、
/// 「余白と字の大小だけで階層を作る」という前提が崩れて画面が落ち着かないため、
/// ラベルは常に入力欄の**外側・上**に labelSmall で固定する。
///
/// 入力欄そのものの見た目（下線 1px / focus 2px / filled: false）は
/// `InputDecorationTheme` 側に持たせてあるので、[child] には素の
/// `TextField` を渡すだけでよい。
class LabeledField extends StatelessWidget {
  const LabeledField({required this.label, required this.child, super.key});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        child,
      ],
    );
  }
}
