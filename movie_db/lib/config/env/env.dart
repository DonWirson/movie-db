import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY_MOVIE_DB')
  static const String apiKeyMovieDb = _Env.apiKeyMovieDb;
}
