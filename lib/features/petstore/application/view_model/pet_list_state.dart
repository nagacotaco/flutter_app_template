import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/pet_entity.dart';

part 'pet_list_state.freezed.dart';

@freezed
abstract class PetListState with _$PetListState {
  const factory PetListState({
    @Default(false) bool isLoading,
    Object? error,
    required AsyncValue<List<PetEntity>> petsAsync,
  }) = _PetListState;
}
