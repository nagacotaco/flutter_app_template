import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// アバター表示の共通ウィジェット（ディスクキャッシュ付き）。
/// [url] が null の間はプレースホルダーアイコンを表示する。
class AppAvatar extends StatelessWidget {
  const AppAvatar({this.url, this.radius = 20, super.key});

  final String? url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    return CircleAvatar(
      radius: radius,
      backgroundImage: url == null ? null : CachedNetworkImageProvider(url),
      child: url == null ? Icon(Icons.person, size: radius) : null,
    );
  }
}
