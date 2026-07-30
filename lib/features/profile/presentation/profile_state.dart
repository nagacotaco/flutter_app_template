import 'package:flutter_app_template/features/profile/domain/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({required Profile profile}) = _ProfileState;

  const ProfileState._();

  /// アバター画像が未設定のときに円の中へ出す頭文字。
  /// 表示名がなければ null（AppAvatar が輪郭だけの円にフォールバックする）。
  /// サロゲートペアを壊さないよう runes から取る。
  String? get avatarInitials {
    final name = profile.displayName?.trim();
    if (name == null || name.isEmpty) return null;
    return String.fromCharCode(name.runes.first).toUpperCase();
  }
}
