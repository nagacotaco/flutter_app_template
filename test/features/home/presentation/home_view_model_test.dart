import 'package:flutter_app_template/features/home/data/home_summary_repository.dart';
import 'package:flutter_app_template/features/home/domain/home_summary.dart';
import 'package:flutter_app_template/features/home/presentation/home_state.dart';
import 'package:flutter_app_template/features/home/presentation/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helpers/create_container.dart';
import '../fake_home_summary_repository.dart';

void main() {
  group('HomeViewModel', () {
    test('build: Repository から取得した概要が state に入る', () async {
      final repository = FakeHomeSummaryRepository();
      final container = createContainer(
        overrides: [
          homeSummaryRepositoryProvider.overrideWithValue(repository),
        ],
      );
      container.listen(homeViewModelProvider, (_, _) {});

      final state = await container.read(homeViewModelProvider.future);

      expect(state.summary, FakeHomeSummaryRepository.defaultSummary);
    });

    test('build: 主数値も直近リストも空なら isEmpty が true になる', () async {
      final repository = FakeHomeSummaryRepository(
        summary: const HomeSummary(),
      );
      final container = createContainer(
        overrides: [
          homeSummaryRepositoryProvider.overrideWithValue(repository),
        ],
      );
      container.listen(homeViewModelProvider, (_, _) {});

      final state = await container.read(homeViewModelProvider.future);

      expect(state.summary.isEmpty, isTrue);
    });

    test('refresh: 取得に失敗したら AsyncError になる', () async {
      final repository = FakeHomeSummaryRepository();
      final container = createContainer(
        overrides: [
          homeSummaryRepositoryProvider.overrideWithValue(repository),
        ],
      );
      container.listen(homeViewModelProvider, (_, _) {});
      await container.read(homeViewModelProvider.future);

      repository.nextError = Exception('network error');
      await container.read(homeViewModelProvider.notifier).refresh();

      final state = container.read(homeViewModelProvider);
      expect(state, isA<AsyncError<HomeState>>());
    });
  });
}
