import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:petstore_api/petstore_api.dart';

final petApiProvider = Provider<PetApi>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://petstore3.swagger.io/api/v3'),
  );
  return PetApi(dio, standardSerializers);
});
