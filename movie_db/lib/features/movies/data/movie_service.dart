import 'package:movie_db/config/http/api_interface.dart';
import 'package:movie_db/features/movies/data/models/movie.dart';
import 'package:movie_db/features/movies/data/models/paginated_response.dart';
import 'package:movie_db/features/movies/data/models/trending_item.dart';
import 'package:movie_db/features/movies/data/models/tv_show.dart';

/// Ventana de tiempo que usa TMDB para calcular las tendencias:
/// `day` = populares hoy, `week` = populares esta semana.
enum TrendingTimeWindow { day, week }

class MovieService {
  final ApiInterface apiClient;

  MovieService({required this.apiClient});

  /// Películas más populares en este momento.
  Future<PaginatedResponse<Movie>> getTrendingMovies({
    TrendingTimeWindow timeWindow = TrendingTimeWindow.day,
  }) async {
    final response = await apiClient.get<Map<String, dynamic>>(
      '/trending/movie/${timeWindow.name}',
    );
    return PaginatedResponse.fromJson(response.data!, Movie.fromJson);
  }

  /// Series más populares en este momento.
  Future<PaginatedResponse<TvShow>> getTrendingTvShows({
    TrendingTimeWindow timeWindow = TrendingTimeWindow.day,
  }) async {
    final response = await apiClient.get<Map<String, dynamic>>(
      '/trending/tv/${timeWindow.name}',
    );
    return PaginatedResponse.fromJson(response.data!, TvShow.fromJson);
  }

  /// Películas y series más populares en este momento, combinadas en un
  /// mismo listado (se excluyen los resultados de tipo persona).
  Future<PaginatedResponse<TrendingItem>> getTrendingAll({
    TrendingTimeWindow timeWindow = TrendingTimeWindow.day,
  }) async {
    final response = await apiClient.get<Map<String, dynamic>>(
      '/trending/all/${timeWindow.name}',
    );
    final parsed = PaginatedResponse.fromJson(
      response.data!,
      TrendingItem.fromJson,
    );

    return PaginatedResponse(
      page: parsed.page,
      totalPages: parsed.totalPages,
      totalResults: parsed.totalResults,
      results: parsed.results
          .where((item) => item.mediaType != MediaType.person)
          .toList(),
    );
  }
}
