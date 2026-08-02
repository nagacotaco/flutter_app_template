import 'dart:async';

import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_app_template/features/home/presentation/home_screen.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_screen.dart';
import 'package:flutter_app_template/features/onboarding/data/onboarding_providers.dart';
import 'package:flutter_app_template/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/fake_auth_repository.dart';

/// 認証状態ストリームを外部から発火できる fake。
class _StreamingFakeAuthRepository extends FakeAuthRepository {
  final controller = StreamController<AppUser?>.broadcast();

  @override
  Stream<AppUser?> authStateChanges() => controller.stream;
}

/// App を起動して ProviderContainer を返す。
Future<ProviderContainer> _pumpApp(
  WidgetTester tester,
  _StreamingFakeAuthRepository auth, {
  bool onboardingCompleted = true,
}) async {
  SharedPreferences.setMockInitialValues({
    if (onboardingCompleted) 'onboarding.completed': true,
  });
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        authRepositoryProvider.overrideWithValue(auth),
      ],
      child: const App(),
    ),
  );
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(
    tester.element(find.byType(App)),
    listen: false,
  );
}

/// ログイン成功に相当: currentUser が入り、ストリームが発火する。
Future<void> _signIn(
  WidgetTester tester,
  _StreamingFakeAuthRepository auth,
) async {
  auth.currentUser = const AppUser(id: 'user-1', email: 'a@example.com');
  auth.controller.add(auth.currentUser);
  await tester.pumpAndSettle();
}

String _currentLocation(GoRouter router) =>
    router.routerDelegate.currentConfiguration.uri.toString();

void main() {
  testWidgets('ログイン状態になると自動でホームへ遷移する', (tester) async {
    final auth = _StreamingFakeAuthRepository();
    await _pumpApp(tester, auth);
    expect(find.text('Log in'), findsWidgets);

    await _signIn(tester, auth);

    expect(find.text('Log in'), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
    await auth.controller.close();
  });

  testWidgets('未ログインのディープリンクは from に退避され、ログイン後に復帰する', (tester) async {
    final auth = _StreamingFakeAuthRepository();
    final container = await _pumpApp(tester, auth);
    final router = container.read(routerProvider);

    // ディープリンク起動に相当
    router.go('/items/1');
    await tester.pumpAndSettle();

    expect(find.text('Log in'), findsWidgets);
    expect(_currentLocation(router), '/login?from=%2Fitems%2F1');

    await _signIn(tester, auth);

    expect(_currentLocation(router), '/items/1');
    expect(find.byType(ItemDetailScreen), findsOneWidget);
    await auth.controller.close();
  });

  testWidgets('オンボーディング未完了でも from はログインまで引き継がれる（多段復帰）', (tester) async {
    final auth = _StreamingFakeAuthRepository();
    final container = await _pumpApp(tester, auth, onboardingCompleted: false);
    final router = container.read(routerProvider);

    router.go('/items/1');
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(_currentLocation(router), '/onboarding?from=%2Fitems%2F1');

    // オンボーディング完了に相当（画面は最終ページのボタンで complete() を呼ぶ）
    await container.read(onboardingCompletedProvider.notifier).complete();
    await tester.pumpAndSettle();

    // 未ログインなので連鎖 redirect でログインへ（from は失われない）
    expect(_currentLocation(router), '/login?from=%2Fitems%2F1');

    await _signIn(tester, auth);

    expect(_currentLocation(router), '/items/1');
    expect(find.byType(ItemDetailScreen), findsOneWidget);
    await auth.controller.close();
  });

  testWidgets('ログイン→アカウント登録へ移動しても from は維持される', (tester) async {
    final auth = _StreamingFakeAuthRepository();
    final container = await _pumpApp(tester, auth);
    final router = container.read(routerProvider);

    router.go('/items/1');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    expect(_currentLocation(router), '/login/signup?from=%2Fitems%2F1');

    await _signIn(tester, auth);

    expect(_currentLocation(router), '/items/1');
    expect(find.byType(ItemDetailScreen), findsOneWidget);
    await auth.controller.close();
  });

  testWidgets('外部 URL の from は破棄してホームへ遷移する（open redirect 対策）', (tester) async {
    final auth = _StreamingFakeAuthRepository();
    final container = await _pumpApp(tester, auth);
    final router = container.read(routerProvider);

    // OS のディープリンクから from を直接注入されたケース
    router.go('/login?from=https%3A%2F%2Fevil.com');
    await tester.pumpAndSettle();

    await _signIn(tester, auth);

    expect(_currentLocation(router), '/home');
    expect(find.byType(HomeScreen), findsOneWidget);
    await auth.controller.close();
  });
}
