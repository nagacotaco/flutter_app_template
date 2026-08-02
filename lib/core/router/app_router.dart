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
      // 初回起動はオンボーディングを最優先で表示する。
      // ディープリンクで起動した場合は元の遷移先を `?from=` に退避し、
      // オンボーディング完了・ログイン後に復帰する（連鎖 redirect で
      // /onboarding?from=... → /login?from=... と引き継がれる）
      final onboardingCompleted = ref.read(onboardingCompletedProvider);
      final onOnboarding =
          state.matchedLocation == const OnboardingRoute().location;
      if (!onboardingCompleted) {
        return onOnboarding
            ? null
            : OnboardingRoute(from: redirectTargetOf(state)).location;
      }
      if (onOnboarding) {
        return sanitizeFrom(state.uri.queryParameters['from']) ??
            const HomeRoute().location;
      }

      final loggedIn = ref.read(currentUserProvider) != null;
      final onAuthScreen = state.matchedLocation.startsWith(
        const LoginRoute().location,
      );
      if (!loggedIn && !onAuthScreen) {
        return LoginRoute(from: redirectTargetOf(state)).location;
      }
      if (loggedIn && onAuthScreen) {
        return sanitizeFrom(state.uri.queryParameters['from']) ??
            const HomeRoute().location;
      }
      return null;
    },
  );
}

/// redirect で退避する「認証後の復帰先」を現在の遷移から求める。
/// オンボーディング・認証画面にいる間は退避済みの `?from=` を引き継ぐ。
@visibleForTesting
String? redirectTargetOf(GoRouterState state) {
  final loc = state.matchedLocation;
  if (loc == const OnboardingRoute().location ||
      loc.startsWith(const LoginRoute().location)) {
    return sanitizeFrom(state.uri.queryParameters['from']);
  }
  // 既定の着地先へのディープリンクは退避する意味がない
  if (loc == const HomeRoute().location) return null;
  // Universal Links は scheme/host 付きの URI で届くため path+query に正規化する
  final uri = state.uri;
  return sanitizeFrom(
    Uri(path: uri.path, query: uri.query.isEmpty ? null : uri.query).toString(),
  );
}

/// `?from=` の値をアプリ内パスに限定する。
/// `?from=` は OS のディープリンクから直接注入できるため、外部 URL
/// （open redirect）とオンボーディング・認証画面（redirect ループ）を弾く。
@visibleForTesting
String? sanitizeFrom(String? from) {
  if (from == null || from.isEmpty) return null;
  final uri = Uri.tryParse(from);
  if (uri == null) return null;
  // `//evil.com` は scheme 無しでも authority を持つため両方確認する
  if (uri.hasScheme || uri.hasAuthority) return null;
  if (!from.startsWith('/')) return null;
  if (uri.path == const OnboardingRoute().location ||
      uri.path.startsWith(const LoginRoute().location)) {
    return null;
  }
  return from;
}
