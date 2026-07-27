import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/core/backend.dart';
import 'package:flutter_app_template/core/supabase/supabase_provider.dart';
import 'package:flutter_app_template/features/profile/data/firebase_profile_repository.dart';
import 'package:flutter_app_template/features/profile/data/supabase_profile_repository.dart';
import 'package:flutter_app_template/features/profile/domain/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

/// core/backend.dart の設定に応じた実装を返す。
/// 選択されなかった側の依存（Supabase クライアント等）には触れない。
@riverpod
ProfileRepository profileRepository(Ref ref) => switch (appBackend) {
  AppBackend.supabase => SupabaseProfileRepository(
    ref.watch(supabaseClientProvider),
  ),
  AppBackend.firebase => FirebaseProfileRepository(FirebaseAuth.instance),
};

/// プロフィール読み書きの抽象。Supabase / Firebase の実装を
/// core/backend.dart で切り替える。
abstract interface class ProfileRepository {
  /// アプリ内からのアバター画像アップロードに対応しているか。
  /// false の場合、編集画面はアバター変更ボタンを表示しない
  /// （Firebase は Storage が Blaze プラン必須のため未対応）。
  bool get supportsAvatarUpload;

  Future<Profile> fetchMyProfile();

  Future<void> updateDisplayName(String displayName);

  /// アバター画像をアップロードし、プロフィールに反映して URL を返す。
  /// [supportsAvatarUpload] が false の実装では [UnsupportedError] を投げる。
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String contentType,
  });
}
