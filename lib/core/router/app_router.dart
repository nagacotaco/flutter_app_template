import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// アプリ全体のルーター。
/// 認証状態の変化で redirect を再評価する（未ログイン → ログイン画面）。
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // GoRouter 自体は作り直さず、refreshListenable 経由で redirect のみ再評価する
  final refresh = ValueNotifier(0);
  ref
    ..listen(authStateChangesProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  return GoRouter(
    routes: $appRoutes,
    initialLocation: const HomeRoute().location,
    refreshListenable: refresh,
    redirect: (context, state) {
      final loggedIn = ref.read(currentUserProvider) != null;
      final onAuthScreen = state.matchedLocation.startsWith(
        const LoginRoute().location,
      );
      if (!loggedIn && !onAuthScreen) return const LoginRoute().location;
      if (loggedIn && onAuthScreen) return const HomeRoute().location;
      return null;
    },
  );
}
