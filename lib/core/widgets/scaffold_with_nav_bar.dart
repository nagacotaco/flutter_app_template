// ラッパーWidget
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_sizes.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell, // ここに現在の画面が入る
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.md,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.borderMax,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
              tileMode: TileMode.decal,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (int index) {
                  // タブの状態を保持しながら切り替え
                  navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  );
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pets),
                    label: 'Pets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.light),
                    label: 'samples',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
