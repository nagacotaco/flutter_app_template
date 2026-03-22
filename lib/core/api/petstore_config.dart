// Openapi Generator last run: : 2026-03-23T07:36:00.318061
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'petstore_api',
    pubAuthor: 'flutter_app_template',
  ),
  inputSpec: RemoteSpec(
    path: 'https://petstore3.swagger.io/api/v3/openapi.json',
  ),
  generatorName: Generator.dio,
  outputDirectory: 'api/petstore',
  runSourceGenOnOutput: true,
)
class PetstoreConfig {}