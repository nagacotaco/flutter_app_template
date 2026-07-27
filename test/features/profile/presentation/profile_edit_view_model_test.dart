import 'package:flutter_app_template/features/profile/data/profile_repository.dart';
import 'package:flutter_app_template/features/profile/presentation/profile_edit_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/create_container.dart';
import '../fake_profile_repository.dart';

void main() {
  group('ProfileEditViewModel', () {
    test('saveDisplayName: 成功したら true を返し Repository が更新される', () async {
      final repository = FakeProfileRepository();
      final container = createContainer(
        overrides: [profileRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(profileEditViewModelProvider, (_, _) {});
      await container.read(profileEditViewModelProvider.future);

      final saved = await container
          .read(profileEditViewModelProvider.notifier)
          .saveDisplayName('  新しい名前  ');

      expect(saved, true);
      expect(repository.profile.displayName, '新しい名前');
    });

    test('saveDisplayName: 失敗したら false を返し errorMessage が入る', () async {
      final repository = FakeProfileRepository();
      final container = createContainer(
        overrides: [profileRepositoryProvider.overrideWithValue(repository)],
      );
      container.listen(profileEditViewModelProvider, (_, _) {});
      await container.read(profileEditViewModelProvider.future);

      repository.nextError = Exception('network error');
      final saved = await container
          .read(profileEditViewModelProvider.notifier)
          .saveDisplayName('名前');

      expect(saved, false);
      final state = container.read(profileEditViewModelProvider).value;
      expect(state?.errorMessage, isNotNull);
      expect(state?.isSaving, false);
    });
  });
}
