import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_summary.freezed.dart';

/// ホーム画面に出す概要。**テンプレートの雛形なので中身はダミー**。
///
/// コピー先アプリでは、この形（主数値1つ＋補助値2つ＋直近リスト）を残したまま
/// フィールド名と [HomeSummaryRepository] の実装を自分のドメインに置き換える。
/// 形を残すのは、Pure Mono のホームが「大型数値1つで画面の主張を作る」構成に
/// 依存しているため（DESIGN.md §6）。
@freezed
abstract class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    /// 主数値。画面冒頭に displayLarge で出す。
    @Default(0) int primaryCount,
    @Default(0) int weeklyDoneCount,
    @Default('') String lastSyncLabel,
    @Default([]) List<HomeRecentItem> recentItems,
  }) = _HomeSummary;

  const HomeSummary._();

  /// 出すものが何もない状態。EmptyView に切り替える判断に使う。
  bool get isEmpty => primaryCount == 0 && recentItems.isEmpty;
}

/// 直近リストの1行。
@freezed
abstract class HomeRecentItem with _$HomeRecentItem {
  const factory HomeRecentItem({
    required String title,
    required String subtitle,
  }) = _HomeRecentItem;
}
