import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_page_state.freezed.dart';

@freezed
abstract class LoginPageState with _$LoginPageState {
  const LoginPageState._();
  const factory LoginPageState({
    @Default(false) bool isLoading,
    Object? error,
  }) = _LoginPageState;
}
