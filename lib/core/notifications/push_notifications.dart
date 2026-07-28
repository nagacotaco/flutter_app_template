import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/core/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notifications.g.dart';

/// プッシュ通知（FCM）を使うかどうか。使わないアプリでは false にする
/// （丸ごと削除する手順は lib/core/notifications/README.md）。
/// Supabase バックエンドでも FCM を使う場合は true のままにする
/// （main.dart が Firebase Core を追加で初期化する）。
const bool pushNotificationsEnabled = true;

/// バックグラウンド/終了状態で FCM メッセージを受けたときのハンドラ。
/// notification ペイロード付きメッセージは OS が自動表示するため、
/// ここではデータメッセージの独自処理が必要な場合のみ実装する。
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

/// プッシュ通知の初期化。App から watch され、起動時に1回実行される。
/// - 通知許可のリクエスト（タイミングを変えたいアプリはここから移す）
/// - FCM トークンの取得（バックエンドへの保存はアプリ固有のため TODO）
/// - 通知タップ時に data の `path` へ遷移するリスナー登録
@Riverpod(keepAlive: true)
Future<void> pushNotificationInit(Ref ref) async {
  // Firebase 未初期化（テスト実行時や設定前）は何もしない
  if (!pushNotificationsEnabled || Firebase.apps.isEmpty) return;
  final messaging = FirebaseMessaging.instance;

  // iOS: フォアグラウンド受信時もシステム通知を表示する
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await messaging.requestPermission();

  try {
    final token = await messaging.getToken();
    // Firebase Console からのテスト送信に使う（README 参照）
    debugPrint('FCM token: $token');
    // TODO(template): 通知をユーザーに紐付けるアプリでは、ここで token を
    // バックエンド（profiles テーブル等）に保存し、onTokenRefresh でも更新する
  } on Exception catch (e) {
    // iOS シミュレータ等、APNs トークンが取れない環境では失敗してよい
    debugPrint('FCM getToken failed: $e');
  }

  // 終了状態から通知タップで起動したケース
  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    _navigateFromMessage(ref, initialMessage);
  }
  // バックグラウンドから通知タップで復帰したケース
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) => _navigateFromMessage(ref, message),
  );
}

void _navigateFromMessage(Ref ref, RemoteMessage message) {
  final path = pushNavigationPath(message.data);
  if (path != null) {
    ref.read(routerProvider).go(path);
  }
}

/// 通知の data ペイロードから遷移先パスを取り出す（例: {"path": "/items/1"}）。
/// `/` 始まりの文字列でなければ null（遷移しない）。
@visibleForTesting
String? pushNavigationPath(Map<String, dynamic> data) {
  final path = data['path'];
  if (path is! String || !path.startsWith('/')) return null;
  return path;
}
