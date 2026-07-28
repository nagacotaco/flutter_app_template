import 'package:flutter_app_template/core/config/app_config.dart';
import 'package:flutter_app_template/core/config/app_config_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [AppConfigRepository] の Supabase 実装。
/// app_config テーブルの1行を読む（supabase/migrations/ 参照）。
class SupabaseAppConfigRepository implements AppConfigRepository {
  SupabaseAppConfigRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<AppConfig> fetch() async {
    final json = await _client.from('app_config').select().single();
    return AppConfig.fromJson(json);
  }
}
