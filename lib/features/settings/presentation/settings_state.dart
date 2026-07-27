import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    required String appVersion,
    @Default(false) bool isProcessing,
    String? errorMessage,
  }) = _SettingsState;
}
