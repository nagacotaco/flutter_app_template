import 'package:flutter_app_template/core/supabase/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_providers.g.dart';

/// 認証状態の変化ストリーム。router の redirect 再評価に使う。
@Riverpod(keepAlive: true)
Stream<AuthState> authStateChanges(Ref ref) =>
    ref.watch(supabaseClientProvider).auth.onAuthStateChange;

/// ログイン中のユーザー。未ログインなら null。
/// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。
@Riverpod(keepAlive: true)
User? currentUser(Ref ref) {
  // 認証状態が変わるたびに再評価させる
  ref.watch(authStateChangesProvider);
  return ref.watch(supabaseClientProvider).auth.currentUser;
}
