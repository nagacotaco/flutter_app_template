import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/auth/presentation/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.g.dart';

/// 初期の非同期取得がない画面のため同期 build（docs/ARCHITECTURE.md §3）。
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => const LoginState();

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) => _run(
    () => ref
        .read(authRepositoryProvider)
        .signInWithPassword(email: email, password: password),
  );

  Future<void> signInWithGoogle() =>
      _run(() => ref.read(authRepositoryProvider).signInWithGoogle());

  Future<void> signInWithApple() =>
      _run(() => ref.read(authRepositoryProvider).signInWithApple());

  /// 成功時は認証状態の変化を router の redirect が拾って遷移するため、
  /// ViewModel からは画面遷移しない。
  Future<void> _run(Future<void> Function() action) async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await action();
      state = state.copyWith(isSubmitting: false);
    } on AuthFailure catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.message);
    } on Exception catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: e.toString());
    }
  }
}
