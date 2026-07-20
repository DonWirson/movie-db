class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final DateTime? releaseDate;
  final double voteAverage;
  final double popularity;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;

  const Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.popularity,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final releaseDate = json['release_date'] as String?;

    return Movie(
      id: json['id'] as int,
      title: (json['title'] ?? json['original_title'] ?? '') as String,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: (releaseDate != null && releaseDate.isNotEmpty)
          ? DateTime.tryParse(releaseDate)
          : null,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      adult: json['adult'] as bool? ?? false,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.cast<int>() ?? const [],
    );
  }
}
