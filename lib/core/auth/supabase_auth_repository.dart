import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/core/env/app_env.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [AuthRepository] の Supabase 実装。
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

  static bool _googleInitialized = false;

  @override
  AppUser? get currentUser => _toAppUser(_client.auth.currentUser);

  @override
  Stream<AppUser?> authStateChanges() => _client.auth.onAuthStateChange.map(
    (event) => _toAppUser(event.session?.user),
  );

  @override
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) => _guard(
    () => _client.auth.signInWithPassword(email: email, password: password),
  );

  @override
  Future<bool> signUp({required String email, required String password}) =>
      _guard(() async {
        final response = await _client.auth.signUp(
          email: email,
          password: password,
        );
        return response.session != null;
      });

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _guard(() => _client.auth.resetPasswordForEmail(email));

  /// SMS プロバイダ未契約でも Supabase ダッシュボードの
  /// テスト用電話番号 + OTP で動作確認できる（Auth > Providers > Phone）。
  @override
  Future<void> sendPhoneOtp(String phone) =>
      _guard(() => _client.auth.signInWithOtp(phone: phone));

  @override
  Future<void> verifyPhoneOtp({required String phone, required String token}) =>
      _guard(
        () => _client.auth.verifyOTP(
          type: OtpType.sms,
          phone: phone,
          token: token,
        ),
      );

  /// Google ネイティブサインイン → ID トークンを Supabase に渡す方式。
  /// GOOGLE_WEB_CLIENT_ID / GOOGLE_IOS_CLIENT_ID を env/*.json に設定すること。
  @override
  Future<void> signInWithGoogle() => _guard(() async {
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
      throw const AuthFailure('Missing Google ID token.');
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  });

  /// Apple サインイン（nonce 検証付き）。
  @override
  Future<void> signInWithApple() => _guard(() async {
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
      throw const AuthFailure('Missing Apple ID token.');
    }
    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  });

  @override
  Future<void> signOut() => _guard(() => _client.auth.signOut());

  /// supabase/migrations の delete_account 関数（SECURITY DEFINER）を呼ぶ。
  @override
  Future<void> deleteAccount() => _guard(() async {
    await _client.rpc<void>('delete_account');
    await _client.auth.signOut();
  });

  AppUser? _toAppUser(User? user) => user == null
      ? null
      : AppUser(id: user.id, email: user.email, phoneNumber: user.phone);

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    }
  }
}
