import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// Riverpod 3 では Override 型は misc.dart からエクスポートされる
import 'package:hooks_riverpod/misc.dart';

/// ViewModel ユニットテスト用の [ProviderContainer] を作る。
/// テスト終了時に自動で dispose される。
ProviderContainer createContainer({List<Override> overrides = const []}) {
  final container = ProviderContainer(
    overrides: overrides,
    // Riverpod 3 は build 失敗時にデフォルトで自動リトライするため、
    // テストでは無効化して失敗をそのまま検証できるようにする
    retry: (retryCount, error) => null,
  );
  addTearDown(container.dispose);
  return container;
}
