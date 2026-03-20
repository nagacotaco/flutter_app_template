import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter_app_template/features/catalog/presentation/catalog_page.dart';
import 'package:flutter_app_template/features/home/presentation/screens/detail_screen.dart';
import 'package:flutter_app_template/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_app_template/features/search/presentation/search_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: '/',
          routes: <TypedRoute<RouteData>>[
            // ネストルートはボトムナビが表示され続ける
            TypedGoRoute<DetailRoute>(path: 'detail'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SearchBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SearchRoute>(path: '/search'),
      ],
    ),
    TypedStatefulShellBranch<CatalogBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CatalogRoute>(path: '/catalog-page'),
      ],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}

class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();
}

class SearchBranchData extends StatefulShellBranchData {
  const SearchBranchData();
}

class CatalogBranchData extends StatefulShellBranchData {
  const CatalogBranchData();
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const HomeScreen());
}

class DetailRoute extends GoRouteData with $DetailRoute {
  const DetailRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const DetailScreen());
}

class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const SearchPage());
}

class CatalogRoute extends GoRouteData with $CatalogRoute {
  const CatalogRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const CatalogPage());
}

/// 画面遷移のアニメーション
Page<void> _buildFadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
