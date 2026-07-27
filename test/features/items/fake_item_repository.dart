import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/domain/item.dart';

/// [ItemRepository] のテスト用 fake。
/// 外部モックパッケージは使わず、手書き fake を標準パターンとする。
class FakeItemRepository implements ItemRepository {
  FakeItemRepository({List<Item>? items}) : items = items ?? defaultItems;

  static const defaultItems = [
    Item(id: '1', title: 'テスト1', description: '説明1'),
    Item(id: '2', title: 'テスト2', description: '説明2'),
  ];

  /// fetch 系が返すアイテム。テスト中に差し替えてよい。
  List<Item> items;

  /// 次の fetch 呼び出しで投げるエラー。一度投げたら自動でクリアされる。
  Object? nextError;

  @override
  Future<List<Item>> fetchItems() async {
    _throwIfRequested();
    return items;
  }

  @override
  Future<Item> fetchItem(String id) async {
    _throwIfRequested();
    return items.firstWhere((item) => item.id == id);
  }

  void _throwIfRequested() {
    final error = nextError;
    if (error != null) {
      nextError = null;
      throw error;
    }
  }
}
