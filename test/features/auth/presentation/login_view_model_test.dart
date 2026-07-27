import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/auth/presentation/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../helpers/create_container.dart';
import '../fake_auth_repository.dart';

void main() {
  group('LoginViewModel', () {
    test('signInWithPassword: 成功したらエラーなしで完了する', () async {
      final repository = FakeAuthRepository();
      final container = createContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(loginViewModelProvider, (_, _) {});

      await container
          .read(loginViewModelProvider.notifier)
          .signInWithPassword(email: 'a@example.com', password: 'password');

      final state = container.read(loginViewModelProvider);
      expect(state.isSubmitting, false);
      expect(state.errorMessage, null);
      expect(repository.calls, ['signInWithPassword']);
    });

    test('signInWithPassword: AuthException の message が state に入る', () async {
      final repository = FakeAuthRepository()
        ..nextError = const AuthException('Invalid login credentials');
      final container = createContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(loginViewModelProvider, (_, _) {});

      await container
          .read(loginViewModelProvider.notifier)
          .signInWithPassword(email: 'a@example.com', password: 'wrong');

      final state = container.read(loginViewModelProvider);
      expect(state.isSubmitting, false);
      expect(state.errorMessage, 'Invalid login credentials');
    });

    test('signInWithGoogle: 失敗が state に反映される', () async {
      final repository = FakeAuthRepository()
        ..nextError = const AuthException('Missing Google ID token.');
      final container = createContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(loginViewModelProvider, (_, _) {});

      await container.read(loginViewModelProvider.notifier).signInWithGoogle();

      expect(
        container.read(loginViewModelProvider).errorMessage,
        'Missing Google ID token.',
      );
    });
  });
}
