# アプリ内課金（RevenueCat）設定手順

テンプレート側で実装済みのもの:

- SDK ラッパと pro 状態のグローバル管理: `lib/core/purchase/`（`isProProvider` / `PurchaseRepository`）
- ペイウォール画面の雛形: `lib/features/purchase/`（`/paywall` に全画面 push。設定画面の「プランと購入」から遷移）
- 認証との同期: ログイン/ログアウトに合わせて RevenueCat のユーザー ID を自動で付け替え（Firebase / Supabase どちらでも動く）
- 無効化パターン: `env/*.json` の API キーが**空文字なら SDK を初期化せず、常に無課金として動く**（テンプレート状態のままビルド・テストが通る）

残りの設定（ストア商品・RevenueCat ダッシュボード・API キー）は
**アプリの商品構成が決まるコピー後**に、この手順で行う。

課金を使わないアプリでは、この手順の代わりに削除手順（`lib/features/purchase/README.md`）を実行する。

## 前提知識（1行ずつ）

- RevenueCat: IAP のレシート検証・購読状態管理を肩代わりする SaaS。自前のレシート検証サーバーが不要になる
- Entitlement: 「ユーザーが何を使えるか」の抽象（このテンプレートでは `pro` の1つ）。どの商品を買っても同じ Entitlement に紐付けられる
- Offering / Package: ペイウォールに出す商品の束。ダッシュボード側で差し替えられるので、アプリを再リリースせずに価格構成を変えられる
- Public API Key: アプリに埋め込む公開キー（iOS = `appl_...` / Android = `goog_...`）。秘密キーではないが、リポジトリ運用には注意（後述）
- StoreKit Configuration: iOS のローカル課金テスト機構。ストア審査・サンドボックス不要で購入フローを試せる
- サンドボックス: ストアのテスト環境。実際の課金は発生せず、購読の更新サイクルが数分〜数十分に短縮される

## 全体の流れ

```
0. ストア側の契約・口座設定（これが無いと商品が作れない/取得できない）
1. RevenueCat プロジェクト作成 + ストア連携
2. ストアでサブスク商品を作成
3. RevenueCat で Product / Entitlement / Offering を設定
4. アプリに API キーを設定
5. 動作確認（ローカル → サンドボックス）
```

## 0. ストア側の事前準備

商品作成より先にここを済ませる。**審査や反映に日数がかかるのはこの工程**。

- **iOS**: App Store Connect →「契約 / 税金 / 口座情報」で**有料 App 契約（Paid Applications）に同意**し、銀行口座・税務情報を登録する。未完了だと商品を作っても取得できない（ペイウォールが空のまま）
- **Android**: Play Console のデベロッパーアカウントに加えて**販売者（決済プロファイル）の設定**を済ませる。また商品を作るには**アプリを一度どこかのトラック（内部テストで可）にアップロード**しておく必要がある

## 1. RevenueCat プロジェクト作成

1. https://app.revenuecat.com で Project を作成し、**App Store / Play Store の App を1つずつ**追加する（Bundle ID / パッケージ名はこのアプリと一致させる）
2. ストア連携の資格情報を登録する（レシート検証に必須）
   - **iOS**: App Store Connect で In-App Purchase Key（`.p8`）を発行し、RevenueCat の App 設定にアップロード
   - **Android**: Google Cloud のサービスアカウントを作成して Play Console に招待し、認証情報 JSON を RevenueCat にアップロード
   - 手順の詳細は RevenueCat 公式ドキュメント（Service Credentials）に従う。ここが一番ハマりやすく、**反映に最大36時間かかる**とされる
3. dev / prod で購読状態を分けたい場合は **Project ごと分ける**（このテンプレートは flavor ごとに env ファイルが分かれているので、キーを差し替えるだけで対応できる）

## 2. ストアでサブスク商品を作成

- **iOS**（App Store Connect → 対象アプリ → サブスクリプション）
  1. サブスクリプショングループを作成
  2. 商品を作成。Product ID はストア間で揃えると管理が楽（例: `pro_monthly` / `pro_yearly`）
  3. 価格・ローカライズ（表示名・説明）を設定し、ステータスを「送信準備完了」まで進める
- **Android**（Play Console → 対象アプリ → 収益化 → 定期購入）
  1. 定期購入を作成（例: `pro_monthly`）し、基本プラン（自動更新）を追加して**有効化**する

## 3. RevenueCat ダッシュボード設定

1. **Products**: ストアの商品 ID を取り込む（iOS / Android 両方）
2. **Entitlements**: `pro` という ID で作成し、全 Product を紐付ける
   - ID を変える場合は `lib/core/purchase/purchase_repository.dart` の `proEntitlementId` を合わせる
3. **Offerings**: default Offering に Package（`$rc_monthly` / `$rc_annual` など）を追加し、Product を割り当てる
   - ペイウォールは **current Offering の Package 一覧**を表示する。Offering が空だと「商品を読み込めません」になる

## 4. アプリ側の設定

1. `env/dev.json` / `env/prod.json` に Public API Key を設定する

   ```json
   "REVENUECAT_API_KEY_IOS": "appl_xxxxxxxx",
   "REVENUECAT_API_KEY_ANDROID": "goog_xxxxxxxx"
   ```

   - **注意**: env ファイルは git 追跡されている。Public API Key は秘密情報ではないが、公開リポジトリで運用する場合は env を `.gitignore` に移す判断をすること
2. **iOS**: Xcode で Runner ターゲット → Signing & Capabilities →「In-App Purchase」capability を追加
3. **Android**: 追加設定は原則不要。ビルド時に minSdk エラーが出た場合のみ `android/app/build.gradle.kts` の `minSdk` を要求値に引き上げる

## 5. 動作確認

### iOS ローカル（StoreKit Configuration。最初にやる）

1. Xcode: File → New → File →「StoreKit Configuration File」を作成（「Sync this file with an app in App Store Connect」にチェックを入れるとストアの商品定義を取り込める）
2. Product → Scheme → Edit Scheme → Run → Options → StoreKit Configuration に作成したファイルを指定
3. `fvm flutter run --flavor dev --dart-define-from-file=env/dev.json` で起動 → 設定 →「プランと購入」→ 商品が表示され、購入 → pro 表示に切り替わることを確認
   - Xcode 経由の実行でないと StoreKit Configuration が効かない点に注意（`open ios/Runner.xcworkspace` から Run する）

### iOS サンドボックス

1. App Store Connect →「ユーザとアクセス」→ Sandbox テスターを作成
2. 実機の 設定 → App Store → サンドボックスアカウント にサインインしてテスト
3. 購読は短縮サイクル（1ヶ月 → 数分）で自動更新される。更新・失効の挙動もここで確認する

### Android

1. ビルドを内部テストトラックにアップロードし、テスターを登録する
2. Play Console → 設定 → ライセンステスト にテスターの Google アカウントを追加（実カードに課金されなくなる）
3. テスターとして端末にインストールし、購入 → pro 表示 → 復元を確認する

### 確認チェックリスト

- [ ] ペイウォールに商品（名前・価格）が表示される
- [ ] 購入すると pro 表示（`paywallProActive`）に切り替わる
- [ ] アプリを入れ直して「購入を復元」で pro に戻る
- [ ] ログアウト → 別アカウントでログインすると無課金に戻る（RevenueCat のユーザー切替が効いている）
- [ ] RevenueCat ダッシュボードの Customer 画面に購入が記録されている

## 有料機能のゲート方法

購読状態は `isProProvider` を watch するだけ。feature 間 import は発生しない。

```dart
final isPro = ref.watch(isProProvider);

// 無課金ならペイウォールへ誘導
if (!isPro) {
  await const PaywallRoute().push<void>(context);
  return;
}
```

## トラブルシューティング

| 症状 | 原因の候補 |
|---|---|
| ペイウォールが「商品を読み込めません」 | テンプレート状態（キー未設定）では**これが正常**。設定済みなら: 有料 App 契約が未同意 / Offering に Package が無い / 商品ステータスが未完了 / Bundle ID 不一致 / 商品作成直後の反映待ち（数時間かかることがある） |
| 購入は成功するのに pro にならない | Entitlement に Product が紐付いていない / `proEntitlementId` とダッシュボードの ID が不一致 |
| レシート検証エラー・購読状態が同期されない | ストア連携の資格情報（In-App Purchase Key / サービスアカウント JSON）が未設定か反映待ち |
| iOS 実機で商品が出ない | In-App Purchase capability 未追加 / サンドボックスアカウント未サインイン |
| Android で「アイテムは購入できません」 | 内部テストトラック未配信 / ライセンステスター未登録 / 定期購入が有効化されていない |

デバッグ時は RevenueCat のログを有効にすると原因が絞りやすい
（`revenuecat_purchase_repository.dart` の `configure` 内で一時的に `Purchases.setLogLevel(LogLevel.debug)` を呼ぶ）。
