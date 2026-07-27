import 'package:flutter_app_template/core/auth/auth_repository.dart';
import 'package:flutter_app_template/features/settings/presentation/settings_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../helpers/create_container.dart';
import '../../auth/fake_auth_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'flutter_app_template',
      packageName: 'tech.tetrabox.flutter_app_template',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  group('SettingsViewModel', () {
    test('build: アプリバージョンが state に入る', () async {
      final container = createContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
      );
      container.listen(settingsViewModelProvider, (_, _) {});

      final state = await container.read(settingsViewModelProvider.future);

      expect(state.appVersion, '1.0.0 (1)');
    });

    test('signOut: AuthRepository の signOut を呼ぶ', () async {
      final repository = FakeAuthRepository();
      final container = createContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(settingsViewModelProvider, (_, _) {});
      await container.read(settingsViewModelProvider.future);

      await container.read(settingsViewModelProvider.notifier).signOut();

      expect(repository.calls, ['signOut']);
      expect(
        container.read(settingsViewModelProvider).value?.errorMessage,
        null,
      );
    });

    test('deleteAccount: 失敗したら errorMessage が入る', () async {
      final repository = FakeAuthRepository()
        ..nextError = const AuthFailure('delete failed');
      final container = createContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(settingsViewModelProvider, (_, _) {});
      await container.read(settingsViewModelProvider.future);

      await container.read(settingsViewModelProvider.notifier).deleteAccount();

      final state = container.read(settingsViewModelProvider).value;
      expect(state?.errorMessage, contains('delete failed'));
      expect(state?.isProcessing, false);
    });
  });
}
