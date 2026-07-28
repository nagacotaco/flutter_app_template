# core/notifications（プッシュ通知 = FCM）

firebase_messaging によるプッシュ通知。`push_notifications.dart` の `pushNotificationsEnabled` で有効/無効を切り替える（デフォルト true）。
Supabase バックエンドでも FCM を使う場合は main.dart が Firebase Core を追加初期化する。

- 起動時に通知許可をリクエストし、FCM トークンをデバッグログに出す（`FCM token: ...`）
- **トークンのバックエンド保存はアプリ固有のため未実装**（TODO コメント参照。profiles テーブル等に保存する）
- 通知タップで data ペイロードの `path`（例 `{"path": "/items/1"}`）へ遷移する。フォアグラウンド/バックグラウンド/終了状態のすべてに対応

## 動作確認

1. 実機（または iOS 16+ シミュレータ ※制約あり）でアプリを起動し、許可ダイアログを許可
2. デバッグログの `FCM token:` をコピー
3. Firebase Console > Messaging > 「最初のキャンペーンを作成」→ テストメッセージをトークン宛てに送信
4. 遷移確認は「追加のオプション」の カスタムデータ に `path` / `/items/1` を設定してタップ

## プラットフォーム別の追加設定

- **Android**: 追加設定なし（POST_NOTIFICATIONS は AndroidManifest 設定済み）
- **iOS（実機で必須）**:
  1. Apple Developer で APNs 認証キー（.p8）を作成し、Firebase Console > プロジェクト設定 > Cloud Messaging にアップロード（電話番号認証と共用。詳細手順は `lib/features/auth/README.md` の「電話番号認証の iOS 本番設定」）
  2. Capability「Push Notifications」（`ios/Runner/Runner.entitlements` の `aps-environment`）と「Background Modes > Remote notifications」（Info.plist の `UIBackgroundModes`）は設定済み。Xcode での手動追加は不要

## この機能を削除する手順

1. `lib/core/notifications/` を削除する
2. `test/core/notifications/` を削除する
3. `lib/app/app.dart` から `pushNotificationInitProvider` の watch と import を削除する
4. `lib/main.dart` から push_notifications の import、`FirebaseMessaging.onBackgroundMessage` 行、Supabase 分岐内の `pushNotificationsEnabled` ブロックを削除する
5. `android/app/src/main/AndroidManifest.xml` から `POST_NOTIFICATIONS` を削除する
6. pubspec.yaml から `firebase_messaging` を削除する
7. 再生成: `fvm dart run build_runner build --delete-conflicting-outputs`
8. `fvm flutter analyze` と `fvm flutter test` が通ることを確認する
