import 'package:flutter/widgets.dart';

/// スペーシング（余白）
abstract final class AppSpacing {
  // 4dp グリッド前提
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;

  // SizedBox
  static const gapXs = SizedBox(height: xs, width: xs);
  static const gapSm = SizedBox(height: sm, width: sm);
  static const gapMd = SizedBox(height: md, width: md);
  static const gapLg = SizedBox(height: lg, width: lg);
  static const gapXl = SizedBox(height: xl, width: xl);
  static const gapXxl = SizedBox(height: xxl, width: xxl);

  // 垂直方向のギャップ
  static const gapVXs = SizedBox(height: xs);
  static const gapVSm = SizedBox(height: sm);
  static const gapVMd = SizedBox(height: md);
  static const gapVLg = SizedBox(height: lg);
  static const gapVXl = SizedBox(height: xl);
  static const gapVXxl = SizedBox(height: xxl);

  // 水平方向のギャップ
  static const gapHXs = SizedBox(width: xs);
  static const gapHSm = SizedBox(width: sm);
  static const gapHMd = SizedBox(width: md);
  static const gapHLg = SizedBox(width: lg);
  static const gapHXl = SizedBox(width: xl);
  static const gapHXxl = SizedBox(width: xxl);
}

/// 角丸
abstract final class AppRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 16.0;

  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderMax = BorderRadius.all(Radius.circular(999));
}

/// 高さ・幅など「よく使うサイズ」
abstract final class AppSize {
  // ボタン高さ
  static const double buttonSm = 36.0;
  static const double buttonMd = 44.0;
  static const double buttonLg = 52.0;

  // アイコンサイズ
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // 共通コンポーネントの幅・高さ
  static const double avatarXs = 18.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 40.0;
  static const double avatarLg = 56.0;

  // ドット・インジケータ
  static const double dotSm = 6.0;
}

/// レタースペーシング
abstract final class AppLetterSpacing {
  static const double tight = 0.2;
  static const double normal = 0.8;
  static const double wide = 1.0;
}

/// 影（Elevation）
abstract final class AppElevation {
  static const double level0 = 0.0;
  static const double level1 = 1.0;
  static const double level2 = 3.0;
  static const double level3 = 6.0;
  static const double level4 = 8.0;
  static const double level5 = 12.0;
}
