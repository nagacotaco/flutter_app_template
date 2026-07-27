import 'dart:typed_data';

import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/domain/profile.dart';

/// [ProfileRepository] のテスト用 fake。
class FakeProfileRepository implements ProfileRepository {
  FakeProfileRepository({Profile? profile})
    : profile = profile ?? const Profile(id: 'user-1', displayName: 'テスト太郎');

  Profile profile;

  @override
  bool supportsAvatarUpload = true;

  /// 次の呼び出しで投げるエラー。一度投げたら自動でクリアされる。
  Object? nextError;

  void _throwIfRequested() {
    final error = nextError;
    if (error != null) {
      nextError = null;
      throw error;
    }
  }

  @override
  Future<Profile> fetchMyProfile() async {
    _throwIfRequested();
    return profile;
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    _throwIfRequested();
    profile = profile.copyWith(displayName: displayName);
  }

  @override
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String contentType,
  }) async {
    _throwIfRequested();
    const url = 'https://example.com/avatars/user-1/avatar';
    profile = profile.copyWith(avatarUrl: url);
    return url;
  }
}
