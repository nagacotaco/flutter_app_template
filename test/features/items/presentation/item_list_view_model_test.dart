import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/domain/item.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_state.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/create_container.dart';
import '../fake_item_repository.dart';

/// ViewModel ユニットテストの見本実装（正）。
/// Repository を fake に差し替え、ProviderContainer 経由で ViewModel を検証する。
void main() {
  group('ItemListViewModel', () {
    test('build: Repository から取得したアイテムが state に入る', () async {
      final repository = FakeItemRepository();
      final container = createContainer(
        overrides: [itemRepositoryProvider.overrideWithValue(repository)],
      );
      // @riverpod は autoDispose のため、listen して provider を保持する
      container.listen(itemListViewModelProvider, (_, _) {});

      final state = await container.read(itemListViewModelProvider.future);

      expect(state.items, FakeItemRepository.defaultItems);
    });

    test('refresh: 再取得した結果で state が更新される', () async {
      final repository = FakeItemRepository();
      final container = createContainer(
        overrides: [itemRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(itemListViewModelProvider, (_, _) {});
      await container.read(itemListViewModelProvider.future);

      repository.items = const [
        Item(id: '3', title: '追加された', description: '説明3'),
      ];
      await container.read(itemListViewModelProvider.notifier).refresh();

      final state = container.read(itemListViewModelProvider);
      expect(state.value?.items, repository.items);
    });

    test('refresh: 取得に失敗したら AsyncError になる', () async {
      final repository = FakeItemRepository();
      final container = createContainer(
        overrides: [itemRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(itemListViewModelProvider, (_, _) {});
      await container.read(itemListViewModelProvider.future);

      repository.nextError = Exception('network error');
      await container.read(itemListViewModelProvider.notifier).refresh();

      final state = container.read(itemListViewModelProvider);
      expect(state, isA<AsyncError<ItemListState>>());
    });
  });
}
