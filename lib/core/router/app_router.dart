import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/auth/application/auth_provider.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouter = Provider<GoRouter>(
  (ref) {
    final notifier = _RouterNotifier(ref);
    return GoRouter(
      initialLocation: const HomeRoute().location,
      refreshListenable: notifier,
      redirect: notifier.redirect,
      routes: $appRoutes,
    );
  },
);

/// auth状態の変化をGoRouterに通知するChangeNotifier
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;

  static const _authPaths = {'/login', '/login/sign-up'};

  String? redirect(BuildContext context, GoRouterState state) {
    final authAsync = _ref.read(authStateProvider);

    // 認証状態ロード中はリダイレクトしない
    if (authAsync.isLoading) return null;

    final isAuthenticated = authAsync.valueOrNull != null;
    final isOnAuthPage = _authPaths.contains(state.matchedLocation);

    if (!isAuthenticated && !isOnAuthPage) return const LoginRoute().location;
    if (isAuthenticated && isOnAuthPage) return const HomeRoute().location;
    return null;
  }
}
