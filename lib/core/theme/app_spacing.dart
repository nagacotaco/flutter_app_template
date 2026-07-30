import 'package:flutter/widgets.dart';

/// Pure Mono の余白トークン（DESIGN.md §4 が正）。
///
/// このデザインは**余白が唯一の階層表現**なので、画面側で 17 や 22 のような
/// 中途半端な値を直接書かない。ここにある値だけを使う。
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  /// ラベル → 値（LabelValue の2段）
  static const double labelToValue = 2;

  /// 項目と項目のあいだ（リスト行・入力欄）
  static const double item = 20;

  /// セクションとセクションのあいだ
  static const double section = 32;

  /// 画面の左右パディング
  static const double screenHorizontal = 24;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );
}

/// 角丸トークン。**ボタン・ダイアログ・ボトムシート・アバター以外はすべて 0**。
/// 面に角丸を付けるとカード然として見え、「面を作らない」方針が崩れる。
abstract final class AppRadius {
  static const double button = 8;
  static const double dialog = 12;
  static const double bottomSheet = 16;
}

/// 主要要素の寸法。
abstract final class AppSize {
  /// ボタン高さ・最小タップ領域
  static const double minTarget = 48;

  /// ボトムナビの高さ
  static const double navigationBar = 64;

  /// アイコン
  static const double icon = 22;

  /// プロフィールのアバター
  static const double avatar = 64;
}
