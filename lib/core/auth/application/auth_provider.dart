import 'package:flutter_app_template/core/auth/domain/entities/user.dart';
import 'package:flutter_app_template/core/auth/infrastructure/auth_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 認証状態を監視するProvider（null = 未認証）
final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authRepositoryProvider).authStateChanges,
);

/// 現在ログイン中のユーザー（未認証時は null）
final currentUserProvider = Provider<User?>(
  (ref) => ref.watch(authStateProvider).valueOrNull,
);

/// 認証済みかどうか
final isAuthenticatedProvider = Provider<bool>(
  (ref) => ref.watch(currentUserProvider) != null,
);
