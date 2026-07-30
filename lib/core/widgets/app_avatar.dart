import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_color_scheme.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:flutter_app_template/core/theme/app_text_theme.dart';

/// アバター表示の共通ウィジェット（ディスクキャッシュ付き / DESIGN.md §5）。
///
/// [size] は直径（radius ではない）。プロフィールは [AppSize.avatar] = 64。
/// 画像が未設定のときは、[initials] があれば頭文字を Archivo で、
/// なければ細い輪郭の円だけを出す。**アイコンで賑やかしをしない。**
class AppAvatar extends StatelessWidget {
  const AppAvatar({this.url, this.size = 40, this.initials, super.key});

  final String? url;

  /// 直径。
  final double size;

  /// 画像未設定時に出す頭文字（1〜2文字）。
  final String? initials;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = AppTokens.of(context);
    final url = this.url;
    final initials = this.initials;

    if (url != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tokens.skeletonBase,
          image: DecorationImage(
            image: CachedNetworkImageProvider(url),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (initials != null && initials.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: tokens.skeletonBase,
        ),
        child: Text(
          initials,
          style: theme.textTheme.titleLarge.archivo?.copyWith(
            fontSize: size * 0.3125,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Container(
        width: size * 0.3125,
        height: size * 0.3125,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.onSurfaceVariant,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
