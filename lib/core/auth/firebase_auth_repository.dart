import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/core/env/app_env.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// [AuthRepository] の Firebase 実装。
/// 有効化するプロバイダ（Email/Phone/Google/Apple）は Firebase Console の
/// Authentication > Sign-in method で設定する（lib/features/auth/README.md）。
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  static bool _googleInitialized = false;

  /// sendPhoneOtp と verifyPhoneOtp の間で引き回す検証 ID。
  String? _phoneVerificationId;

  @override
  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  @override
  Stream<AppUser?> authStateChanges() =>
      _auth.authStateChanges().map(_toAppUser);

  @override
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) => _guard(
    () => _auth.signInWithEmailAndPassword(email: email, password: password),
  );

  /// Firebase はサインアップと同時にサインインされる（メール確認は任意設定）。
  @override
  Future<bool> signUp({required String email, required String password}) =>
      _guard(() async {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      });

  @override
  Future<void> sendPasswordResetEmail(String email) =>
      _guard(() => _auth.sendPasswordResetEmail(email: email));

  /// SMS プロバイダ契約不要のテスト電話番号 + 固定 OTP で動作確認できる
  /// （Firebase Console > Authentication > Sign-in method > Phone）。
  @override
  Future<void> sendPhoneOtp(String phone) {
    final completer = Completer<void>();
    return _guard(() async {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          // Android の SMS 自動検証。この場合はそのままサインインまで完了する
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (!completer.isCompleted) {
            completer.completeError(AuthFailure(e.message ?? e.code));
          }
        },
        codeSent: (verificationId, _) {
          _phoneVerificationId = verificationId;
          if (!completer.isCompleted) completer.complete();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _phoneVerificationId = verificationId;
        },
      );
      await completer.future;
    });
  }

  @override
  Future<void> verifyPhoneOtp({required String phone, required String token}) =>
      _guard(() async {
        final verificationId = _phoneVerificationId;
        if (verificationId == null) {
          throw const AuthFailure('No pending phone verification.');
        }
        await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: token,
          ),
        );
        _phoneVerificationId = null;
      });

  /// Google ネイティブサインイン → ID トークンを Firebase に渡す方式。
  /// GOOGLE_WEB_CLIENT_ID（Android で必須）/ GOOGLE_IOS_CLIENT_ID を
  /// env/*.json に設定すること。
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
    await _auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: idToken),
    );
  });

  /// Apple サインイン（nonce 検証付き）。
  @override
  Future<void> signInWithApple() => _guard(() async {
    final rawNonce = _generateRawNonce();
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
    await _auth.signInWithCredential(
      OAuthProvider(
        'apple.com',
      ).credential(idToken: idToken, rawNonce: rawNonce),
    );
  });

  @override
  Future<void> signOut() => _guard(() => _auth.signOut());

  /// Firebase の仕様上、最終ログインから時間が経っていると
  /// requires-recent-login エラーになる（再ログイン後に退会し直してもらう）。
  @override
  Future<void> deleteAccount() => _guard(() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure('Not signed in.');
    }
    await user.delete();
  });

  AppUser? _toAppUser(User? user) => user == null
      ? null
      : AppUser(id: user.uid, email: user.email, phoneNumber: user.phoneNumber);

  String _generateRawNonce() {
    final random = Random.secure();
    return base64UrlEncode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? e.code);
    }
  }
}
