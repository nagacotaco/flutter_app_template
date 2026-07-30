import 'package:flutter_app_template/features/home/data/home_summary_repository.dart';
import 'package:flutter_app_template/features/home/domain/home_summary.dart';

/// [HomeSummaryRepository] のテスト用 fake。
/// 外部モックパッケージは使わず、手書き fake を標準パターンとする。
class FakeHomeSummaryRepository implements HomeSummaryRepository {
  FakeHomeSummaryRepository({HomeSummary? summary})
    : summary = summary ?? defaultSummary;

  static const defaultSummary = HomeSummary(
    primaryCount: 3,
    weeklyDoneCount: 12,
    lastSyncLabel: '2h',
    recentItems: [HomeRecentItem(title: 'テスト1', subtitle: '説明1')],
  );

  /// fetch が返す概要。テスト中に差し替えてよい。
  HomeSummary summary;

  /// 次の fetch 呼び出しで投げるエラー。一度投げたら自動でクリアされる。
  Object? nextError;

  @override
  Future<HomeSummary> fetchSummary() async {
    final error = nextError;
    if (error != null) {
      nextError = null;
      throw error;
    }
    return summary;
  }
}
