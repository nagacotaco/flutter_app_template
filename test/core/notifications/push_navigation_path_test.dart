import 'package:flutter_app_template/core/notifications/push_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('pushNavigationPath', () {
    test('path キーが / 始まりの文字列なら返す', () {
      expect(pushNavigationPath({'path': '/items/1'}), '/items/1');
    });

    test('path キーがなければ null', () {
      expect(pushNavigationPath({'other': 'value'}), isNull);
    });

    test('/ 始まりでない・文字列でない path は null', () {
      expect(pushNavigationPath({'path': 'https://example.com'}), isNull);
      expect(pushNavigationPath({'path': 123}), isNull);
    });
  });
}
