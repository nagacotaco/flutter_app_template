import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('未ログインで起動するとログイン画面が表示される', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          // テストではバックエンドを初期化しないため、認証状態を override する
          authStateChangesProvider.overrideWith(
            (ref) => const Stream<AppUser?>.empty(),
          ),
          currentUserProvider.overrideWith((ref) => null),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    // テスト環境のロケールは en。ログイン画面の AppBar タイトルとボタンに表示される
    expect(find.text('Log in'), findsWidgets);
  });
}
