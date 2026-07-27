import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/presentation/item_detail_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/create_container.dart';
import '../fake_item_repository.dart';

/// パラメータ付き（family）ViewModel のテスト見本。
/// provider にパラメータを渡す以外は ItemListViewModel のテストと同じ形。
void main() {
  group('ItemDetailViewModel', () {
    test('build: itemId に一致するアイテムを取得する', () async {
      final repository = FakeItemRepository();
      final container = createContainer(
        overrides: [itemRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(itemDetailViewModelProvider('2'), (_, _) {});

      final state = await container.read(
        itemDetailViewModelProvider('2').future,
      );

      expect(state.item.id, '2');
      expect(state.item.title, 'テスト2');
    });

    test('build: 取得に失敗したらエラーになる', () async {
      final repository = FakeItemRepository()
        ..nextError = Exception('network error');
      final container = createContainer(
        overrides: [itemRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(itemDetailViewModelProvider('1'), (_, _) {});

      await expectLater(
        container.read(itemDetailViewModelProvider('1').future),
        throwsA(isA<Exception>()),
      );
    });
  });
}
