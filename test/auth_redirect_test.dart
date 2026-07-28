import 'dart:async';

import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/fake_auth_repository.dart';

/// 認証状態ストリームを外部から発火できる fake。
class _StreamingFakeAuthRepository extends FakeAuthRepository {
  final controller = StreamController<AppUser?>.broadcast();

  @override
  Stream<AppUser?> authStateChanges() => controller.stream;
}

void main() {
  testWidgets('ログイン状態になると自動でホームへ遷移する', (tester) async {
    // オンボーディングは完了済みとして起動する
    SharedPreferences.setMockInitialValues({'onboarding.completed': true});
    final prefs = await SharedPreferences.getInstance();
    final auth = _StreamingFakeAuthRepository();

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
    expect(find.text('Log in'), findsWidgets);

    // サインアップ/ログイン成功に相当: currentUser が入り、ストリームが発火する
    auth.currentUser = const AppUser(id: 'user-1', email: 'a@example.com');
    auth.controller.add(auth.currentUser);
    await tester.pumpAndSettle();

    expect(find.text('Log in'), findsNothing);
    await auth.controller.close();
  });
}
