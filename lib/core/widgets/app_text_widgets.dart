import 'package:flutter/material.dart';

import '../utils/extensions/context_extension.dart';

mixin TextThemeText implements Widget {
  /// The string to display.
  String get data;

  /// The text color.
  Color? get color;

  /// The indentation amount in spaces.
  double? get indent;

  /// The maximum number of lines. Null means unlimited.
  int? get maxLines;

  /// The text alignment.
  TextAlign? get textAlign;
}

/// [Text] widget with [TextTheme.displayLarge].
class TextDisplayLarge extends StatelessWidget with TextThemeText {
  const TextDisplayLarge(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.displayLarge!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.displayMedium].
class TextDisplayMedium extends StatelessWidget with TextThemeText {
  const TextDisplayMedium(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.displayMedium!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.displaySmall].
class TextDisplaySmall extends StatelessWidget with TextThemeText {
  const TextDisplaySmall(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.displaySmall!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.headlineLarge].
class TextHeadlineLarge extends StatelessWidget with TextThemeText {
  const TextHeadlineLarge(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.headlineLarge!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.headlineMedium].
class TextHeadlineMedium extends StatelessWidget with TextThemeText {
  const TextHeadlineMedium(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.headlineMedium!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.headlineSmall].
class TextHeadlineSmall extends StatelessWidget with TextThemeText {
  const TextHeadlineSmall(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.headlineSmall!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.titleLarge].
class TextTitleLarge extends StatelessWidget with TextThemeText {
  const TextTitleLarge(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.titleLarge!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.titleMedium].
class TextTitleMedium extends StatelessWidget with TextThemeText {
  const TextTitleMedium(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.titleMedium!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.titleSmall].
class TextTitleSmall extends StatelessWidget with TextThemeText {
  const TextTitleSmall(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.titleSmall!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.bodyLarge].
class TextBodyLarge extends StatelessWidget with TextThemeText {
  const TextBodyLarge(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.bodyLarge!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.bodyMedium].
class TextBodyMedium extends StatelessWidget with TextThemeText {
  const TextBodyMedium(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.bodyMedium!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.bodySmall].
class TextBodySmall extends StatelessWidget with TextThemeText {
  const TextBodySmall(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.bodySmall!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.labelLarge].
class TextLabelLarge extends StatelessWidget with TextThemeText {
  const TextLabelLarge(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.labelLarge!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.labelMedium].
class TextLabelMedium extends StatelessWidget with TextThemeText {
  const TextLabelMedium(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.labelMedium!.copyWith(color: color),
    );
  }
}

/// [Text] widget with [TextTheme.labelSmall].
class TextLabelSmall extends StatelessWidget with TextThemeText {
  const TextLabelSmall(
    this.data, {
    super.key,
    this.color,
    this.indent,
    this.maxLines,
    this.textAlign,
  });

  @override
  final String data;

  @override
  final Color? color;

  @override
  final double? indent;

  @override
  final int? maxLines;

  @override
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _TextThemeText(
      data,
      color: color,
      indent: indent,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.labelSmall!.copyWith(color: color),
    );
  }
}

class _TextThemeText extends StatelessWidget {
  const _TextThemeText(
    this.data, {
    required this.color,
    required this.indent,
    required this.maxLines,
    required this.textAlign,
    required this.style,
  });

  final String data;
  final Color? color;
  final double? indent;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent ?? 0),
      child: Text(
        data,
        maxLines: maxLines,
        overflow: maxLines == null ? null : TextOverflow.ellipsis,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
