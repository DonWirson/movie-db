import 'package:get_it/get_it.dart';
import 'package:movie_db/config/http/api_interface.dart';
import 'package:movie_db/config/http/dio_client.dart';
import 'package:movie_db/config/http/tmdb_config.dart';
import 'package:movie_db/features/movies/data/movie_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio instance
  final apiClient = DioClient();
  if (TmdbConfig.accessToken.isNotEmpty) {
    apiClient.setToken(TmdbConfig.accessToken);
  }
  sl.registerSingleton<ApiInterface>(apiClient);

  //Services
  sl.registerFactory<MovieService>(() => MovieService(apiClient: sl()));
}
