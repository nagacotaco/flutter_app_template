import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_app_template/core/env/app_env.dart';
import 'package:flutter_app_template/core/supabase/supabase_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(supabaseClientProvider));

/// 認証操作の Repository。
/// auth / settings / profile の複数 feature から使うため core に置く
/// （docs/ARCHITECTURE.md: 複数 feature から使う Repository は core）。
class AuthRepository {
  AuthRepository(this._client);

  final SupabaseClient _client;

  static bool _googleInitialized = false;

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) => _client.auth.signInWithPassword(email: email, password: password);

  /// 戻り値はセッションが発行されたかどうか。
  /// Supabase のメール確認が有効な場合は false（確認メール送信済み）になる。
  Future<bool> signUp({required String email, required String password}) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    return response.session != null;
  }

  Future<void> sendPasswordResetEmail(String email) =>
      _client.auth.resetPasswordForEmail(email);

  /// SMS プロバイダ未契約でも Supabase ダッシュボードの
  /// テスト用電話番号 + OTP で動作確認できる（Auth > Providers > Phone）。
  Future<void> sendPhoneOtp(String phone) =>
      _client.auth.signInWithOtp(phone: phone);

  Future<void> verifyPhoneOtp({required String phone, required String token}) =>
      _client.auth.verifyOTP(type: OtpType.sms, phone: phone, token: token);

  /// Google ネイティブサインイン → ID トークンを Supabase に渡す方式。
  /// GOOGLE_WEB_CLIENT_ID / GOOGLE_IOS_CLIENT_ID を env/*.json に設定すること
  /// （手順は lib/features/auth/README.md）。キャンセル時は何もせず戻る。
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;
    if (!_googleInitialized) {
      await googleSignIn.initialize(
        clientId: AppEnv.googleIosClientId.isEmpty
            ? null
            : AppEnv.googleIosClientId,
        serverClientId: AppEnv.googleWebClientId.isEmpty
            ? null
            : AppEnv.googleWebClientId,
      );
      _googleInitialized = true;
    }
    final GoogleSignInAccount account;
    try {
      account = await googleSignIn.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      rethrow;
    }
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const AuthException('Missing Google ID token.');
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  /// Apple サインイン（nonce 検証付き）。キャンセル時は何もせず戻る。
  /// Xcode で Sign in with Apple の Capability 追加が必要
  /// （手順は lib/features/auth/README.md）。
  Future<void> signInWithApple() async {
    final rawNonce = _client.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    final AuthorizationCredentialAppleID credential;
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return;
      rethrow;
    }
    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException('Missing Apple ID token.');
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  Future<void> signOut() => _client.auth.signOut();

  /// supabase/migrations の delete_account 関数（SECURITY DEFINER）で
  /// 自分のアカウントを削除し、ローカルセッションを破棄する。
  Future<void> deleteAccount() async {
    await _client.rpc<void>('delete_account');
    await _client.auth.signOut();
  }
}
