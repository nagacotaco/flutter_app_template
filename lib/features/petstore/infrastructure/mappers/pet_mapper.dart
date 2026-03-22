import 'package:petstore_api/petstore_api.dart';

import '../../domain/entities/pet_entity.dart';

extension PetMapper on Pet {
  PetEntity toEntity() {
    return PetEntity(
      id: id ?? 0,
      name: name,
      photoUrls: photoUrls.toList(),
      categoryName: category?.name,
      tags: tags
              ?.map((t) => t.name ?? '')
              .where((n) => n.isNotEmpty)
              .toList() ??
          [],
      status: _mapStatus(status),
    );
  }
}

PetStatus _mapStatus(PetStatusEnum? status) {
  if (status == PetStatusEnum.pending) return PetStatus.pending;
  if (status == PetStatusEnum.sold) return PetStatus.sold;
  return PetStatus.available;
}
