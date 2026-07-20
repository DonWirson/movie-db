class TvShow {
  final int id;
  final String name;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final DateTime? firstAirDate;
  final double voteAverage;
  final double popularity;
  final String originalLanguage;
  final List<int> genreIds;

  const TvShow({
    required this.id,
    required this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.firstAirDate,
    required this.voteAverage,
    required this.popularity,
    required this.originalLanguage,
    required this.genreIds,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    final firstAirDate = json['first_air_date'] as String?;

    return TvShow(
      id: json['id'] as int,
      name: (json['name'] ?? json['original_name'] ?? '') as String,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: (firstAirDate != null && firstAirDate.isNotEmpty)
          ? DateTime.tryParse(firstAirDate)
          : null,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      originalLanguage: json['original_language'] as String? ?? '',
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.cast<int>() ?? const [],
    );
  }
}
