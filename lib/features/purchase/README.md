# purchase

アプリ内課金（RevenueCat / サブスクリプション）の薄い下地。
ペイウォール画面の雛形だけがこの feature にあり、SDK ラッパと pro 状態の
グローバル管理は `lib/core/purchase/` にある（他 feature が `isPro` で
機能をゲートするときに feature 間 import を作らないため）。

- `presentation/` — ペイウォール画面（`/paywall` に全画面 push）の Screen / ViewModel / State
- `lib/core/purchase/` — Repository 抽象 + RevenueCat 実装 + `isProProvider`
- テンプレート状態（API キー空文字）では SDK を初期化せず、常に無課金として動く

**このテンプレートに含めていないもの**（アプリ固有なので各アプリで書く）:
訴求文・特典リストの UI、複数プラン比較、A/B テスト、サーバーサイドのレシート検証、
消耗型アイテム。

## コピー先アプリで課金を有効にする手順

**`docs/IN_APP_PURCHASE.md` が正**。ストア側の契約 → RevenueCat 設定 → API キー →
動作確認（StoreKit Configuration / サンドボックス）→ トラブルシューティングまで
一通り書いてある。要点だけ:

1. `env/*.json` に Public API Key（`REVENUECAT_API_KEY_IOS/_ANDROID`）を設定する
2. Entitlement は `pro` 固定（変える場合は `lib/core/purchase/purchase_repository.dart`
   の `proEntitlementId` を合わせる）
3. ペイウォールの訴求文・特典リストを `presentation/paywall_screen.dart` に作り込み、
   有料機能を `ref.watch(isProProvider)` でゲートする

## この機能を削除する手順

1. `lib/features/purchase/` と `lib/core/purchase/` を削除する
2. `test/core/purchase/` と `test/features/purchase/` を削除する
3. `lib/core/router/routes.dart` から `paywall_screen.dart` の import と
   `PaywallRoute` クラス（`@TypedGoRoute` ごと）を削除する
4. `lib/app/app.dart` から `purchase_providers.dart` の import と
   `ref.watch(purchaseInitProvider);` の行を削除する
5. `lib/features/settings/presentation/settings_screen.dart` から
   `settingsPurchases` の `_LinkRow`（直後の `SizedBox` ごと）を削除する
6. `lib/core/l10n/arb/app_ja.arb` / `app_en.arb` から `paywall` で始まるキーと
   `settingsPurchases`（ja は `@...` も）を削除する
7. `test/design_layout_test.dart` の `screens` から `'paywall'` の行と、
   `purchaseRepositoryProvider` の override・import を削除する
8. `pubspec.yaml` から `purchases_flutter` を削除する
9. 再生成する: `fvm dart run build_runner build --delete-conflicting-outputs` と `fvm flutter gen-l10n`
10. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
