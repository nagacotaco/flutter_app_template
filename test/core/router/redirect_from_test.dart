import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sanitizeFrom', () {
    test('アプリ内パスは通す', () {
      expect(sanitizeFrom('/items/1'), '/items/1');
      expect(sanitizeFrom('/settings/profile/edit'), '/settings/profile/edit');
    });

    test('query 付きのパスも通す', () {
      expect(sanitizeFrom('/items/1?ref=push'), '/items/1?ref=push');
    });

    test('null・空文字は null', () {
      expect(sanitizeFrom(null), isNull);
      expect(sanitizeFrom(''), isNull);
    });

    test('外部 URL（open redirect）は弾く', () {
      expect(sanitizeFrom('https://evil.com/items/1'), isNull);
      expect(sanitizeFrom('http://evil.com'), isNull);
      // scheme 無しでも authority を持つ protocol-relative URL
      expect(sanitizeFrom('//evil.com/items/1'), isNull);
      expect(sanitizeFrom('myapp://items/1'), isNull);
    });

    test('先頭が / でない相対パスは弾く', () {
      expect(sanitizeFrom('items/1'), isNull);
      expect(sanitizeFrom('../items/1'), isNull);
    });

    test('認証・オンボーディング画面への復帰はループ防止で弾く', () {
      expect(sanitizeFrom('/login'), isNull);
      expect(sanitizeFrom('/login/signup'), isNull);
      expect(sanitizeFrom('/login?from=%2Fitems%2F1'), isNull);
      expect(sanitizeFrom('/onboarding'), isNull);
    });
  });
}
