import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/backend.dart';
import 'package:flutter_app_template/core/env/app_env.dart';
import 'package:flutter_app_template/core/firebase/firebase_options_dev.dart'
    as firebase_dev;
import 'package:flutter_app_template/core/firebase/firebase_options_prod.dart'
    as firebase_prod;
import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  switch (appBackend) {
    case AppBackend.supabase:
      // env/*.json 未設定（空文字）でも起動はできる。認証操作時にエラーになるだけ。
      // publishableKey には新形式（sb_publishable_...）とレガシー anon key のどちらも渡せる
      await Supabase.initialize(
        url: AppEnv.supabaseUrl,
        publishableKey: AppEnv.supabaseAnonKey,
      );
    case AppBackend.firebase:
      // flavor ごとの設定は flutterfire configure で生成した Dart オプションを使う
      // （ネイティブの google-services.json / GoogleService-Info.plist は不要）
      await Firebase.initializeApp(
        options: AppEnv.isProd
            ? firebase_prod.DefaultFirebaseOptions.currentPlatform
            : firebase_dev.DefaultFirebaseOptions.currentPlatform,
      );
  }
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const App(),
    ),
  );
}
