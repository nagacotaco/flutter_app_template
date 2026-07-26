import 'package:flutter_app_template/core/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// アプリ全体のルーター。
/// Phase 2 で認証状態による redirect（未ログイン → ログイン画面）を追加する。
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    routes: $appRoutes,
    initialLocation: const HomeRoute().location,
  );
}
