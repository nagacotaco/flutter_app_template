import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/backend.dart';
import 'package:flutter_app_template/core/env/app_env.dart';
import 'package:flutter_app_template/core/firebase/firebase_options_dev.dart'
    as firebase_dev;
import 'package:flutter_app_template/core/firebase/firebase_options_prod.dart'
    as firebase_prod;
import 'package:flutter_app_template/core/notifications/push_notifications.dart';
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // SENTRY_DSN 未設定（空文字）なら Sentry を使わずそのまま起動する
  if (AppEnv.sentryDsn.isEmpty) {
    runApp(await _bootstrap());
    return;
  }
  await SentryFlutter.init((options) {
    options
      ..dsn = AppEnv.sentryDsn
      ..environment = AppEnv.flavor;
  }, appRunner: () async => runApp(await _bootstrap()));
}

Future<Widget> _bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  switch (appBackend) {
    case AppBackend.supabase:
      // env/*.json 未設定（空文字）でも起動はできる。認証操作時にエラーになるだけ。
      // publishableKey には新形式（sb_publishable_...）とレガシー anon key のどちらも渡せる
      await Supabase.initialize(
        url: AppEnv.supabaseUrl,
        publishableKey: AppEnv.supabaseAnonKey,
      );
      // Supabase バックエンドでもプッシュ通知（FCM）には Firebase Core が必要
      if (pushNotificationsEnabled) {
        await _initializeFirebase();
      }
    case AppBackend.firebase:
      await _initializeFirebase();
  }
  if (pushNotificationsEnabled) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  final prefs = await SharedPreferences.getInstance();
  return ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const App(),
  );
}

/// flavor ごとの設定は flutterfire configure で生成した Dart オプションを使う
/// （ネイティブの google-services.json / GoogleService-Info.plist は不要）。
Future<void> _initializeFirebase() => Firebase.initializeApp(
  options: AppEnv.isProd
      ? firebase_prod.DefaultFirebaseOptions.currentPlatform
      : firebase_dev.DefaultFirebaseOptions.currentPlatform,
);
