import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/auth/presentation/phone_login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'phone_login_view_model.g.dart';

/// 電話番号ログイン（2ステップ: 番号入力 → OTP 入力）。
@riverpod
class PhoneLoginViewModel extends _$PhoneLoginViewModel {
  @override
  PhoneLoginState build() => const PhoneLoginState();

  Future<void> sendOtp(String phone) async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await ref.read(authRepositoryProvider).sendPhoneOtp(phone);
      state = state.copyWith(
        isSubmitting: false,
        phone: phone,
        step: PhoneLoginStep.inputOtp,
      );
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }

  /// 成功時は router の redirect が自動でホームへ遷移する。
  Future<void> verifyOtp(String token) async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await ref
          .read(authRepositoryProvider)
          .verifyPhoneOtp(phone: state.phone, token: token);
      state = state.copyWith(isSubmitting: false);
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }

  /// 番号入力ステップへ戻る。
  void backToPhoneInput() {
    state = state.copyWith(step: PhoneLoginStep.inputPhone, errorMessage: null);
  }
}
