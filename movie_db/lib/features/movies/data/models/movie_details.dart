import 'package:movie_db/features/movies/data/models/genre.dart';

class MovieDetails {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final DateTime? releaseDate;
  final double voteAverage;
  final int runtime;
  final List<Genre> genres;

  const MovieDetails({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.runtime,
    required this.genres,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    final releaseDate = json['release_date'] as String?;

    return MovieDetails(
      id: json['id'] as int,
      title: (json['title'] ?? json['original_title'] ?? '') as String,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: (releaseDate != null && releaseDate.isNotEmpty)
          ? DateTime.tryParse(releaseDate)
          : null,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((g) => Genre.fromJson(g as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}
