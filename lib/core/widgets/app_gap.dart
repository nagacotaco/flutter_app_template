import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../theme/app_sizes.dart';

/// 親 Flex（Column/Row）の方向を自動検出してギャップを挿入するウィジェット。
/// Flex 以外に配置された場合は正方形として振る舞う。
class AppGap extends LeafRenderObjectWidget {
  const AppGap(this.gap, {super.key});

  const AppGap.xs({super.key}) : gap = AppSpacing.xs;
  const AppGap.sm({super.key}) : gap = AppSpacing.sm;
  const AppGap.md({super.key}) : gap = AppSpacing.md;
  const AppGap.lg({super.key}) : gap = AppSpacing.lg;
  const AppGap.xl({super.key}) : gap = AppSpacing.xl;
  const AppGap.xxl({super.key}) : gap = AppSpacing.xxl;

  final double gap;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderAppGap(gap);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderAppGap).gap = gap;
  }
}

class _RenderAppGap extends RenderBox {
  _RenderAppGap(this._gap);

  double _gap;

  double get gap => _gap;
  set gap(double value) {
    if (_gap == value) return;
    _gap = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final parent = this.parent;
    if (parent is RenderFlex) {
      if (parent.direction == Axis.horizontal) {
        size = constraints.constrain(Size(_gap, 0));
      } else {
        size = constraints.constrain(Size(0, _gap));
      }
    } else {
      size = constraints.constrain(Size(_gap, _gap));
    }
  }
}
