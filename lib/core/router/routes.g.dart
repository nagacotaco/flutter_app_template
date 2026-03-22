// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginRoute,
      $appShellRouteData,
    ];

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'sign-up',
          factory: $SignUpRoute._fromState,
        ),
      ],
    );

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location(
        '/login',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  @override
  String get location => GoRouteData.$location(
        '/login/sign-up',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appShellRouteData => StatefulShellRouteData.$route(
      factory: $AppShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $HomeRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'detail/:id',
                  factory: $DetailRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/petstore',
              factory: $PetListRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'detail/:id',
                  factory: $PetDetailRoute._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/catalog-page',
              factory: $CatalogRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DetailRoute on GoRouteData {
  static DetailRoute _fromState(GoRouterState state) => DetailRoute(
        id: int.parse(state.pathParameters['id']!),
      );

  DetailRoute get _self => this as DetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/detail/${Uri.encodeComponent(_self.id.toString())}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PetListRoute on GoRouteData {
  static PetListRoute _fromState(GoRouterState state) => const PetListRoute();

  @override
  String get location => GoRouteData.$location(
        '/petstore',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PetDetailRoute on GoRouteData {
  static PetDetailRoute _fromState(GoRouterState state) => PetDetailRoute(
        id: int.parse(state.pathParameters['id']!),
      );

  PetDetailRoute get _self => this as PetDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/petstore/detail/${Uri.encodeComponent(_self.id.toString())}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CatalogRoute on GoRouteData {
  static CatalogRoute _fromState(GoRouterState state) => const CatalogRoute();

  @override
  String get location => GoRouteData.$location(
        '/catalog-page',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
