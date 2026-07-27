// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 認証状態の変化ストリーム。router の redirect 再評価に使う。

@ProviderFor(authStateChanges)
final authStateChangesProvider = AuthStateChangesProvider._();

/// 認証状態の変化ストリーム。router の redirect 再評価に使う。

final class AuthStateChangesProvider
    extends
        $FunctionalProvider<AsyncValue<AppUser?>, AppUser?, Stream<AppUser?>>
    with $FutureModifier<AppUser?>, $StreamProvider<AppUser?> {
  /// 認証状態の変化ストリーム。router の redirect 再評価に使う。
  AuthStateChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateChangesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateChangesHash();

  @$internal
  @override
  $StreamProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AppUser?> create(Ref ref) {
    return authStateChanges(ref);
  }
}

String _$authStateChangesHash() => r'995fef4731106f818c965a60e5d33d573d5a83d7';

/// ログイン中のユーザー。未ログインなら null。
/// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// ログイン中のユーザー。未ログインなら null。
/// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。

final class CurrentUserProvider
    extends $FunctionalProvider<AppUser?, AppUser?, AppUser?>
    with $Provider<AppUser?> {
  /// ログイン中のユーザー。未ログインなら null。
  /// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppUser? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser?>(value),
    );
  }
}

String _$currentUserHash() => r'056c6c13d2c56e41378f6a43f65ab250207875af';
