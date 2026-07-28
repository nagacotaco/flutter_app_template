import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

/// サーバー側から配信するアプリ全体の設定（強制アップデート / メンテナンスモード）。
/// デフォルト値は「制限なし」。取得失敗時もこのデフォルトで fail-open する。
@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    /// このビルド番号未満のアプリは強制アップデート画面を表示する。
    @JsonKey(name: 'min_build_number') @Default(0) int minBuildNumber,
    @JsonKey(name: 'maintenance_mode') @Default(false) bool maintenanceMode,

    /// メンテナンス画面に表示する文言。null なら l10n のデフォルト文言。
    @JsonKey(name: 'maintenance_message') String? maintenanceMessage,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
