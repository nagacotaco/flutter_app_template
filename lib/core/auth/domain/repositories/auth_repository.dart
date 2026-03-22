import 'package:flutter_app_template/core/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  /// 認証状態の変化をStreamで通知する（null = 未認証）
  Stream<User?> get authStateChanges;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
