import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/l10n/l10n.dart';
import 'package:flutter_app_template/core/widgets/empty_view.dart';
import 'package:flutter_app_template/core/widgets/skeleton_list_view.dart';
import 'package:flutter_app_template/features/items/data/item_repository.dart';
import 'package:flutter_app_template/features/items/presentation/item_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../fake_item_repository.dart';

Widget buildScreen(FakeItemRepository repository) {
  return ProviderScope(
    overrides: [itemRepositoryProvider.overrideWithValue(repository)],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ItemListScreen(),
    ),
  );
}

void main() {
  testWidgets('ローディング中はスケルトンを表示する', (tester) async {
    await tester.pumpWidget(buildScreen(FakeItemRepository()));

    // 初回フレームは AsyncLoading
    expect(find.byType(SkeletonListView), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(SkeletonListView), findsNothing);
    expect(find.text('テスト1'), findsOneWidget);
  });

  testWidgets('アイテムが空なら EmptyView を表示する', (tester) async {
    await tester.pumpWidget(buildScreen(FakeItemRepository(items: [])));
    await tester.pumpAndSettle();

    expect(find.byType(EmptyView), findsOneWidget);
    expect(find.text('No items yet'), findsOneWidget);
  });
}
