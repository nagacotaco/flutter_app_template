import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import '../theme/app_text_styles.dart';

enum AppAvatarSize { xs, sm, md, lg }

/// アプリ共通アバター。
///
/// [imageUrl] がある場合はネットワーク画像を、
/// [initials] がある場合はイニシャルテキストを表示する。
/// どちらもない場合はデフォルトアイコンを表示する。
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = AppAvatarSize.md,
    this.backgroundColor,
  });

  final String? imageUrl;
  final String? initials;
  final AppAvatarSize size;
  final Color? backgroundColor;

  double get _dimension => switch (size) {
        AppAvatarSize.xs => AppSize.avatarXs,
        AppAvatarSize.sm => AppSize.avatarSm,
        AppAvatarSize.md => AppSize.avatarMd,
        AppAvatarSize.lg => AppSize.avatarLg,
      };

  TextStyle get _textStyle => switch (size) {
        AppAvatarSize.xs => AppTextStyles.labelSmall,
        AppAvatarSize.sm => AppTextStyles.labelSmall,
        AppAvatarSize.md => AppTextStyles.labelMedium,
        AppAvatarSize.lg => AppTextStyles.titleSmall,
      };

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFFEDE9E4);
    final d = _dimension;

    if (imageUrl != null) {
      return ClipOval(
        child: Image.network(
          imageUrl!,
          width: d,
          height: d,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(bg, d),
        ),
      );
    }

    return _placeholder(bg, d);
  }

  Widget _placeholder(Color bg, double d) {
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: initials != null
          ? Text(
              initials!,
            )
          : Icon(
              Icons.person_outline,
              size: d * 0.55,
            ),
    );
  }
}
