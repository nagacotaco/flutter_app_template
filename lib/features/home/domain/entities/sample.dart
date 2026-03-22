import 'package:freezed_annotation/freezed_annotation.dart';

part 'sample.freezed.dart';
part 'sample.g.dart';

@freezed
abstract class Sample with _$Sample {
  const Sample._();
  const factory Sample({
    @Default(9999) int id,
    @Default('') String name,
    @Default('') String description,
    @Default('') String imageUrl,
    @Default('') String category,
    @Default(0) int rating,
  }) = _Sample;

  factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);
}
