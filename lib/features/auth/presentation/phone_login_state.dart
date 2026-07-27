import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_login_state.freezed.dart';

enum PhoneLoginStep { inputPhone, inputOtp }

@freezed
abstract class PhoneLoginState with _$PhoneLoginState {
  const factory PhoneLoginState({
    @Default(PhoneLoginStep.inputPhone) PhoneLoginStep step,
    @Default('') String phone,
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = _PhoneLoginState;
}
