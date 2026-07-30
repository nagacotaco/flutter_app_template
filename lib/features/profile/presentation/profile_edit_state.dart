import 'package:flutter_app_template/features/profile/domain/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_edit_state.freezed.dart';

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    required Profile profile,

    /// アバター変更ボタンを表示するか（ProfileRepository.supportsAvatarUpload）。
    @Default(true) bool canChangeAvatar,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _ProfileEditState;

  const ProfileEditState._();

  /// アバター画像が未設定のときに円の中へ出す頭文字（ProfileState と同じ規則）。
  String? get avatarInitials {
    final name = profile.displayName?.trim();
    if (name == null || name.isEmpty) return null;
    return String.fromCharCode(name.runes.first).toUpperCase();
  }
}
