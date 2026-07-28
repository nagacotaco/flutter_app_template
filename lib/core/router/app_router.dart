import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/router/routes.dart';
import 'package:flutter_app_template/features/onboarding/data/onboarding_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// アプリ全体のルーター。
/// 認証状態の変化で redirect を再評価する（未ログイン → ログイン画面）。
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // GoRouter 自体は作り直さず、refreshListenable 経由で redirect のみ再評価する。
  // authStateChangesProvider（stream）ではなく currentUserProvider を listen する。
  // stream を直接 listen すると、currentUserProvider の再計算より先に redirect が
  // 走って古い値を読み、ログイン後にホームへ遷移しないことがある
  final refresh = ValueNotifier(0);
  ref
    ..listen(currentUserProvider, (_, _) => refresh.value++)
    ..listen(onboardingCompletedProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  return GoRouter(
    routes: $appRoutes,
    initialLocation: const HomeRoute().location,
    refreshListenable: refresh,
    redirect: (context, state) {
      // 初回起動はオンボーディングを最優先で表示する
      final onboardingCompleted = ref.read(onboardingCompletedProvider);
      final onOnboarding =
          state.matchedLocation == const OnboardingRoute().location;
      if (!onboardingCompleted) {
        return onOnboarding ? null : const OnboardingRoute().location;
      }
      if (onOnboarding) return const HomeRoute().location;

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
