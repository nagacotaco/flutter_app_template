import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// サンプルのドメインモデル（見本実装用）。
@freezed
abstract class Item with _$Item {
  const factory Item({
    required String id,
    required String title,
    required String description,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
