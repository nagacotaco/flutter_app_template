import 'dart:async';

import 'package:flutter_app_template/core/auth/auth_providers.dart';
import 'package:flutter_app_template/core/purchase/purchase_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase_providers.g.dart';

/// 課金 SDK の初期化 + 認証ユーザーとの紐付け同期。
/// App から watch され、起動時に1回実行される（API キー未設定なら何もしない）。
///
/// auth 側はこの provider の存在を知らない（core→core の片方向依存）。
/// バックエンドが Supabase でも [currentUserProvider] は AuthRepository 抽象
/// 経由なので、ユーザー ID の同期はそのまま動く。
@Riverpod(keepAlive: true)
Future<void> purchaseInit(Ref ref) async {
  final repository = ref.watch(purchaseRepositoryProvider);
  if (!repository.isAvailable) return;
  await repository.configure(appUserId: ref.read(currentUserProvider)?.id);
  // ログイン/ログアウトに合わせて課金 SDK 側のユーザー ID を付け替える
  ref.listen(currentUserProvider, (previous, next) {
    if (next != null) {
      unawaited(repository.logIn(next.id));
    } else if (previous != null) {
      unawaited(repository.logOut());
    }
  });
}

/// pro entitlement の有効状態ストリーム。
@Riverpod(keepAlive: true)
Stream<bool> proStatusChanges(Ref ref) async* {
  // 初期化（configure）の完了を待ってから購読する
  await ref.watch(purchaseInitProvider.future);
  yield* ref.watch(purchaseRepositoryProvider).proStatusChanges();
}

/// pro entitlement が有効か。API キー未設定・取得前は常に false。
/// 有料機能のゲートは `ref.watch(isProProvider)` で行う。
@Riverpod(keepAlive: true)
bool isPro(Ref ref) => ref.watch(proStatusChangesProvider).value ?? false;
