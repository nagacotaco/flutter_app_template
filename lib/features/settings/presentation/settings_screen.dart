import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 設定画面（仮）。状態を持たない静的画面のため ViewModel なし
/// （docs/ARCHITECTURE.md 5章の例外規定）。Phase 3 で本実装する。
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsTitle)),
      body: Center(child: Text(context.l10n.settingsPlaceholder)),
    );
  }
}
