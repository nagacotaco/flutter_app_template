import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderScope> buildApp() async {
  final prefs = await SharedPreferences.getInstance();
  return ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      authStateChangesProvider.overrideWith(
        (ref) => const Stream<AppUser?>.empty(),
      ),
      currentUserProvider.overrideWith((ref) => null),
    ],
    child: const App(),
  );
}

void main() {
  testWidgets('初回起動でオンボーディングが表示され、スキップでログイン画面へ進む', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text('Log in'), findsWidgets);
  });

  testWidgets('最終ページの開始ボタンで完了し、ログイン画面へ進む', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('Log in'), findsWidgets);
  });

  testWidgets('完了済みならオンボーディングを表示しない', (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding.completed': true});

    await tester.pumpWidget(await buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsNothing);
    expect(find.text('Log in'), findsWidgets);
  });
}
