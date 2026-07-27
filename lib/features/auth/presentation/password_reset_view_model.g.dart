// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PasswordResetViewModel)
final passwordResetViewModelProvider = PasswordResetViewModelProvider._();

final class PasswordResetViewModelProvider
    extends $NotifierProvider<PasswordResetViewModel, PasswordResetState> {
  PasswordResetViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordResetViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordResetViewModelHash();

  @$internal
  @override
  PasswordResetViewModel create() => PasswordResetViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PasswordResetState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PasswordResetState>(value),
    );
  }
}

String _$passwordResetViewModelHash() =>
    r'76cdaf13149a706f9f6240844da95b1b4d3de3f1';

abstract class _$PasswordResetViewModel extends $Notifier<PasswordResetState> {
  PasswordResetState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PasswordResetState, PasswordResetState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PasswordResetState, PasswordResetState>,
              PasswordResetState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
