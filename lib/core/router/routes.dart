import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/app_shell.dart';
import 'package:flutter_app_template/features/home/presentation/home_screen.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_screen.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_screen.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_screen.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

/// ルート定義（Typed Routes）。
/// feature を追加/削除するときは、このファイルの該当ブランチと
/// TypedGoRoute を数行足す/消すだけで完結させること（docs/ARCHITECTURE.md）。
@TypedStatefulShellRoute<AppShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(
      routes: [TypedGoRoute<HomeRoute>(path: '/home')],
    ),
    TypedStatefulShellBranch<ItemsBranch>(
      routes: [
        TypedGoRoute<ItemsRoute>(
          path: '/items',
          routes: [TypedGoRoute<ItemDetailRoute>(path: ':id')],
        ),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: [TypedGoRoute<SettingsRoute>(path: '/settings')],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppShell(navigationShell: navigationShell);
  }
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class ItemsBranch extends StatefulShellBranchData {
  const ItemsBranch();
}

class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class ItemsRoute extends GoRouteData with $ItemsRoute {
  const ItemsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ItemListScreen();
}

/// ディープリンク対応: `/items/:id` のパスパラメータが [id] に入る。
class ItemDetailRoute extends GoRouteData with $ItemDetailRoute {
  const ItemDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ItemDetailScreen(itemId: id);
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
