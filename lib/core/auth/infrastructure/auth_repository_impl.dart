import 'dart:async';

import 'package:flutter_app_template/core/auth/domain/entities/user.dart';
import 'package:flutter_app_template/core/auth/domain/repositories/auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// TODO: Firebase / Supabase 等の実装に差し替える
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

/// スタブ実装。実際のプロジェクトでは Firebase/Supabase 等に置き換える。
class AuthRepositoryImpl implements AuthRepository {
  final _controller = StreamController<User?>.broadcast();
  User? _currentUser;

  @override
  Stream<User?> get authStateChanges async* {
    yield _currentUser;
    yield* _controller.stream;
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // TODO: 実際の認証処理に差し替える
    _currentUser = User(
      id: 'stub-id',
      email: email,
      name: email.split('@').first,
    );
    _controller.add(_currentUser);
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // TODO: 実際の認証処理に差し替える
    _currentUser = User(
      id: 'stub-id',
      email: email,
      name: email.split('@').first,
    );
    _controller.add(_currentUser);
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);
  }
}
