import 'package:get_it/get_it.dart';
import 'package:movie_db/config/http/api_interface.dart';
import 'package:movie_db/config/http/dio_client.dart';
import 'package:movie_db/features/movies/data/movie_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio instance
  sl.registerSingleton<ApiInterface>(DioClient());

  //Services
  sl.registerFactory<MovieService>(() => MovieService(httpClient: sl()));
}
