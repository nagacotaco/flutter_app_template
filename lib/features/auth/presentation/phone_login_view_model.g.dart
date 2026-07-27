// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_login_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 電話番号ログイン（2ステップ: 番号入力 → OTP 入力）。

@ProviderFor(PhoneLoginViewModel)
final phoneLoginViewModelProvider = PhoneLoginViewModelProvider._();

/// 電話番号ログイン（2ステップ: 番号入力 → OTP 入力）。
final class PhoneLoginViewModelProvider
    extends $NotifierProvider<PhoneLoginViewModel, PhoneLoginState> {
  /// 電話番号ログイン（2ステップ: 番号入力 → OTP 入力）。
  PhoneLoginViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneLoginViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneLoginViewModelHash();

  @$internal
  @override
  PhoneLoginViewModel create() => PhoneLoginViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneLoginState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneLoginState>(value),
    );
  }
}

String _$phoneLoginViewModelHash() =>
    r'36cc332f52897c219fd9c03ad9cfeed089f6cdf8';

/// 電話番号ログイン（2ステップ: 番号入力 → OTP 入力）。

abstract class _$PhoneLoginViewModel extends $Notifier<PhoneLoginState> {
  PhoneLoginState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PhoneLoginState, PhoneLoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhoneLoginState, PhoneLoginState>,
              PhoneLoginState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
