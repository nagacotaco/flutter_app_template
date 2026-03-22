import 'package:flutter_app_template/core/auth/infrastructure/auth_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'login_page_state.dart';

final loginPageVMProvider = NotifierProvider<LoginPageViewModel, LoginPageState>(
  LoginPageViewModel.new,
);

class LoginPageViewModel extends Notifier<LoginPageState> {
  @override
  LoginPageState build() => const LoginPageState();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'メールアドレスを入力してください';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'パスワードを入力してください';
    return null;
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}
