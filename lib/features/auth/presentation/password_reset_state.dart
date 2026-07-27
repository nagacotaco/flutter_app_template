import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_state.freezed.dart';

@freezed
abstract class PasswordResetState with _$PasswordResetState {
  const factory PasswordResetState({
    @Default(false) bool isSubmitting,
    @Default(false) bool emailSent,
    String? errorMessage,
  }) = _PasswordResetState;
}
