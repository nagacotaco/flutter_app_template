import 'package:flutter_app_template/features/profile/domain/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({required Profile profile}) = _ProfileState;
}
