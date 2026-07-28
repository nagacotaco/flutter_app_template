import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// リスト画面のローディング分岐で使う共通スケルトン（docs/ARCHITECTURE.md）。
/// ListTile 型のプレースホルダーをシマーアニメーション付きで表示する。
///
/// リスト以外のレイアウトでは、この widget ではなく実レイアウトを
/// `Skeletonizer(enabled: true, child: ...)` で包んでダミーデータを渡す。
class SkeletonListView extends StatelessWidget {
  const SkeletonListView({this.itemCount = 8, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.separated(
        // スケルトンはスクロールさせない（後ろに実データがあるわけではない）
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) => ListTile(
          title: Text(BoneMock.title),
          subtitle: Text(BoneMock.subtitle),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
