import 'package:flutter/material.dart';

/// アプリ共通カラー定数
///
/// コンセプト: 白・黒ベース + クールブルーアクセント
/// ライト／ダークモード両対応
abstract final class AppColors {
  // ── Primary (Cool Blue) ──
  static const Color primary = Color(0xFF1B6EE8);
  static const Color primaryLight = Color(0xFF4F9CFF); // dark mode 用
  static const Color primaryContainer = Color(0xFFD9E8FF);
  static const Color primaryContainerDark = Color(0xFF003A8C);

  // ── Light: Primary on* ──
  static const Color onPrimaryContainerLight = Color(0xFF003A8C);

  // ── Dark: Primary on* ──
  static const Color onPrimaryDark = Color(0xFF00205E);

  // ── Light: Secondary (blue-gray) ──
  static const Color secondaryLight = Color(0xFF4A5568);
  static const Color secondaryContainerLight = Color(0xFFDDE3F0);
  static const Color onSecondaryContainerLight = Color(0xFF111C33);

  // ── Dark: Secondary ──
  static const Color secondaryDark = Color(0xFFBEC7E4);
  static const Color onSecondaryDark = Color(0xFF283149);
  static const Color secondaryContainerDark = Color(0xFF3E4861);
  static const Color onSecondaryContainerDark = Color(0xFFD9E4FF);

  // ── Light: Tertiary (deep blue) ──
  static const Color tertiaryLight = Color(0xFF0077B6);
  static const Color tertiaryContainerLight = Color(0xFFD0EFFF);
  static const Color onTertiaryContainerLight = Color(0xFF00344F);

  // ── Dark: Tertiary ──
  static const Color tertiaryDark = Color(0xFF72C8F5);
  static const Color onTertiaryDark = Color(0xFF003550);
  static const Color tertiaryContainerDark = Color(0xFF004D72);

  // ── Light: 背景・サーフェス ──
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF6F8FA);
  static const Color surfaceVariantLight = Color(0xFFEAEEF2);

  // ── Dark: 背景・サーフェス ──
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color surfaceDark = Color(0xFF161B22);
  static const Color surfaceVariantDark = Color(0xFF21262D);

  // ── Light: テキスト ──
  static const Color textPrimaryLight = Color(0xFF1F2328);
  static const Color textSecondaryLight = Color(0xFF636C76);
  static const Color textTertiaryLight = Color(0xFF9198A1);

  // ── Dark: テキスト ──
  static const Color textPrimaryDark = Color(0xFFE6EDF3);
  static const Color textSecondaryDark = Color(0xFF8B949E);
  static const Color textTertiaryDark = Color(0xFF6E7681);

  // ── ボーダー ──
  static const Color borderLight = Color(0xFFD0D7DE);
  static const Color borderDark = Color(0xFF30363D);

  // ── ステータス: 成功 ──
  static const Color successLight = Color(0xFF1A7F37);
  static const Color successDark = Color(0xFF3FB950);
  static const Color successBgLight = Color(0xFFDCFCE7);
  static const Color successBgDark = Color(0xFF0D2B18);

  // ── ステータス: 警告 ──
  static const Color warningLight = Color(0xFF9A6700);
  static const Color warningDark = Color(0xFFD29922);
  static const Color warningBgLight = Color(0xFFFFF8E1);
  static const Color warningBgDark = Color(0xFF2B1D00);

  // ── ステータス: エラー ──
  static const Color errorLight = Color(0xFFCF222E);
  static const Color errorDark = Color(0xFFF85149);
  static const Color errorBgLight = Color(0xFFFFEEEE);
  static const Color errorBgDark = Color(0xFF2D0F0F);
  static const Color onErrorContainerLight = Color(0xFF7D0B0A);
  static const Color onErrorDark = Color(0xFF7D0B0A);
  static const Color onErrorContainerDark = Color(0xFFFFB3AE);
}
