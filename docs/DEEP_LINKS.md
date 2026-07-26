# ディープリンク設定手順

go_router 側は `/items/:id` のようなパスで既に対応済み（`lib/core/router/routes.dart`）。
OS からアプリを開くための設定は**ドメインとアプリ ID が決まるコピー後**に、この手順で行う。

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

3. Flutter 側: `Info.plist` に `FlutterDeepLinkingEnabled: true` を追加（go_router が URL を受け取るのに必要）

## Android (App Links)

1. `android/app/src/main/AndroidManifest.xml` の `<activity>` 内に intent-filter を追加:

```xml
<meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="example.com" />
</intent-filter>
```

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

## 動作確認コマンド

```sh
# iOS シミュレータ
xcrun simctl openurl booted "https://example.com/items/1"

# Android エミュレータ/実機
adb shell am start -a android.intent.action.VIEW \
  -d "https://example.com/items/1" <applicationId>
```

アプリが起動し、アイテム詳細画面（ID=1）が直接開けば成功。
