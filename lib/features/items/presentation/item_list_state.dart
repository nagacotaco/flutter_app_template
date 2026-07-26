import 'package:flutter_app_template/features/items/domain/item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_list_state.freezed.dart';

@freezed
abstract class ItemListState with _$ItemListState {
  const factory ItemListState({
    @Default([]) List<Item> items,
  }) = _ItemListState;
}
