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
        $FunctionalProvider<AsyncValue<AuthState>, AuthState, Stream<AuthState>>
    with $FutureModifier<AuthState>, $StreamProvider<AuthState> {
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
  $StreamProviderElement<AuthState> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<AuthState> create(Ref ref) {
    return authStateChanges(ref);
  }
}

String _$authStateChangesHash() => r'310af7ac668b2f2faabbc6d8fc00b2b768260eed';

/// ログイン中のユーザー。未ログインなら null。
/// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// ログイン中のユーザー。未ログインなら null。
/// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。

final class CurrentUserProvider extends $FunctionalProvider<User?, User?, User?>
    with $Provider<User?> {
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
  $ProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  User? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User?>(value),
    );
  }
}

String _$currentUserHash() => r'18cf8d7a817a4acbffe7f9b1c912490aee4f8e93';
