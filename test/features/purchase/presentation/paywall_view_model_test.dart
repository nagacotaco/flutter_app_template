import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';
import 'package:flutter_app_template/features/purchase/presentation/paywall_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';

import '../../../core/purchase/fake_purchase_repository.dart';
import '../../../helpers/create_container.dart';

void main() {
  (ProviderContainer, FakePurchaseRepository) setUpContainer({
    FakePurchaseRepository? repository,
  }) {
    final repo = repository ?? FakePurchaseRepository();
    final container = createContainer(
      overrides: <Override>[
        purchaseRepositoryProvider.overrideWithValue(repo),
        // purchaseInit が認証状態を読むため（テストでは未ログイン扱い）
        currentUserProvider.overrideWith((ref) => null),
      ],
    );
    // @riverpod は autoDispose のため、listen して provider を保持する
    container.listen(paywallViewModelProvider, (_, _) {});
    return (container, repo);
  }

  group('PaywallViewModel', () {
    test('build: パッケージ一覧が入り、先頭が初期選択される', () async {
      final (container, _) = setUpContainer();

      final state = await container.read(paywallViewModelProvider.future);

      expect(state.packages, FakePurchaseRepository.defaultPackages);
      expect(
        state.selectedPackageId,
        FakePurchaseRepository.defaultPackages.first.id,
      );
    });

    test('build: 商品未設定（テンプレート状態）なら空リスト・選択なし', () async {
      final (container, _) = setUpContainer(
        repository: FakePurchaseRepository(packages: const []),
      );

      final state = await container.read(paywallViewModelProvider.future);

      expect(state.packages, isEmpty);
      expect(state.selectedPackageId, isNull);
    });

    test('select: 選択中のパッケージが切り替わる', () async {
      final (container, _) = setUpContainer();
      await container.read(paywallViewModelProvider.future);

      final secondId = FakePurchaseRepository.defaultPackages[1].id;
      container.read(paywallViewModelProvider.notifier).select(secondId);

      expect(
        container.read(paywallViewModelProvider).value?.selectedPackageId,
        secondId,
      );
    });

    test('purchase: 選択中のパッケージで購入が実行される', () async {
      final (container, repository) = setUpContainer();
      await container.read(paywallViewModelProvider.future);

      await container.read(paywallViewModelProvider.notifier).purchase();

      expect(
        repository.log,
        contains('purchase:${FakePurchaseRepository.defaultPackages.first.id}'),
      );
      expect(
        container.read(paywallViewModelProvider).value?.errorMessage,
        isNull,
      );
    });

    test('purchase: 失敗したら errorMessage に入る（AsyncError にしない）', () async {
      final (container, repository) = setUpContainer();
      await container.read(paywallViewModelProvider.future);

      repository.nextError = const PurchaseFailure('store error');
      await container.read(paywallViewModelProvider.notifier).purchase();

      final state = container.read(paywallViewModelProvider).value;
      expect(state?.errorMessage, 'store error');
      expect(state?.isProcessing, false);
    });

    test('restore: 復元できる購入がなければ restoreNotFound になる', () async {
      final (container, repository) = setUpContainer();
      await container.read(paywallViewModelProvider.future);

      repository.restoreResult = false;
      await container.read(paywallViewModelProvider.notifier).restore();

      expect(
        container.read(paywallViewModelProvider).value?.restoreNotFound,
        true,
      );
    });

    test('restore: 復元に成功したら restoreNotFound にならない', () async {
      final (container, repository) = setUpContainer();
      await container.read(paywallViewModelProvider.future);

      repository.restoreResult = true;
      await container.read(paywallViewModelProvider.notifier).restore();

      expect(
        container.read(paywallViewModelProvider).value?.restoreNotFound,
        false,
      );
    });
  });
}
