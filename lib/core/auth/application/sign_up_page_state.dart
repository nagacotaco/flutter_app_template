import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_page_state.freezed.dart';

@freezed
abstract class SignUpPageState with _$SignUpPageState {
  const SignUpPageState._();
  const factory SignUpPageState({
    @Default(false) bool isLoading,
    Object? error,
  }) = _SignUpPageState;
}
