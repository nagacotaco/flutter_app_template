import 'dart:async';

import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/core/purchase/purchase_providers.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';
import 'package:flutter_app_template/core/purchase/unavailable_purchase_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../features/auth/fake_auth_repository.dart';
import '../../helpers/create_container.dart';
import 'fake_purchase_repository.dart';

/// マイクロタスク・stream イベントの伝播を待つ。
Future<void> pumpEventQueue2() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

void main() {
  group('isProProvider', () {
    test('キー未設定（Unavailable 実装）なら常に false', () async {
      final container = createContainer(
        overrides: [
          purchaseRepositoryProvider.overrideWithValue(
            UnavailablePurchaseRepository(),
          ),
        ],
      );
      container.listen(isProProvider, (_, _) {});

      await container.read(proStatusChangesProvider.future);

      expect(container.read(isProProvider), false);
    });

    test('pro 状態の変化（CustomerInfo リスナー相当）が isPro に反映される', () async {
      final repository = FakePurchaseRepository();
      final container = createContainer(
        overrides: [
          purchaseRepositoryProvider.overrideWithValue(repository),
          currentUserProvider.overrideWith((ref) => null),
        ],
      );
      container.listen(isProProvider, (_, _) {});

      await container.read(proStatusChangesProvider.future);
      expect(container.read(isProProvider), false);

      repository.emitPro(true);
      await pumpEventQueue2();

      expect(container.read(isProProvider), true);
    });
  });

  group('purchaseInitProvider', () {
    test('起動時に configure し、ログイン/ログアウトでユーザー紐付けを同期する', () async {
      final purchaseRepository = FakePurchaseRepository();
      final authRepository = FakeAuthRepository();
      final authState = StreamController<AppUser?>();
      addTearDown(authState.close);
      final container = createContainer(
        overrides: [
          purchaseRepositoryProvider.overrideWithValue(purchaseRepository),
          authRepositoryProvider.overrideWithValue(authRepository),
          authStateChangesProvider.overrideWith((ref) => authState.stream),
        ],
      );

      await container.read(purchaseInitProvider.future);
      expect(purchaseRepository.log, ['configure:null']);

      // ログイン → SDK 側にもユーザー ID を紐付ける
      const user = AppUser(id: 'u1', email: 'taro@example.com');
      authRepository.currentUser = user;
      authState.add(user);
      await pumpEventQueue2();
      expect(purchaseRepository.log, contains('logIn:u1'));

      // ログアウト → 匿名に戻す
      authRepository.currentUser = null;
      authState.add(null);
      await pumpEventQueue2();
      expect(purchaseRepository.log, contains('logOut'));
    });
  });
}
