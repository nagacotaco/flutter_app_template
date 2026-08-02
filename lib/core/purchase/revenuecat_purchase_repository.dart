import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_app_template/core/purchase/paywall_package.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// [PurchaseRepository] の RevenueCat 実装。
/// SDK の型（Package / CustomerInfo）はここで変換し、外へ漏らさない。
class RevenueCatPurchaseRepository implements PurchaseRepository {
  RevenueCatPurchaseRepository(this._apiKey);

  final String _apiKey;

  bool _configured = false;

  /// 直近 fetch した Offering のパッケージ。purchase() で id から引く。
  final Map<String, Package> _packages = {};

  final _proStatus = StreamController<bool>.broadcast();
  bool _lastProStatus = false;

  @override
  bool get isAvailable => true;

  @override
  Future<void> configure({String? appUserId}) async {
    // Riverpod の自動リトライ等で再評価されても SDK の初期化は一度だけ
    if (_configured) return;
    _configured = true;
    await Purchases.configure(
      PurchasesConfiguration(_apiKey)..appUserID = appUserId,
    );
    Purchases.addCustomerInfoUpdateListener(_onCustomerInfo);
    _onCustomerInfo(await Purchases.getCustomerInfo());
  }

  void _onCustomerInfo(CustomerInfo info) {
    _lastProStatus = info.entitlements.active.containsKey(proEntitlementId);
    _proStatus.add(_lastProStatus);
  }

  @override
  Future<void> logIn(String userId) async {
    await Purchases.logIn(userId);
  }

  @override
  Future<void> logOut() async {
    try {
      await Purchases.logOut();
    } on PlatformException {
      // 匿名ユーザーで呼ぶと logOutWithAnonymousUserError になるが、
      // 「ログアウト後は匿名」という結果は変わらないので無視する
    }
  }

  @override
  Stream<bool> proStatusChanges() async* {
    // 先に変化ストリームへ購読してから現在値を流す。
    // broadcast は購読前のイベントを捨てるため、初期値の yield 中に起きた
    // 変化を取りこぼさないよう、いったんバッファ（単一購読 controller）に受ける
    final buffer = StreamController<bool>();
    final subscription = _proStatus.stream.listen(buffer.add);
    try {
      // configure 前に購読されても false を初期発行し、provider の評価順に依存しない
      yield _lastProStatus;
      yield* buffer.stream;
    } finally {
      await subscription.cancel();
      await buffer.close();
    }
  }

  @override
  Future<List<PaywallPackage>> fetchCurrentPackages() async {
    final Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      // ダッシュボード未設定（Offering・商品がまだない）は「商品なし」として扱う
      if (PurchasesErrorHelper.getErrorCode(e) ==
          PurchasesErrorCode.configurationError) {
        return const [];
      }
      throw PurchaseFailure(e.message ?? e.code);
    }
    final packages = offerings.current?.availablePackages ?? const <Package>[];
    _packages
      ..clear()
      ..addEntries(packages.map((p) => MapEntry(p.identifier, p)));
    return packages
        .map(
          (p) => PaywallPackage(
            id: p.identifier,
            title: p.storeProduct.title,
            description: p.storeProduct.description,
            priceString: p.storeProduct.priceString,
          ),
        )
        .toList();
  }

  @override
  Future<bool> purchase(String packageId) async {
    final package = _packages[packageId];
    if (package == null) {
      throw StateError('unknown package: $packageId');
    }
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      _onCustomerInfo(result.customerInfo);
      return true;
    } on PlatformException catch (e) {
      // キャンセルは例外にしない（Google/Apple ログインのキャンセルと同じ扱い）
      if (PurchasesErrorHelper.getErrorCode(e) ==
          PurchasesErrorCode.purchaseCancelledError) {
        return false;
      }
      throw PurchaseFailure(e.message ?? e.code);
    }
  }

  @override
  Future<bool> restore() async {
    try {
      final info = await Purchases.restorePurchases();
      _onCustomerInfo(info);
      return info.entitlements.active.containsKey(proEntitlementId);
    } on PlatformException catch (e) {
      throw PurchaseFailure(e.message ?? e.code);
    }
  }
}
