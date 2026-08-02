// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// API キーが設定されていれば RevenueCat 実装、空文字なら無効化実装を返す
/// （Sentry と同じ「空文字＝無効」パターン。テンプレート状態でも動く）。

@ProviderFor(purchaseRepository)
final purchaseRepositoryProvider = PurchaseRepositoryProvider._();

/// API キーが設定されていれば RevenueCat 実装、空文字なら無効化実装を返す
/// （Sentry と同じ「空文字＝無効」パターン。テンプレート状態でも動く）。

final class PurchaseRepositoryProvider
    extends
        $FunctionalProvider<
          PurchaseRepository,
          PurchaseRepository,
          PurchaseRepository
        >
    with $Provider<PurchaseRepository> {
  /// API キーが設定されていれば RevenueCat 実装、空文字なら無効化実装を返す
  /// （Sentry と同じ「空文字＝無効」パターン。テンプレート状態でも動く）。
  PurchaseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseRepositoryHash();

  @$internal
  @override
  $ProviderElement<PurchaseRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchaseRepository create(Ref ref) {
    return purchaseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseRepository>(value),
    );
  }
}

String _$purchaseRepositoryHash() =>
    r'16ea5ba8489382247cdae4baf788dd675fa930f0';
