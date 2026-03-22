import 'package:freezed_annotation/freezed_annotation.dart';

part 'pet_entity.freezed.dart';

enum PetStatus { available, pending, sold }

@freezed
abstract class PetEntity with _$PetEntity {
  const factory PetEntity({
    required int id,
    required String name,
    @Default([]) List<String> photoUrls,
    String? categoryName,
    @Default([]) List<String> tags,
    @Default(PetStatus.available) PetStatus status,
  }) = _PetEntity;
}
