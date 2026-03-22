import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/sample.dart';

part 'home_page_state.freezed.dart';

@freezed
abstract class HomePageState with _$HomePageState {
  const HomePageState._();
  const factory HomePageState({
    @Default(false) bool isLoading,
    Object? error,
    required AsyncValue<List<Sample>> samplesAsync,
  }) = _HomePageState;
}
