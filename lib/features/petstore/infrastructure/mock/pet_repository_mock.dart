import '../../domain/entities/pet_entity.dart';
import '../../domain/repositories/pet_repository.dart';

class PetRepositoryMock implements PetRepository {
  @override
  Future<List<PetEntity>> fetchPetsByStatus(String status) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const PetEntity(
        id: 1,
        name: 'ポチ',
        photoUrls: ['https://picsum.photos/seed/dog1/400/300'],
        categoryName: '犬',
        tags: ['元気', '人懐っこい'],
        status: PetStatus.available,
      ),
      const PetEntity(
        id: 2,
        name: 'タマ',
        photoUrls: ['https://picsum.photos/seed/cat1/400/300'],
        categoryName: '猫',
        tags: ['おとなしい'],
        status: PetStatus.available,
      ),
      const PetEntity(
        id: 3,
        name: 'ピーちゃん',
        photoUrls: ['https://picsum.photos/seed/bird1/400/300'],
        categoryName: '鳥',
        tags: ['おしゃべり', 'カラフル'],
        status: PetStatus.pending,
      ),
      const PetEntity(
        id: 4,
        name: 'ハム太郎',
        photoUrls: ['https://picsum.photos/seed/hamster1/400/300'],
        categoryName: 'ハムスター',
        tags: ['小動物', 'かわいい'],
        status: PetStatus.available,
      ),
      const PetEntity(
        id: 5,
        name: 'ゴールデン',
        photoUrls: ['https://picsum.photos/seed/dog2/400/300'],
        categoryName: '犬',
        tags: ['大型犬', '訓練済み'],
        status: PetStatus.sold,
      ),
    ];
  }

  @override
  Future<PetEntity> fetchPetById(int id) async {
    final pets = await fetchPetsByStatus('available');
    return pets.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Pet not found: $id'),
    );
  }
}
