import 'package:flutter/material.dart';

/// アプリ共通カラー定数
abstract final class AppColors {
  // ── ベースカラー ──
  static const Color dark = Color(0xFF2D2926);
  static const Color cream = Color(0xFFF7F5F2);

  // ── テキスト ──
  static const Color textSecondary = Color(0xFF6B6460);
  static const Color textTertiary = Color(0xFFA09B97);

  // ── アクセント ──
  static const Color accent = Color(0xFFC4622D);

  // ── テキスト: ダーク背景上 ──
  static const Color textOnDark = Colors.white;

  // ── カード背景 ──
  static const Color cardBackground = Colors.white;

  // ── ボーダー・サーフェス ──
  static const Color border = Color(0xFFE2DDD8);
  static const Color borderLight = Color(0xFFC8C2BB);
  static const Color surfaceMuted = Color(0xFFF0EDE9);
  static const Color avatarBg = Color(0xFFEDE9E4);

  // ── ステータス: 成功 ──
  static const Color successBg = Color(0xFFEAF5EC);
  static const Color successText = Color(0xFF2A7A3B);
  static const Color successDot = Color(0xFF3DA050);

  // ── ステータス: 警告 ──
  static const Color warningBg = Color(0xFFFEF3E2);
  static const Color warningText = Color(0xFF9A5F10);
  static const Color warningDot = Color(0xFFE08A1E);

  // ── ステータス: エラー ──
  static const Color errorBg = Color(0xFFFDECEA);
  static const Color errorText = Color(0xFF9B2B2B);
  static const Color errorDot = Color(0xFFD93535);
}
