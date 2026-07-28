import 'package:flutter_app_template/core/settings/app_settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_providers.g.dart';

/// オンボーディング完了フラグ（shared_preferences 永続化）。
/// router の redirect が参照し、未完了なら /onboarding へ誘導する。
@Riverpod(keepAlive: true)
class OnboardingCompleted extends _$OnboardingCompleted {
  static const String _key = 'onboarding.completed';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> complete() async {
    state = true;
    await ref.read(sharedPreferencesProvider).setBool(_key, true);
  }
}
