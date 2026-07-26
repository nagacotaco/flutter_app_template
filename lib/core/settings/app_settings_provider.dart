import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/settings/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_settings_provider.g.dart';

/// main.dart で取得したインスタンスを ProviderScope の overrides で注入する。
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('main.dart の ProviderScope で override する');

/// テーマ・言語のグローバル状態（docs/ARCHITECTURE.md 6章:
/// グローバル状態は core/ 配下の専用 Provider に置く）。
@Riverpod(keepAlive: true)
class AppSettingsNotifier extends _$AppSettingsNotifier {
  static const String _themeModeKey = 'settings.themeMode';
  static const String _localeKey = 'settings.locale';

  @override
  AppSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeModeName = prefs.getString(_themeModeKey);
    final localeCode = prefs.getString(_localeKey);
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.name == themeModeName,
        orElse: () => ThemeMode.system,
      ),
      locale: localeCode == null ? null : Locale(localeCode),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await ref
        .read(sharedPreferencesProvider)
        .setString(_themeModeKey, mode.name);
  }

  /// null を渡すと端末設定に従う。
  Future<void> setLocale(Locale? locale) async {
    state = state.copyWith(locale: locale);
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
  }
}
