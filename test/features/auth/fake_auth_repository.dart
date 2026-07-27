import 'package:flutter_app_template/core/auth/auth_repository.dart';

/// [AuthRepository] のテスト用 fake（手書き fake が標準。docs/ARCHITECTURE.md §6）。
class FakeAuthRepository implements AuthRepository {
  /// 呼ばれたメソッド名の記録。
  final List<String> calls = [];

  /// 次の呼び出しで投げるエラー。一度投げたら自動でクリアされる。
  Object? nextError;

  /// signUp がセッションを発行したことにするか（false = メール確認待ち）。
  bool signUpReturnsSession = false;

  Future<void> _record(String name) async {
    calls.add(name);
    final error = nextError;
    if (error != null) {
      nextError = null;
      throw error;
    }
  }

  @override
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) => _record('signInWithPassword');

  @override
  Future<bool> signUp({required String email, required String password}) async {
    await _record('signUp');
    return signUpReturnsSession;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _record('sendPasswordResetEmail');

  @override
  Future<void> sendPhoneOtp(String phone) => _record('sendPhoneOtp');

  @override
  Future<void> verifyPhoneOtp({required String phone, required String token}) =>
      _record('verifyPhoneOtp');

  @override
  Future<void> signInWithGoogle() => _record('signInWithGoogle');

  @override
  Future<void> signInWithApple() => _record('signInWithApple');

  @override
  Future<void> signOut() => _record('signOut');

  @override
  Future<void> deleteAccount() => _record('deleteAccount');
}
