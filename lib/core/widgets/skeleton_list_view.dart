import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_color_scheme.dart';
import 'package:flutter_app_template/core/theme/app_spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// スケルトンの形。画面のレイアウトに合わせて選ぶ（DESIGN.md §6）。
enum SkeletonVariant {
  /// リスト画面（タイトル行＋説明行の繰り返し）。
  list,

  /// 詳細画面（大型タイトル2行＋メタ行＋本文）。
  detail,
}

/// ローディング分岐で使う共通スケルトン（docs/ARCHITECTURE.md / DESIGN.md §5）。
///
/// Pure Mono では**無彩色のバーだけ**を出す。シマーの明度差も 8% → 3% に抑えて
/// あり（[AppTokens] の skeletonBase / skeletonHighlight）、読み込み中の画面が
/// 実データより目立たないようにしている。
///
/// この2バリアントで足りないレイアウトのみ、実レイアウトを
/// `Skeletonizer(enabled: true, child: ...)` で包んでダミーデータを渡す。
class SkeletonListView extends StatelessWidget {
  const SkeletonListView({
    this.itemCount = 6,
    this.variant = SkeletonVariant.list,
    super.key,
  });

  final int itemCount;
  final SkeletonVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);

    return Skeletonizer.zone(
      effect: ShimmerEffect(
        baseColor: tokens.skeletonBase,
        highlightColor: tokens.skeletonHighlight,
      ),
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: switch (variant) {
          SkeletonVariant.list => _ListBones(itemCount: itemCount),
          SkeletonVariant.detail => const _DetailBones(),
        },
      ),
    );
  }
}

class _ListBones extends StatelessWidget {
  const _ListBones({required this.itemCount});

  /// 行ごとに幅を変えて単調さを消す。実データの見え方に寄せるための固定パターン。
  static const List<(double, double)> _widths = [
    (0.72, 0.48),
    (0.58, 0.64),
    (0.80, 0.40),
    (0.66, 0.56),
    (0.74, 0.44),
    (0.52, 0.60),
  ];

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < itemCount; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.item),
          _Bar(widthFactor: _widths[i % _widths.length].$1, height: 12),
          const SizedBox(height: AppSpacing.sm),
          _Bar(widthFactor: _widths[i % _widths.length].$2, height: 9),
        ],
      ],
    );
  }
}

class _DetailBones extends StatelessWidget {
  const _DetailBones();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Bar(widthFactor: 0.82, height: 22),
        SizedBox(height: AppSpacing.sm),
        _Bar(widthFactor: 0.54, height: 22),
        SizedBox(height: AppSpacing.lg),
        _Bar(widthFactor: 0.40, height: 9),
        SizedBox(height: AppSpacing.xl),
        _Bar(widthFactor: 1, height: 10),
        SizedBox(height: AppSpacing.sm),
        _Bar(widthFactor: 0.96, height: 10),
        SizedBox(height: AppSpacing.sm),
        _Bar(widthFactor: 0.88, height: 10),
        SizedBox(height: AppSpacing.sm),
        _Bar(widthFactor: 0.64, height: 10),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.widthFactor, required this.height});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      // 面に角丸を付けないので radius 0（DESIGN.md §4）
      child: Bone(height: height, borderRadius: BorderRadius.zero),
    );
  }
}
