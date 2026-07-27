// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileEditViewModel)
final profileEditViewModelProvider = ProfileEditViewModelProvider._();

final class ProfileEditViewModelProvider
    extends $AsyncNotifierProvider<ProfileEditViewModel, ProfileEditState> {
  ProfileEditViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileEditViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileEditViewModelHash();

  @$internal
  @override
  ProfileEditViewModel create() => ProfileEditViewModel();
}

String _$profileEditViewModelHash() =>
    r'88543ab04fb4c9e9ffcbe9e17314a9cee7be8925';

abstract class _$ProfileEditViewModel extends $AsyncNotifier<ProfileEditState> {
  FutureOr<ProfileEditState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProfileEditState>, ProfileEditState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileEditState>, ProfileEditState>,
              AsyncValue<ProfileEditState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
