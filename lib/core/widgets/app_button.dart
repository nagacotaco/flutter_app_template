import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import 'app_gap.dart';

enum AppButtonVariant { filled, outlined, text }

/// アプリ共通ボタン。
///
/// - [AppButtonVariant.filled] → FilledButton（塗りつぶし）
/// - [AppButtonVariant.outlined] → OutlinedButton（枠線）
/// - [AppButtonVariant.text] → TextButton（テキストのみ）
///
/// [isLoading] が true のとき [onPressed] を無効化し、インジケータを表示する。
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  const AppButton.filled({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  }) : variant = AppButtonVariant.filled;

  const AppButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  }) : variant = AppButtonVariant.outlined;

  const AppButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  }) : variant = AppButtonVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final double? width;

  VoidCallback? get _onPressed => isLoading ? null : onPressed;

  Widget get _child => isLoading
      ? const SizedBox(
          height: AppSize.iconSm,
          width: AppSize.iconSm,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon!, const AppGap.xs(), Text(label)],
            )
          : Text(label);

  @override
  Widget build(BuildContext context) {
    Widget button = switch (variant) {
      AppButtonVariant.filled => FilledButton(
          onPressed: _onPressed,
          child: _child,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: _onPressed,
          child: _child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: _onPressed,
          child: _child,
        ),
    };

    if (width != null) {
      button = SizedBox(width: width, child: button);
    }

    return button;
  }
}
