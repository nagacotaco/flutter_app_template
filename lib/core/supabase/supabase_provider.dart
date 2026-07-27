import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_provider.g.dart';

/// Supabase クライアント。直接 `Supabase.instance` を参照せず、
/// 必ずこの provider 経由で取得する（テストで差し替え可能にするため）。
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;
