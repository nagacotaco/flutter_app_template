import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entities/sample.dart';

/// サンプルリポジトリのProvider。
///　　ProviderScopeの定義でoverrideする。
final sampleRepositoryProvider =
    Provider.autoDispose<SampleRepository>((ref) => throw UnimplementedError());

abstract interface class SampleRepository {
  Future<List<Sample>> fetchSamples();
  Future<Sample> fetchSampleById(int id);
  Future<Sample> createSample(Sample sample);
  Future<Sample> updateSample(Sample sample);
  Future<void> deleteSample(int id);
}
