import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';
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

  static final _basePadding = const EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.md,
  );

  static final ButtonStyle _filledStyle = FilledButton.styleFrom(
    padding: _basePadding,
    backgroundColor: const Color(0xFFC4622D),
    foregroundColor: const Color(0xFFF7F5F2),
    textStyle: AppTextStyles.titleSmall,
    disabledBackgroundColor: const Color(0xFFF0EDE9),
    disabledForegroundColor: const Color(0xFFA09B97),
  );

  static final ButtonStyle _outlinedStyle = OutlinedButton.styleFrom(
    padding: _basePadding,
    foregroundColor: const Color(0xFFC4622D),
    side: const BorderSide(color: Color(0xFFC4622D)),
    textStyle: AppTextStyles.titleSmall,
    disabledForegroundColor: const Color(0xFFA09B97),
  );

  static final ButtonStyle _textStyle = TextButton.styleFrom(
    padding: _basePadding,
    foregroundColor: const Color(0xFFC4622D),
    textStyle: AppTextStyles.titleSmall,
    disabledForegroundColor: const Color(0xFFA09B97),
  );

  @override
  Widget build(BuildContext context) {
    Widget button = switch (variant) {
      AppButtonVariant.filled => FilledButton(
          onPressed: _onPressed,
          style: _filledStyle,
          child: _child,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: _onPressed,
          style: _outlinedStyle,
          child: _child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: _onPressed,
          style: _textStyle,
          child: _child,
        ),
    };

    if (width != null) {
      button = SizedBox(width: width, child: button);
    }

    return button;
  }
}
