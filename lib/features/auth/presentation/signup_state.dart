import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

@freezed
abstract class SignupState with _$SignupState {
  const factory SignupState({
    @Default(false) bool isSubmitting,
    @Default(false) bool confirmationEmailSent,
    String? errorMessage,
  }) = _SignupState;
}
