import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/sample.dart';
import '../../domain/repositories/sample_repository.dart';

final samplesProvider = FutureProvider.autoDispose<List<Sample>>((ref) async {
  return ref.read(sampleRepositoryProvider).fetchSamples();
});

final sampleProvider =
    FutureProvider.autoDispose.family<Sample, int>((ref, id) async {
  // まずリスト取得済みのキャッシュを探す
  final cached =
      ref.watch(samplesProvider).valueOrNull?.firstWhereOrNull((s) => s.id == id);
  if (cached != null) return cached;
  return ref.read(sampleRepositoryProvider).fetchSampleById(id);
});
