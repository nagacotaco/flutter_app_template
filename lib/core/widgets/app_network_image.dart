import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// ネットワーク画像の共通ウィジェット（ディスクキャッシュ付き）。
/// feature 側で cached_network_image を直接 import しないこと
/// （パッケージの差し替え・削除をこのファイルに閉じるため。docs/ARCHITECTURE.md）。
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => ColoredBox(color: colors.surfaceContainerHighest),
      errorWidget: (_, _, _) => ColoredBox(
        color: colors.surfaceContainerHighest,
        child: Icon(Icons.broken_image_outlined, color: colors.outline),
      ),
    );
  }
}
