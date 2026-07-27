import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/core/auth/supabase_auth_repository.dart';
import 'package:flutter_app_template/core/backend.dart';
import 'package:flutter_app_template/core/supabase/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

/// core/backend.dart の設定に応じた実装を返す。
/// 選択されなかった側の依存（Supabase クライアント等）には触れない。
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => switch (appBackend) {
  AppBackend.supabase => SupabaseAuthRepository(
    ref.watch(supabaseClientProvider),
  ),
  AppBackend.firebase => FirebaseAuthRepository(FirebaseAuth.instance),
};

/// 認証エラーの共通例外。バックエンド固有の例外は各実装がこれに変換する。
/// [message] はそのまま画面のエラー表示に使われる。
class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

/// 認証操作の抽象。Supabase / Firebase の実装を core/backend.dart で切り替える。
/// auth / settings / profile の複数 feature から使うため core に置く
/// （docs/ARCHITECTURE.md: 複数 feature から使う Repository は core）。
abstract interface class AuthRepository {
  /// ログイン中のユーザー。未ログインなら null。
  AppUser? get currentUser;

  /// 認証状態の変化ストリーム（ログイン/ログアウトで発火する）。
  Stream<AppUser?> authStateChanges();

  Future<void> signInWithPassword({
    required String email,
    required String password,
  });

  /// 戻り値はセッションが発行されたかどうか。
  /// メール確認が必要な設定の場合は false（確認メール送信済み）になる。
  Future<bool> signUp({required String email, required String password});

  Future<void> sendPasswordResetEmail(String email);

  Future<void> sendPhoneOtp(String phone);

  Future<void> verifyPhoneOtp({required String phone, required String token});

  /// キャンセル時は例外を投げず何もせず戻る。
  Future<void> signInWithGoogle();

  /// キャンセル時は例外を投げず何もせず戻る。
  Future<void> signInWithApple();

  Future<void> signOut();

  /// アカウントを削除し、ローカルセッションも破棄する。
  Future<void> deleteAccount();
}
