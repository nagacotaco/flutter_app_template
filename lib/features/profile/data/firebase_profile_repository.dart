import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/domain/profile.dart';

/// [ProfileRepository] の Firebase 実装。
/// Firestore は使わず、Firebase Auth のユーザープロフィール
/// （displayName / photoURL）に保存する。
/// アバター画像は Firebase Storage の `avatars/{uid}/avatar` に保存する
/// （Storage の有効化には Blaze プランが必要。手順は features/profile/README.md）。
class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository(this._auth, this._storage);

  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  @override
  bool get supportsAvatarUpload => true;

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
    final user = _user;
    final ref = _storage.ref('avatars/${user.uid}/avatar');
    await ref.putData(bytes, SettableMetadata(contentType: contentType));
    // 同一パスへの上書きのため、キャッシュ回避にバージョンクエリを付ける
    final baseUrl = await ref.getDownloadURL();
    final separator = baseUrl.contains('?') ? '&' : '?';
    final url = '$baseUrl${separator}v=${DateTime.now().millisecondsSinceEpoch}';
    try {
      await user.updatePhotoURL(url);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? e.code);
    }
    return url;
  }
}
