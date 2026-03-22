import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entities/pet_entity.dart';

/// ペットリポジトリのProvider。
/// ProviderScopeの定義でoverrideする。
final petRepositoryProvider =
    Provider.autoDispose<PetRepository>((ref) => throw UnimplementedError());

abstract interface class PetRepository {
  Future<List<PetEntity>> fetchPetsByStatus(String status);
  Future<PetEntity> fetchPetById(int id);
}
