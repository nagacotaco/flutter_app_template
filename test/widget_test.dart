import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('アプリが起動してホーム画面が表示される', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    // テスト環境のロケールは en のため、両ロケールで同一の文言で検証する
    expect(find.text('Flutter App Template'), findsOneWidget);
  });
}
