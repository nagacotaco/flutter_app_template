import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/domain/profile.dart';

/// [ProfileRepository] の Firebase 実装。
/// Firestore は使わず、Firebase Auth のユーザープロフィール
/// （displayName / photoURL）に保存する。
/// photoURL は Google / Apple ログイン時に各サービスの画像が自動設定される。
class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository(this._auth);

  final FirebaseAuth _auth;

  /// Firebase Storage が Blaze プラン必須のため、アップロードは未対応。
  /// 対応する場合は Blaze 化のうえ firebase_storage を追加してここに実装する。
  @override
  bool get supportsAvatarUpload => false;

  User get _user {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure('Not signed in.');
    }
    return user;
  }

  @override
  Future<Profile> fetchMyProfile() async {
    final user = _user;
    return Profile(
      id: user.uid,
      displayName: user.displayName,
      avatarUrl: user.photoURL,
    );
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    try {
      await _user.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? e.code);
    }
  }

  @override
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String contentType,
  }) async {
    throw UnsupportedError(
      'Avatar upload is not supported on the Firebase backend.',
    );
  }
}
