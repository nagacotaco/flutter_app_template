// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 課金 SDK の初期化 + 認証ユーザーとの紐付け同期。
/// App から watch され、起動時に1回実行される（API キー未設定なら何もしない）。
///
/// auth 側はこの provider の存在を知らない（core→core の片方向依存）。
/// バックエンドが Supabase でも [currentUserProvider] は AuthRepository 抽象
/// 経由なので、ユーザー ID の同期はそのまま動く。

@ProviderFor(purchaseInit)
final purchaseInitProvider = PurchaseInitProvider._();

/// 課金 SDK の初期化 + 認証ユーザーとの紐付け同期。
/// App から watch され、起動時に1回実行される（API キー未設定なら何もしない）。
///
/// auth 側はこの provider の存在を知らない（core→core の片方向依存）。
/// バックエンドが Supabase でも [currentUserProvider] は AuthRepository 抽象
/// 経由なので、ユーザー ID の同期はそのまま動く。

final class PurchaseInitProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// 課金 SDK の初期化 + 認証ユーザーとの紐付け同期。
  /// App から watch され、起動時に1回実行される（API キー未設定なら何もしない）。
  ///
  /// auth 側はこの provider の存在を知らない（core→core の片方向依存）。
  /// バックエンドが Supabase でも [currentUserProvider] は AuthRepository 抽象
  /// 経由なので、ユーザー ID の同期はそのまま動く。
  PurchaseInitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseInitProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseInitHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return purchaseInit(ref);
  }
}

String _$purchaseInitHash() => r'b25dc91829ec51aa3aa4093a5232c82959871799';

/// pro entitlement の有効状態ストリーム。

@ProviderFor(proStatusChanges)
final proStatusChangesProvider = ProStatusChangesProvider._();

/// pro entitlement の有効状態ストリーム。

final class ProStatusChangesProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  /// pro entitlement の有効状態ストリーム。
  ProStatusChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proStatusChangesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proStatusChangesHash();

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    return proStatusChanges(ref);
  }
}

String _$proStatusChangesHash() => r'87bf50e319cfa1b2615e69b24e9ed494a9770cd2';

/// pro entitlement が有効か。API キー未設定・取得前は常に false。
/// 有料機能のゲートは `ref.watch(isProProvider)` で行う。

@ProviderFor(isPro)
final isProProvider = IsProProvider._();

/// pro entitlement が有効か。API キー未設定・取得前は常に false。
/// 有料機能のゲートは `ref.watch(isProProvider)` で行う。

final class IsProProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// pro entitlement が有効か。API キー未設定・取得前は常に false。
  /// 有料機能のゲートは `ref.watch(isProProvider)` で行う。
  IsProProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isProProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isProHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isPro(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isProHash() => r'44f2feffe92ceec066d0a23f87919d3a8ef7f2b2';
