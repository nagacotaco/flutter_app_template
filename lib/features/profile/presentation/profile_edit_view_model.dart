import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_edit_state.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_edit_view_model.g.dart';

@riverpod
class ProfileEditViewModel extends _$ProfileEditViewModel {
  @override
  Future<ProfileEditState> build() async {
    final profile = await ref.watch(profileRepositoryProvider).fetchMyProfile();
    return ProfileEditState(profile: profile);
  }

  /// 保存に成功したら true を返す（Screen 側で画面を閉じる判断に使う）。
  Future<bool> saveDisplayName(String displayName) async {
    final current = state.value;
    if (current == null || current.isSaving) return false;
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      await ref
          .read(profileRepositoryProvider)
          .updateDisplayName(displayName.trim());
      // プロフィール表示画面に反映させる
      ref.invalidate(profileViewModelProvider);
      state = AsyncData(current.copyWith(isSaving: false));
      return true;
    } on Exception catch (e) {
      state = AsyncData(
        current.copyWith(isSaving: false, errorMessage: e.toString()),
      );
      return false;
    }
  }

  /// ギャラリーから画像を選んでアップロードする。選択キャンセル時は何もしない。
  Future<void> pickAndUploadAvatar() async {
    final current = state.value;
    if (current == null || current.isSaving) return;
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (file == null) return;
    state = AsyncData(current.copyWith(isSaving: true, errorMessage: null));
    try {
      final bytes = await file.readAsBytes();
      final url = await ref
          .read(profileRepositoryProvider)
          .uploadAvatar(
            bytes: bytes,
            contentType: file.mimeType ?? 'image/jpeg',
          );
      ref.invalidate(profileViewModelProvider);
      state = AsyncData(
        current.copyWith(
          isSaving: false,
          profile: current.profile.copyWith(avatarUrl: url),
        ),
      );
    } on Exception catch (e) {
      state = AsyncData(
        current.copyWith(isSaving: false, errorMessage: e.toString()),
      );
    }
  }
}
