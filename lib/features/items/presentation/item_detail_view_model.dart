import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_detail_view_model.g.dart';

/// パラメータ付き ViewModel の見本。`build` の引数が provider の family パラメータになる。
@riverpod
class ItemDetailViewModel extends _$ItemDetailViewModel {
  @override
  Future<ItemDetailState> build(String itemId) async {
    final item = await ref.watch(itemRepositoryProvider).fetchItem(itemId);
    return ItemDetailState(item: item);
  }
}
