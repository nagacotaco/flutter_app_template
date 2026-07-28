import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/config/app_config_gate.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/notifications/push_notifications.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリのルートウィジェット。
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    // プッシュ通知の初期化（無効時・Firebase 未初期化時は何もしない）
    ref.watch(pushNotificationInitProvider);

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      // 全画面をゲートでラップし、メンテナンス/強制アップデートを差し込む
      builder: (context, child) =>
          AppConfigGate(child: child ?? const SizedBox.shrink()),
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
