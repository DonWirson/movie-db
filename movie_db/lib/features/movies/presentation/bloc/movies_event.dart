part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

final class GotPopularMovies extends MoviesEvent {}

final class GotMovieDetails extends MoviesEvent {
  final int movieId;

  GotMovieDetails({required this.movieId});
}

final class GotSearchedMovies extends MoviesEvent {
  final String query;

  GotSearchedMovies({required this.query});
}
