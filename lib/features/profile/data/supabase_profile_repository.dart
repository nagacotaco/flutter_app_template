import 'dart:typed_data';

import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/domain/profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [ProfileRepository] の Supabase 実装。
/// profiles テーブルと avatars Storage を使う。
/// profiles 行はサインアップ時にトリガーで自動作成される（supabase/migrations/）。
class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  @override
  bool get supportsAvatarUpload => true;

  String get _userId {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('Not signed in.');
    }
    return user.id;
  }

  @override
  Future<Profile> fetchMyProfile() async {
    final json = await _client
        .from('profiles')
        .select()
        .eq('id', _userId)
        .single();
    return Profile.fromJson(json);
  }

  @override
  Future<void> updateDisplayName(String displayName) async {
    await _client
        .from('profiles')
        .update({'display_name': displayName})
        .eq('id', _userId);
  }

  @override
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String contentType,
  }) async {
    final path = '$_userId/avatar';
    await _client.storage
        .from('avatars')
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(upsert: true, contentType: contentType),
        );
    // 同一パスへの上書きのため、キャッシュ回避にバージョンクエリを付ける
    final baseUrl = _client.storage.from('avatars').getPublicUrl(path);
    final url = '$baseUrl?v=${DateTime.now().millisecondsSinceEpoch}';
    await _client
        .from('profiles')
        .update({'avatar_url': url})
        .eq('id', _userId);
    return url;
  }
}
