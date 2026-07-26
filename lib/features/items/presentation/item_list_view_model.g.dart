// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ItemListViewModel)
final itemListViewModelProvider = ItemListViewModelProvider._();

final class ItemListViewModelProvider
    extends $AsyncNotifierProvider<ItemListViewModel, ItemListState> {
  ItemListViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemListViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemListViewModelHash();

  @$internal
  @override
  ItemListViewModel create() => ItemListViewModel();
}

String _$itemListViewModelHash() => r'7ecd7f165d4b885c2d9e8aa465bbd74ff645694a';

abstract class _$ItemListViewModel extends $AsyncNotifier<ItemListState> {
  FutureOr<ItemListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ItemListState>, ItemListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ItemListState>, ItemListState>,
              AsyncValue<ItemListState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
