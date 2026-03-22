import 'package:flutter_app_template/features/home/domain/entities/sample.dart';

import '../domain/repositories/sample_repository.dart';

class SampleRepositoryImpl implements SampleRepository {
  @override
  Future<List<Sample>> fetchSamples() async {
    return [];
  }

  @override
  Future<Sample> createSample(Sample sample) {
    // TODO: implement createSample
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSample(int id) {
    // TODO: implement deleteSample
    throw UnimplementedError();
  }

  @override
  Future<Sample> fetchSampleById(int id) {
    // TODO: implement fetchSampleById
    throw UnimplementedError();
  }

  @override
  Future<Sample> updateSample(Sample sample) {
    // TODO: implement updateSample
    throw UnimplementedError();
  }
}
