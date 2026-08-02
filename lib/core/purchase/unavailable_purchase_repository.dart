import 'package:flutter_app_template/core/purchase/paywall_package.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';

/// API キー未設定時（テンプレート状態）の無効化実装。
/// 何もせず、常に「無課金」として振る舞う。
class UnavailablePurchaseRepository implements PurchaseRepository {
  @override
  bool get isAvailable => false;

  @override
  Future<void> configure({String? appUserId}) async {}

  @override
  Future<void> logIn(String userId) async {}

  @override
  Future<void> logOut() async {}

  @override
  Stream<bool> proStatusChanges() => Stream.value(false);

  @override
  Future<List<PaywallPackage>> fetchCurrentPackages() async => const [];

  @override
  Future<bool> purchase(String packageId) async => false;

  @override
  Future<bool> restore() async => false;
}
