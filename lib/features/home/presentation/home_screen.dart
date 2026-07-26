import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 仮のホーム画面。状態を持たない静的画面のため ViewModel なし
/// （docs/ARCHITECTURE.md 5章の例外規定）。
/// Phase 1 でボトムナビゲーション + Typed Routes に置き換える。
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.homeTitle)),
      body: Center(child: Text(context.l10n.appTitle)),
    );
  }
}
