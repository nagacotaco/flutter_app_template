import 'package:flutter_app_template/features/items/domain/item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_detail_state.freezed.dart';

@freezed
abstract class ItemDetailState with _$ItemDetailState {
  const factory ItemDetailState({
    required Item item,
  }) = _ItemDetailState;
}
