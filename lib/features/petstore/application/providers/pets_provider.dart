import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/pet_entity.dart';
import '../../domain/repositories/pet_repository.dart';

final petsProvider = FutureProvider.autoDispose<List<PetEntity>>((ref) async {
  return ref.read(petRepositoryProvider).fetchPetsByStatus('available');
});

final petByIdProvider =
    FutureProvider.autoDispose.family<PetEntity, int>((ref, id) async {
  final cached =
      ref.watch(petsProvider).valueOrNull?.firstWhereOrNull((p) => p.id == id);
  if (cached != null) return cached;
  return ref.read(petRepositoryProvider).fetchPetById(id);
});
