# ディープリンク設定手順

テンプレート側で設定済みのもの:

- go_router のパス対応: `/items/:id` のようなパスで直接開ける（`lib/core/router/routes.dart`）
- OS 側フラグ: iOS `FlutterDeepLinkingEnabled`（`ios/Runner/Info.plist`）/ Android `flutter_deeplinking_enabled`（`AndroidManifest.xml`）
- 開発用カスタムスキーム（iOS）: **Bundle ID がそのままスキーム**になる
  （`Info.plist` の `CFBundleURLSchemes` に `$(PRODUCT_BUNDLE_IDENTIFIER)` を登録済み。
  flavor 別に自動で変わり、リネームにも追従する）。後述「開発時の動作確認」参照
- 未ログイン時の復帰: 後述「未ログイン時の挙動」参照

残りの設定（Associated Domains / intent-filter / `.well-known` の2ファイル）は
**ドメインとアプリ ID が決まるコピー後**に、この手順で行う。

## 前提知識（1行ずつ）

- ディープリンク: URL からアプリの特定画面を直接開く仕組み
- Universal Links (iOS) / App Links (Android): `https://example.com/items/1` のような **https URL** でアプリを開く方式。ドメインの所有証明が必要
- カスタムスキーム: `myapp://items/1` のような独自スキーム方式。設定は簡単だが、未インストール時のフォールバックがなく、iOS では他アプリに乗っ取られる可能性があるため本番は https 方式を推奨

## iOS (Universal Links)

1. Xcode: Runner → Signing & Capabilities → 「Associated Domains」を追加し `applinks:example.com` を登録
2. サーバー: `https://example.com/.well-known/apple-app-site-association` (AASA) を配信（Content-Type: application/json、拡張子なし）

```json
{
  "applinks": {
    "details": [
      {
        "appIDs": ["<TeamID>.<BundleID>"],
        "components": [{ "/": "/items/*" }]
      }
    ]
  }
}
```

Flutter 側の `FlutterDeepLinkingEnabled: true`（go_router が URL を受け取るのに必要）は**テンプレートで設定済み**。

## Android (App Links)

1. `android/app/src/main/AndroidManifest.xml` の `<activity>` 内に intent-filter を追加:

```xml
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="example.com" />
</intent-filter>
```

`flutter_deeplinking_enabled` の meta-data は**テンプレートで設定済み**。

2. サーバー: `https://example.com/.well-known/assetlinks.json` を配信:

```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "<applicationId>",
      "sha256_cert_fingerprints": ["<署名証明書の SHA-256>"]
    }
  }
]
```

SHA-256 は `./gradlew signingReport` または Play Console の「アプリの完全性」で取得。

## 開発時の動作確認（ドメイン不要・テンプレート状態で動く）

Universal Links / App Links の設定前でも、次の方法で任意のパスを開ける。
確認済みの実例はギャラリー画面（`lib/features/gallery/README.md`）。

```sh
# iOS シミュレータ: スキーム = iOS の Bundle ID（flavor 別）
# 「"アプリ名" で開きますか?」の確認ダイアログで「開く」をタップする
xcrun simctl openurl booted "tech.tetrabox.flutterAppTemplate.dev:///items/1"

# Android エミュレータ/実機: コンポーネント直指定なら intent-filter 不要
adb shell am start \
  -n tech.tetrabox.flutter_app_template.dev/tech.tetrabox.flutter_app_template.MainActivity \
  -a android.intent.action.VIEW -d "app:///items/1"
```

- IMPORTANT: パスは `scheme://items/1` ではなく **`scheme:///items/1`**（スラッシュ3本）。
  `//` の直後は host として解釈され、go_router にパスが渡らない
- リネーム後はスキーム（= Bundle ID）と `-n` のコンポーネント名を読み替える

## 本番設定後の動作確認コマンド

```sh
# iOS シミュレータ
xcrun simctl openurl booted "https://example.com/items/1"

# Android エミュレータ/実機
adb shell am start -a android.intent.action.VIEW \
  -d "https://example.com/items/1" <applicationId>
```

アプリが起動し、アイテム詳細画面（ID=1）が直接開けば成功。

## 未ログイン時の挙動（実装済み）

未ログイン（またはオンボーディング未完了）でディープリンクを開くと、
`lib/core/router/app_router.dart` の redirect が元のパスを `?from=` に退避して
`/onboarding?from=...` → `/login?from=...` と引き継ぎ、認証完了後に自動で元の画面へ復帰する。

- 対応経路: メール・電話 OTP・Google / Apple・サインアップ（認証状態の変化で redirect が再評価されるため全経路共通）
- `from` はアプリ内パスのみ許可。外部 URL（open redirect）や `/login` 系・`/onboarding` への復帰（ループ）は破棄してホームに着地する（`sanitizeFrom`）
- テスト: `test/auth_redirect_test.dart` / `test/core/router/redirect_from_test.dart`
