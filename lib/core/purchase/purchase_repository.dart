import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/core/env/app_env.dart';
import 'package:flutter_app_template/core/purchase/paywall_package.dart';
import 'package:flutter_app_template/core/purchase/revenuecat_purchase_repository.dart';
import 'package:flutter_app_template/core/purchase/unavailable_purchase_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase_repository.g.dart';

/// 有料機能を解放する RevenueCat の Entitlement ID。
/// コピー先アプリでダッシュボードに作成した ID と一致させること
/// （lib/features/purchase/README.md）。
const String proEntitlementId = 'pro';

/// API キーが設定されていれば RevenueCat 実装、空文字なら無効化実装を返す
/// （Sentry と同じ「空文字＝無効」パターン。テンプレート状態でも動く）。
@Riverpod(keepAlive: true)
PurchaseRepository purchaseRepository(Ref ref) {
  final apiKey = defaultTargetPlatform == TargetPlatform.iOS
      ? AppEnv.revenueCatApiKeyIos
      : AppEnv.revenueCatApiKeyAndroid;
  return apiKey.isEmpty
      ? UnavailablePurchaseRepository()
      : RevenueCatPurchaseRepository(apiKey);
}

/// 課金エラーの共通例外。SDK 固有の例外は実装がこれに変換する。
/// [message] はそのまま画面のエラー表示に使われる。
class PurchaseFailure implements Exception {
  const PurchaseFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

/// 課金操作の抽象。isPro を複数 feature から使うため core に置く
/// （docs/ARCHITECTURE.md: 複数 feature から使う Repository は core）。
abstract interface class PurchaseRepository {
  /// API キーが設定されているか。false なら全操作が no-op / 空になる。
  bool get isAvailable;

  /// SDK を初期化する。起動時に purchase_providers.dart から一度だけ呼ばれる。
  Future<void> configure({String? appUserId});

  /// ログイン中ユーザーの ID を課金 SDK に紐付ける。
  Future<void> logIn(String userId);

  /// 紐付けを解除して匿名ユーザーに戻す。
  Future<void> logOut();

  /// [proEntitlementId] の有効状態ストリーム。configure 前・課金無効時は false。
  Stream<bool> proStatusChanges();

  /// 現在の Offering のパッケージ一覧。
  /// Offering や商品が未設定（テンプレート状態）なら空リスト（例外にしない）。
  /// 通信失敗などは [PurchaseFailure] を投げる。
  Future<List<PaywallPackage>> fetchCurrentPackages();

  /// 戻り値は購入が完了したか。ユーザーキャンセルは false（例外を投げない）。
  Future<bool> purchase(String packageId);

  /// 過去の購入を復元する。戻り値は復元後に pro entitlement が有効か
  /// （false なら「復元できる購入がなかった」）。[proStatusChanges] にも反映される。
  Future<bool> restore();
}
