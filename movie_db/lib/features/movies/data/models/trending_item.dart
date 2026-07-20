enum MediaType { movie, tv, person }

MediaType _mediaTypeFromString(String? value) {
  switch (value) {
    case 'tv':
      return MediaType.tv;
    case 'person':
      return MediaType.person;
    case 'movie':
    default:
      return MediaType.movie;
  }
}

/// Representa un elemento del endpoint combinado `/trending/all`, que puede
/// ser una película o una serie (los resultados de tipo `person` se
/// descartan al mapear la respuesta, ver [PaginatedResponse]).
class TrendingItem {
  final int id;
  final MediaType mediaType;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final DateTime? releaseDate;
  final double voteAverage;
  final double popularity;

  const TrendingItem({
    required this.id,
    required this.mediaType,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.popularity,
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) {
    final mediaType = _mediaTypeFromString(json['media_type'] as String?);
    final dateString = mediaType == MediaType.tv
        ? json['first_air_date'] as String?
        : json['release_date'] as String?;

    return TrendingItem(
      id: json['id'] as int,
      mediaType: mediaType,
      title: (json['title'] ?? json['name'] ?? '') as String,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: (dateString != null && dateString.isNotEmpty)
          ? DateTime.tryParse(dateString)
          : null,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
    );
  }
}
