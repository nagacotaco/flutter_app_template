import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 設定画面。画面固有の状態を持たず、core/settings のグローバル状態を
/// 直接 watch するため ViewModel なし（docs/ARCHITECTURE.md 5章の例外規定）。
/// プロフィール・ログアウト・退会は Phase 2/3（認証導入後）で追加する。
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: Text(l10n.settingsThemeTitle),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  notifier.setThemeMode(mode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(l10n.settingsThemeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(l10n.settingsThemeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(l10n.settingsThemeDark),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(l10n.settingsLanguageTitle),
            trailing: DropdownButton<String>(
              value: settings.locale?.languageCode ?? 'system',
              onChanged: (code) {
                if (code == null) return;
                notifier.setLocale(code == 'system' ? null : Locale(code));
              },
              items: [
                DropdownMenuItem(
                  value: 'system',
                  child: Text(l10n.settingsLanguageSystem),
                ),
                const DropdownMenuItem(value: 'ja', child: Text('日本語')),
                const DropdownMenuItem(value: 'en', child: Text('English')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
