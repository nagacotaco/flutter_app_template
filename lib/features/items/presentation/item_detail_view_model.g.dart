// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。

@ProviderFor(ItemDetailViewModel)
final itemDetailViewModelProvider = ItemDetailViewModelFamily._();

/// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。
final class ItemDetailViewModelProvider
    extends $AsyncNotifierProvider<ItemDetailViewModel, ItemDetailState> {
  /// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。
  ItemDetailViewModelProvider._({
    required ItemDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'itemDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$itemDetailViewModelHash();

  @override
  String toString() {
    return r'itemDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ItemDetailViewModel create() => ItemDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is ItemDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$itemDetailViewModelHash() =>
    r'4d4f4150cb2b4a19dc7dc01990feac90a3aea27b';

/// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。

final class ItemDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ItemDetailViewModel,
          AsyncValue<ItemDetailState>,
          ItemDetailState,
          FutureOr<ItemDetailState>,
          String
        > {
  ItemDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'itemDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。

  ItemDetailViewModelProvider call(String itemId) =>
      ItemDetailViewModelProvider._(argument: itemId, from: this);

  @override
  String toString() => r'itemDetailViewModelProvider';
}

/// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。

abstract class _$ItemDetailViewModel extends $AsyncNotifier<ItemDetailState> {
  late final _$args = ref.$arg as String;
  String get itemId => _$args;

  FutureOr<ItemDetailState> build(String itemId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ItemDetailState>, ItemDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ItemDetailState>, ItemDetailState>,
              AsyncValue<ItemDetailState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
