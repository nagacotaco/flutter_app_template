import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/router/app_shell.dart';
import 'package:flutter_app_template/features/auth/presentation/login_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/password_reset_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/phone_login_screen.dart';
import 'package:flutter_app_template/features/auth/presentation/signup_screen.dart';
import 'package:flutter_app_template/features/home/presentation/home_screen.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_screen.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_screen.dart';
import 'package:flutter_app_template/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_edit_screen.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_screen.dart';
import 'package:flutter_app_template/features/purchase/presentation/paywall_screen.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_screen.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

/// オンボーディング・認証画面が `?from=` で受け取る「認証後の復帰先」。
/// 画面間の遷移で引き回すときに使う（検証は app_router.dart の sanitizeFrom）。
extension RouteFromParam on BuildContext {
  String? get routeFrom => GoRouterState.of(this).uri.queryParameters['from'];
}

/// 初回起動のオンボーディング（シェル外）。
/// 未完了時は app_router.dart の redirect で誘導される。
@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute({this.from});

  /// オンボーディング完了後に復帰するパス（redirect が退避したディープリンク先）
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}

/// 認証画面群（シェル外）。未ログイン時は app_router.dart の redirect で
/// `/login` 配下へ誘導される。
@TypedGoRoute<LoginRoute>(
  path: '/login',
  routes: [
    TypedGoRoute<SignupRoute>(path: 'signup'),
    TypedGoRoute<PasswordResetRoute>(path: 'password-reset'),
    TypedGoRoute<PhoneLoginRoute>(path: 'phone-login'),
  ],
)
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute({this.from});

  /// ログイン後に復帰するパス（redirect が退避したディープリンク先）
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

class SignupRoute extends GoRouteData with $SignupRoute {
  const SignupRoute({this.from});

  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignupScreen();
}

class PasswordResetRoute extends GoRouteData with $PasswordResetRoute {
  const PasswordResetRoute({this.from});

  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PasswordResetScreen();
}

class PhoneLoginRoute extends GoRouteData with $PhoneLoginRoute {
  const PhoneLoginRoute({this.from});

  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PhoneLoginScreen();
}

/// ペイウォール（シェル外・全画面 push）。
/// 設定画面などから `const PaywallRoute().push(context)` で開く。
@TypedGoRoute<PaywallRoute>(path: '/paywall')
class PaywallRoute extends GoRouteData with $PaywallRoute {
  const PaywallRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PaywallScreen();
}

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
      routes: [
        TypedGoRoute<SettingsRoute>(
          path: '/settings',
          routes: [
            TypedGoRoute<ProfileRoute>(
              path: 'profile',
              routes: [TypedGoRoute<ProfileEditRoute>(path: 'edit')],
            ),
          ],
        ),
      ],
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

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

class ProfileEditRoute extends GoRouteData with $ProfileEditRoute {
  const ProfileEditRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileEditScreen();
}
