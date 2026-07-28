// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// オンボーディング完了フラグ（shared_preferences 永続化）。
/// router の redirect が参照し、未完了なら /onboarding へ誘導する。

@ProviderFor(OnboardingCompleted)
final onboardingCompletedProvider = OnboardingCompletedProvider._();

/// オンボーディング完了フラグ（shared_preferences 永続化）。
/// router の redirect が参照し、未完了なら /onboarding へ誘導する。
final class OnboardingCompletedProvider
    extends $NotifierProvider<OnboardingCompleted, bool> {
  /// オンボーディング完了フラグ（shared_preferences 永続化）。
  /// router の redirect が参照し、未完了なら /onboarding へ誘導する。
  OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  OnboardingCompleted create() => OnboardingCompleted();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingCompletedHash() =>
    r'7826085ddcdbd06fa70936f5a064815b0bb77e3a';

/// オンボーディング完了フラグ（shared_preferences 永続化）。
/// router の redirect が参照し、未完了なら /onboarding へ誘導する。

abstract class _$OnboardingCompleted extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
