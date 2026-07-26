import 'package:flutter_app_template/features/items/domain/item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_repository.g.dart';

@riverpod
ItemRepository itemRepository(Ref ref) => ItemRepository();

/// サンプルのインメモリ Repository（見本実装用）。
/// 実アプリではここを Supabase 呼び出しに置き換える。
class ItemRepository {
  static final List<Item> _items = List.generate(
    20,
    (index) => Item(
      id: '${index + 1}',
      title: 'サンプルアイテム ${index + 1}',
      description: 'ID ${index + 1} のサンプルアイテムの説明文です。',
    ),
  );

  Future<List<Item>> fetchItems() async {
    // 通信を模した遅延
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _items;
  }

  Future<Item> fetchItem(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _items.firstWhere((item) => item.id == id);
  }
}
