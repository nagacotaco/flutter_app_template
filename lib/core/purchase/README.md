# core/purchase

アプリ内課金（RevenueCat）の共通層。SDK のラップと pro 状態のグローバル管理を担う。

- 有料機能のゲート: `ref.watch(isProProvider)`（`purchase_providers.dart`）
- API キーは `env/*.json` の `REVENUECAT_API_KEY_IOS` / `REVENUECAT_API_KEY_ANDROID`。
  **空文字なら SDK を初期化せず、常に無課金として動く**（テンプレート状態）
- Entitlement ID は `purchase_repository.dart` の `proEntitlementId`（既定 `pro`）

セットアップ手順・削除手順は `lib/features/purchase/README.md` を参照。
