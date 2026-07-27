import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_view_model.g.dart';

@riverpod
class SettingsViewModel extends _$SettingsViewModel {
  @override
  Future<SettingsState> build() async {
    final info = await PackageInfo.fromPlatform();
    return SettingsState(appVersion: '${info.version} (${info.buildNumber})');
  }

  /// 成功時は認証状態の変化を router の redirect が拾ってログイン画面へ遷移する。
  Future<void> signOut() => _run((repository) => repository.signOut());

  Future<void> deleteAccount() =>
      _run((repository) => repository.deleteAccount());

  Future<void> _run(Future<void> Function(AuthRepository) action) async {
    final current = state.value;
    if (current == null || current.isProcessing) return;
    state = AsyncData(current.copyWith(isProcessing: true, errorMessage: null));
    try {
      await action(ref.read(authRepositoryProvider));
      state = AsyncData(current.copyWith(isProcessing: false));
    } on Exception catch (e) {
      state = AsyncData(
        current.copyWith(isProcessing: false, errorMessage: e.toString()),
      );
    }
  }
}
