import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/auth/presentation/password_reset_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'password_reset_view_model.g.dart';

@riverpod
class PasswordResetViewModel extends _$PasswordResetViewModel {
  @override
  PasswordResetState build() => const PasswordResetState();

  Future<void> sendResetEmail(String email) async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
      state = state.copyWith(isSubmitting: false, emailSent: true);
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}
