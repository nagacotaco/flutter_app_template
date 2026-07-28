import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_app_template/core/config/app_config.dart';
import 'package:flutter_app_template/core/config/app_config_repository.dart';

/// [AppConfigRepository] の Firebase 実装（Remote Config）。
/// パラメータは Firebase Console > Remote Config で
/// min_build_number / maintenance_mode / maintenance_message を作成する
/// （未作成でも下記デフォルトで動く）。
class FirebaseAppConfigRepository implements AppConfigRepository {
  FirebaseAppConfigRepository(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  @override
  Future<AppConfig> fetch() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        // メンテナンス解除を再起動で拾えるよう、キャッシュは短めにする
        minimumFetchInterval: const Duration(minutes: 5),
      ),
    );
    await _remoteConfig.setDefaults(const {
      'min_build_number': 0,
      'maintenance_mode': false,
      'maintenance_message': '',
    });
    await _remoteConfig.fetchAndActivate();
    final message = _remoteConfig.getString('maintenance_message');
    return AppConfig(
      minBuildNumber: _remoteConfig.getInt('min_build_number'),
      maintenanceMode: _remoteConfig.getBool('maintenance_mode'),
      maintenanceMessage: message.isEmpty ? null : message,
    );
  }
}
