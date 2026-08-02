// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PaywallViewModel)
final paywallViewModelProvider = PaywallViewModelProvider._();

final class PaywallViewModelProvider
    extends $AsyncNotifierProvider<PaywallViewModel, PaywallState> {
  PaywallViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paywallViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paywallViewModelHash();

  @$internal
  @override
  PaywallViewModel create() => PaywallViewModel();
}

String _$paywallViewModelHash() => r'6feb91108f6c53aee4db215b5dbe48ef2185703f';

abstract class _$PaywallViewModel extends $AsyncNotifier<PaywallState> {
  FutureOr<PaywallState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PaywallState>, PaywallState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PaywallState>, PaywallState>,
              AsyncValue<PaywallState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
