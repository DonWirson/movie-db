part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

final class GotPopularMoviesInProgress extends MoviesState {}

final class GotPopularMoviesSuccessful extends MoviesState {
  final List<Movie> movies;

  GotPopularMoviesSuccessful({required this.movies});
}

final class GotPopularMoviesFailed extends MoviesState {
  final String message;

  GotPopularMoviesFailed(this.message);
}

final class GotMovieDetailsInProgress extends MoviesState {}

final class GotMovieDetailsSuccessful extends MoviesState {
  final MovieDetails movieDetails;

  GotMovieDetailsSuccessful({required this.movieDetails});
}

final class GotMovieDetailsFailed extends MoviesState {
  final String message;

  GotMovieDetailsFailed(this.message);
}
