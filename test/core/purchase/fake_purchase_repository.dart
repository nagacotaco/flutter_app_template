import 'dart:async';

import 'package:flutter_app_template/core/purchase/paywall_package.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';

/// [PurchaseRepository] のテスト用 fake。
/// 外部モックパッケージは使わず、手書き fake を標準パターンとする。
class FakePurchaseRepository implements PurchaseRepository {
  FakePurchaseRepository({List<PaywallPackage>? packages})
    : packages = packages ?? defaultPackages;

  static const defaultPackages = [
    PaywallPackage(
      id: r'$rc_monthly',
      title: 'Pro 月額プラン',
      description: 'すべての機能が使えます',
      priceString: '¥480',
    ),
    PaywallPackage(
      id: r'$rc_annual',
      title: 'Pro 年額プラン',
      description: '月額より2ヶ月ぶんお得',
      priceString: '¥4,800',
    ),
  ];

  /// fetch 系が返すパッケージ。テスト中に差し替えてよい。
  List<PaywallPackage> packages;

  /// 次の fetch / purchase / restore 呼び出しで投げるエラー。一度投げたら自動でクリア。
  Object? nextError;

  /// purchase() の戻り値（false = ユーザーキャンセル）。
  bool purchaseResult = true;

  /// restore() の戻り値（復元後に pro が有効か）。
  bool restoreResult = false;

  /// 呼ばれた操作の記録（`configure:<uid>` / `logIn:<uid>` / `logOut` など）。
  final List<String> log = [];

  final _proStatus = StreamController<bool>.broadcast();
  bool _lastProStatus = false;

  /// テストから pro 状態の変化を流す（CustomerInfo リスナーの発火に相当）。
  void emitPro(bool value) {
    _lastProStatus = value;
    _proStatus.add(value);
  }

  @override
  bool get isAvailable => true;

  @override
  Future<void> configure({String? appUserId}) async {
    log.add('configure:$appUserId');
  }

  @override
  Future<void> logIn(String userId) async {
    log.add('logIn:$userId');
  }

  @override
  Future<void> logOut() async {
    log.add('logOut');
  }

  @override
  Stream<bool> proStatusChanges() async* {
    // 実装（revenuecat_purchase_repository.dart）と同じく、
    // 購読を先に確立してから初期値を流す（イベント取りこぼし防止）
    final buffer = StreamController<bool>();
    final subscription = _proStatus.stream.listen(buffer.add);
    try {
      yield _lastProStatus;
      yield* buffer.stream;
    } finally {
      await subscription.cancel();
      await buffer.close();
    }
  }

  @override
  Future<List<PaywallPackage>> fetchCurrentPackages() async {
    _throwIfRequested();
    return packages;
  }

  @override
  Future<bool> purchase(String packageId) async {
    _throwIfRequested();
    log.add('purchase:$packageId');
    return purchaseResult;
  }

  @override
  Future<bool> restore() async {
    _throwIfRequested();
    log.add('restore');
    return restoreResult;
  }

  void _throwIfRequested() {
    final error = nextError;
    if (error != null) {
      nextError = null;
      throw error;
    }
  }
}
