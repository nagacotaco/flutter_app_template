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

  /// Google ログイン用。Google Cloud Console の OAuth クライアント ID
  /// （ウェブアプリケーション）。Supabase 側にも同じ ID を設定する。
  static const String googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );

  /// Google ログイン用。OAuth クライアント ID（iOS）。
  static const String googleIosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
  );

  /// Sentry の DSN。空文字なら Sentry を初期化しない（クラッシュレポート無効）。
  static const String sentryDsn = String.fromEnvironment('SENTRY_DSN');

  static bool get isProd => flavor == 'prod';
}
