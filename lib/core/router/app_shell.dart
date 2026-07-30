import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

/// ボトムナビゲーションを持つシェル。
/// 各タブのナビゲーション状態は StatefulShellRoute が保持する。
///
/// ラベルは表示しない（`labelBehavior: alwaysHide` と indicator の透過は
/// NavigationBarTheme 側で指定）。選択状態は**塗りアイコン／輪郭アイコン**で示し、
/// 色では示さない（DESIGN.md §5）。label 引数はスクリーンリーダー用に残している。
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // 同じタブを再タップしたらそのタブの先頭に戻す
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: context.l10n.homeTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.list_alt_outlined),
            selectedIcon: const Icon(Icons.list_alt),
            label: context.l10n.itemsTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: context.l10n.settingsTitle,
          ),
        ],
      ),
    );
  }
}
