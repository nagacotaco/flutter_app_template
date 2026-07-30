import 'package:flutter_app_template/features/home/domain/home_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({required HomeSummary summary}) = _HomeState;
}
