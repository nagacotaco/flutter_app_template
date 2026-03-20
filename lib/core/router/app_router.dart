import 'package:flutter_app_template/core/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appRouter = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: const HomeRoute().location,
    routes: [$appShellRouteData],
  ),
);
