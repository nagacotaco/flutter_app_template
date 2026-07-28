import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/config/app_config_repository.dart';
import 'package:flutter_app_template/core/constants/app_links.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// アプリ設定による起動ゲート。MaterialApp.router の builder で全画面をラップする。
/// メンテナンス中はメンテナンス画面、ビルド番号が min_build_number 未満なら
/// 強制アップデート画面を出す。取得中・取得失敗時は通常どおりアプリを表示する
/// （オフラインで起動できなくなるのを避ける fail-open）。
class AppConfigGate extends ConsumerWidget {
  const AppConfigGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider).value;
    final buildNumber = ref.watch(currentBuildNumberProvider).value;
    if (config == null || buildNumber == null) return child;

    if (config.maintenanceMode) {
      return _StatusScreen(
        icon: Icons.build_outlined,
        title: context.l10n.appConfigMaintenanceTitle,
        message:
            config.maintenanceMessage ??
            context.l10n.appConfigMaintenanceMessage,
      );
    }
    if (buildNumber < config.minBuildNumber) {
      return _StatusScreen(
        icon: Icons.system_update_alt,
        title: context.l10n.appConfigUpdateTitle,
        message: context.l10n.appConfigUpdateMessage,
        action: FilledButton(
          onPressed: () => launchUrl(
            AppLinks.storePage,
            mode: LaunchMode.externalApplication,
          ),
          child: Text(context.l10n.appConfigUpdateButton),
        ),
      );
    }
    return child;
  }
}

class _StatusScreen extends StatelessWidget {
  const _StatusScreen({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              if (action != null) ...[const SizedBox(height: 24), action!],
            ],
          ),
        ),
      ),
    );
  }
}
