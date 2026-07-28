import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_app_template/core/backend.dart';
import 'package:flutter_app_template/core/config/app_config.dart';
import 'package:flutter_app_template/core/config/firebase_app_config_repository.dart';
import 'package:flutter_app_template/core/config/supabase_app_config_repository.dart';
import 'package:flutter_app_template/core/supabase/supabase_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config_repository.g.dart';

/// core/backend.dart の設定に応じた実装を返す。
@riverpod
AppConfigRepository appConfigRepository(Ref ref) => switch (appBackend) {
  AppBackend.supabase => SupabaseAppConfigRepository(
    ref.watch(supabaseClientProvider),
  ),
  AppBackend.firebase => FirebaseAppConfigRepository(
    FirebaseRemoteConfig.instance,
  ),
};

/// アプリ設定の取得の抽象。Supabase（app_config テーブル）/
/// Firebase（Remote Config）を core/backend.dart で切り替える。
abstract interface class AppConfigRepository {
  Future<AppConfig> fetch();
}

/// 起動時に1回取得するアプリ設定。
/// 取得失敗（オフライン等）はデフォルト値で fail-open し、起動を塞がない。
@Riverpod(keepAlive: true)
Future<AppConfig> appConfig(Ref ref) async {
  try {
    return await ref.watch(appConfigRepositoryProvider).fetch();
  } on Exception {
    return const AppConfig();
  }
}

/// 実行中アプリのビルド番号（pubspec の version の + 以降）。
@Riverpod(keepAlive: true)
Future<int> currentBuildNumber(Ref ref) async {
  final info = await PackageInfo.fromPlatform();
  return int.tryParse(info.buildNumber) ?? 0;
}
