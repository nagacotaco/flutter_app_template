// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeSummaryRepository)
final homeSummaryRepositoryProvider = HomeSummaryRepositoryProvider._();

final class HomeSummaryRepositoryProvider
    extends
        $FunctionalProvider<
          HomeSummaryRepository,
          HomeSummaryRepository,
          HomeSummaryRepository
        >
    with $Provider<HomeSummaryRepository> {
  HomeSummaryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeSummaryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeSummaryRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeSummaryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeSummaryRepository create(Ref ref) {
    return homeSummaryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeSummaryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeSummaryRepository>(value),
    );
  }
}

String _$homeSummaryRepositoryHash() =>
    r'311dcfb0fe3129ca6c34fedf2ed63a09db462c0d';
