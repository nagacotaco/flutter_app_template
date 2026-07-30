import 'package:flutter_app_template/features/home/domain/home_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_summary_repository.g.dart';

@riverpod
HomeSummaryRepository homeSummaryRepository(Ref ref) => HomeSummaryRepository();

/// ホームの概要を返す Repository。**中身は固定のダミー値**。
///
/// ホームは「コピー先アプリが最初に作り替える画面」なので、テンプレート側では
/// レイアウトの雛形だけを提供し、実データは持たない。
/// ここを自分の API / DB 呼び出しに置き換えれば、画面側は触らずに動く。
///
/// 他 feature（items 等）を参照していないのは意図的。feature をまたぐ import は
/// 禁止で、`features/items/` を削除してもホームが壊れないようにするため
/// （docs/ARCHITECTURE.md §7）。
class HomeSummaryRepository {
  Future<HomeSummary> fetchSummary() async {
    // 通信を模した遅延
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const HomeSummary(
      primaryCount: 3,
      weeklyDoneCount: 12,
      lastSyncLabel: '2h',
      recentItems: [
        HomeRecentItem(title: 'サンプルアイテム 1', subtitle: 'ここに直近の更新内容が入ります'),
        HomeRecentItem(title: 'サンプルアイテム 2', subtitle: 'ここに直近の更新内容が入ります'),
        HomeRecentItem(title: 'サンプルアイテム 3', subtitle: 'ここに直近の更新内容が入ります'),
      ],
    );
  }
}
