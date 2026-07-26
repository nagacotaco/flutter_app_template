import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_list_view_model.g.dart';

@riverpod
class ItemListViewModel extends _$ItemListViewModel {
  @override
  Future<ItemListState> build() async {
    final items = await ref.watch(itemRepositoryProvider).fetchItems();
    return ItemListState(items: items);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final items = await ref.read(itemRepositoryProvider).fetchItems();
      return ItemListState(items: items);
    });
  }
}
