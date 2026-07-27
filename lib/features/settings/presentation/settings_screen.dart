import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/constants/app_links.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_app_template/core/widgets/error_view.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_state.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsTitle)),
      body: switch (state) {
        AsyncData(:final value) => _Body(state: value),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(settingsViewModelProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.state});

  final SettingsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);
    final viewModel = ref.read(settingsViewModelProvider.notifier);
    final l10n = context.l10n;
    final errorColor = Theme.of(context).colorScheme.error;

    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.brightness_6_outlined),
          title: Text(l10n.settingsThemeTitle),
          trailing: DropdownButton<ThemeMode>(
            value: settings.themeMode,
            onChanged: (mode) {
              if (mode != null) {
                settingsNotifier.setThemeMode(mode);
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
              settingsNotifier.setLocale(
                code == 'system' ? null : Locale(code),
              );
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
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person_outlined),
          title: Text(l10n.profileTitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => const ProfileRoute().go(context),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: Text(l10n.settingsTermsOfService),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => launchUrl(AppLinks.termsOfService),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: Text(l10n.settingsPrivacyPolicy),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => launchUrl(AppLinks.privacyPolicy),
        ),
        ListTile(
          leading: const Icon(Icons.info_outlined),
          title: Text(l10n.settingsVersion),
          trailing: Text(state.appVersion),
        ),
        const Divider(),
        if (state.errorMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              state.errorMessage!,
              style: TextStyle(color: errorColor),
            ),
          ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: Text(l10n.settingsLogout),
          enabled: !state.isProcessing,
          onTap: viewModel.signOut,
        ),
        ListTile(
          leading: Icon(Icons.delete_forever_outlined, color: errorColor),
          title: Text(
            l10n.settingsDeleteAccount,
            style: TextStyle(color: errorColor),
          ),
          enabled: !state.isProcessing,
          onTap: () => _confirmDeleteAccount(context, viewModel),
        ),
      ],
    );
  }

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    SettingsViewModel viewModel,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(dialogContext.l10n.settingsDeleteAccountConfirmTitle),
        content: Text(dialogContext.l10n.settingsDeleteAccountConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(dialogContext.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(dialogContext.l10n.settingsDeleteAccountConfirmButton),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await viewModel.deleteAccount();
    }
  }
}
