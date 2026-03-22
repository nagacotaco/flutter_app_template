import 'package:flutter_app_template/core/auth/infrastructure/auth_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'sign_up_page_state.dart';

final signUpPageVMProvider =
    NotifierProvider<SignUpPageViewModel, SignUpPageState>(
  SignUpPageViewModel.new,
);

class SignUpPageViewModel extends Notifier<SignUpPageState> {
  @override
  SignUpPageState build() => const SignUpPageState();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'メールアドレスを入力してください';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 8) return '8文字以上のパスワードを入力してください';
    return null;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(authRepositoryProvider).createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}
