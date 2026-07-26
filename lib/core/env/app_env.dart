/// ビルド時に `--dart-define-from-file=env/<flavor>.json` で注入される環境値。
/// 実行例: `fvm flutter run --flavor dev --dart-define-from-file=env/dev.json`
abstract final class AppEnv {
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
  );

  static bool get isProd => flavor == 'prod';
}
