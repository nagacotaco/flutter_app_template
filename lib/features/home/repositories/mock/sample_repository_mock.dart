import 'package:flutter_app_template/features/home/domain/entities/sample.dart';

import '../../domain/repositories/sample_repository.dart';

class SampleRepositoryMock implements SampleRepository {
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
  Future<Sample> fetchSampleById(int id) async {
    final samples = await fetchSamples();
    return samples.firstWhere(
      (s) => s.id == id,
      orElse: () => throw Exception('Sample not found: $id'),
    );
  }

  @override
  Future<List<Sample>> fetchSamples() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Sample(
        id: 1,
        name: 'Flutter入門',
        description: 'Flutterの基本的な使い方を学ぶサンプルです。',
        imageUrl: 'https://example.com/sample1.jpg',
        category: 'チュートリアル',
        rating: 5,
      ),
      Sample(
        id: 2,
        name: 'Riverpod状態管理',
        description: 'Riverpodを使った状態管理のベストプラクティス。',
        imageUrl: 'https://example.com/sample2.jpg',
        category: '状態管理',
        rating: 4,
      ),
      Sample(
        id: 3,
        name: 'GoRouterナビゲーション',
        description: 'GoRouterを使ったページ遷移の実装例。',
        imageUrl: 'https://example.com/sample3.jpg',
        category: 'ナビゲーション',
        rating: 4,
      ),
      Sample(
        id: 4,
        name: 'Freezedデータクラス',
        description: 'Freezedを使った不変データクラスの定義方法。',
        imageUrl: 'https://example.com/sample4.jpg',
        category: 'データモデル',
        rating: 5,
      ),
      Sample(
        id: 5,
        name: 'クリーンアーキテクチャ',
        description: 'Flutterでクリーンアーキテクチャを実践する方法。',
        imageUrl: 'https://example.com/sample5.jpg',
        category: 'アーキテクチャ',
        rating: 3,
      ),
    ];
  }

  @override
  Future<Sample> updateSample(Sample sample) {
    // TODO: implement updateSample
    throw UnimplementedError();
  }
}
