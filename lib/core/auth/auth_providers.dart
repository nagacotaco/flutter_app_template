import 'package:flutter_app_template/core/auth/app_user.dart';
import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

/// 認証状態の変化ストリーム。router の redirect 再評価に使う。
@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges();

/// ログイン中のユーザー。未ログインなら null。
/// グローバル状態のため core に置く（docs/ARCHITECTURE.md）。
@Riverpod(keepAlive: true)
AppUser? currentUser(Ref ref) {
  // 認証状態が変わるたびに再評価させる
  ref.watch(authStateChangesProvider);
  return ref.watch(authRepositoryProvider).currentUser;
}
