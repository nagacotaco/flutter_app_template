import 'package:flutter_app_template/features/profile/domain/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_edit_state.freezed.dart';

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    required Profile profile,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _ProfileEditState;
}
