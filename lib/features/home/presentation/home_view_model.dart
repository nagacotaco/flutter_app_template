import 'package:flutter_app_template/features/home/data/home_summary_repository.dart';
import 'package:flutter_app_template/features/home/presentation/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final summary = await ref
        .watch(homeSummaryRepositoryProvider)
        .fetchSummary();
    return HomeState(summary: summary);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final summary = await ref
          .read(homeSummaryRepositoryProvider)
          .fetchSummary();
      return HomeState(summary: summary);
    });
  }
}
