class TmdbConfig {
  TmdbConfig._();

  static const String baseUrl = 'https://api.themoviedb.org/3';

  /// Token de lectura (v4) de TMDB. Se inyecta en tiempo de build/run:
  /// flutter run --dart-define=TMDB_ACCESS_TOKEN=tu_token
  static const String accessToken = String.fromEnvironment(
    'TMDB_ACCESS_TOKEN',
  );
}
