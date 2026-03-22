import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/presentation/login_page.dart';
import 'package:flutter_app_template/core/auth/presentation/sign_up_page.dart';
import 'package:flutter_app_template/core/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter_app_template/features/catalog/presentation/catalog_page.dart';
import 'package:flutter_app_template/features/home/presentation/pages/detail_page.dart';
import 'package:flutter_app_template/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

// ── 認証ページ（BottomNav なし） ──────────────────────────────────────────────

@TypedGoRoute<LoginRoute>(
  path: '/login',
  routes: [
    TypedGoRoute<SignUpRoute>(path: 'sign-up'),
  ],
)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const LoginPage());
}

class SignUpRoute extends GoRouteData with $SignUpRoute {
  const SignUpRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const SignUpPage());
}

// ── メインShell（BottomNav あり） ─────────────────────────────────────────────

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: '/',
          routes: <TypedRoute<RouteData>>[
            // ネストルートはボトムナビが表示され続ける
            TypedGoRoute<DetailRoute>(path: 'detail/:id'),
          ],
        ),
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

class CatalogBranchData extends StatefulShellBranchData {
  const CatalogBranchData();
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: const HomePage());
}

class DetailRoute extends GoRouteData with $DetailRoute {
  const DetailRoute({required this.id});

  final int id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      _buildFadePage(state: state, child: DetailPage(id: id));
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
