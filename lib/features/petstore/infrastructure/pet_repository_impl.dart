import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:petstore_api/petstore_api.dart';

import '../domain/entities/pet_entity.dart';
import '../domain/repositories/pet_repository.dart';
import 'datasources/petstore_api_client.dart';
import 'mappers/pet_mapper.dart';

class PetRepositoryImpl implements PetRepository {
  PetRepositoryImpl(this._petApi);

  final PetApi _petApi;

  @override
  Future<List<PetEntity>> fetchPetsByStatus(String status) async {
    final response = await _petApi.findPetsByStatus(status: status);
    return response.data?.map((p) => p.toEntity()).toList() ?? [];
  }

  @override
  Future<PetEntity> fetchPetById(int id) async {
    final response = await _petApi.getPetById(petId: id);
    final pet = response.data;
    if (pet == null) throw Exception('Pet not found: $id');
    return pet.toEntity();
  }
}

final petRepositoryImplProvider = Provider<PetRepository>((ref) {
  return PetRepositoryImpl(ref.watch(petApiProvider));
});
