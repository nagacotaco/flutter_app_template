import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/auth/presentation/signup_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'signup_view_model.g.dart';

@riverpod
class SignupViewModel extends _$SignupViewModel {
  @override
  SignupState build() => const SignupState();

  Future<void> signUp({required String email, required String password}) async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      final hasSession = await ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: password);
      // セッションが発行された場合は router の redirect が自動でホームへ遷移する。
      // メール確認が有効な場合はセッションがないため、確認メール案内を表示する
      state = state.copyWith(
        isSubmitting: false,
        confirmationEmailSent: !hasSession,
      );
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}
