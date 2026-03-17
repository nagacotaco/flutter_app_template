import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/core/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter_app_template/features/catalog/presentation/catalog_page.dart';
import 'package:flutter_app_template/features/home/presentation/screens/detail_screen.dart';
import 'package:flutter_app_template/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_app_template/features/search/presentation/search_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouter = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: AppRoutes.home.path,
    routes: routes,
  ),
);

final routes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ScaffoldWithNavBar(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            pageBuilder: (context, state) => buildPageWithTransition(
              state: state,
              child: const HomeScreen(),
            ),
            routes: [
              // ネストルートに設定すると、遷移後もボトムナビが表示され続ける
              GoRoute(
                path: AppRoutes.detail.name, // ネストされたルートは「/」を省くことが推奨されます
                pageBuilder: (context, state) => buildPageWithTransition(
                  state: state,
                  child: const DetailScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(routes: [
        GoRoute(
          path: AppRoutes.search.path,
          pageBuilder: (context, state) => buildPageWithTransition(
            state: state,
            child: const SearchPage(),
          ),
        ),
      ]),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.catalogPage.path,
            pageBuilder: (context, state) => buildPageWithTransition(
              state: state,
              child: const CatalogPage(),
            ),
          ),
        ],
      ),
    ],
  )
];

// 共通のpageBuilderを関数化
Page buildPageWithTransition({
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
