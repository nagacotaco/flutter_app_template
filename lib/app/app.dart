import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/theme/app_theme.dart';
import 'package:flutter_app_template/features/home/presentation/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリのルートウィジェット。
/// Phase 1 で go_router 導入時に MaterialApp.router へ移行する。
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeScreen(),
    );
  }
}
