// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// core/backend.dart の設定に応じた実装を返す。

@ProviderFor(appConfigRepository)
final appConfigRepositoryProvider = AppConfigRepositoryProvider._();

/// core/backend.dart の設定に応じた実装を返す。

final class AppConfigRepositoryProvider
    extends
        $FunctionalProvider<
          AppConfigRepository,
          AppConfigRepository,
          AppConfigRepository
        >
    with $Provider<AppConfigRepository> {
  /// core/backend.dart の設定に応じた実装を返す。
  AppConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppConfigRepository create(Ref ref) {
    return appConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfigRepository>(value),
    );
  }
}

String _$appConfigRepositoryHash() =>
    r'bc4c2222bfdeaa48f476f1de2baa3d7ea3ee16a6';

/// 起動時に1回取得するアプリ設定。
/// 取得失敗（オフライン等）はデフォルト値で fail-open し、起動を塞がない。

@ProviderFor(appConfig)
final appConfigProvider = AppConfigProvider._();

/// 起動時に1回取得するアプリ設定。
/// 取得失敗（オフライン等）はデフォルト値で fail-open し、起動を塞がない。

final class AppConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<AppConfig>,
          AppConfig,
          FutureOr<AppConfig>
        >
    with $FutureModifier<AppConfig>, $FutureProvider<AppConfig> {
  /// 起動時に1回取得するアプリ設定。
  /// 取得失敗（オフライン等）はデフォルト値で fail-open し、起動を塞がない。
  AppConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigHash();

  @$internal
  @override
  $FutureProviderElement<AppConfig> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppConfig> create(Ref ref) {
    return appConfig(ref);
  }
}

String _$appConfigHash() => r'a0d8bf9c0669538a5929cae39a6051331448a610';

/// 実行中アプリのビルド番号（pubspec の version の + 以降）。

@ProviderFor(currentBuildNumber)
final currentBuildNumberProvider = CurrentBuildNumberProvider._();

/// 実行中アプリのビルド番号（pubspec の version の + 以降）。

final class CurrentBuildNumberProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// 実行中アプリのビルド番号（pubspec の version の + 以降）。
  CurrentBuildNumberProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentBuildNumberProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentBuildNumberHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return currentBuildNumber(ref);
  }
}

String _$currentBuildNumberHash() =>
    r'93ed4d635c9b465142bd46905fbaad45916a5eaf';
