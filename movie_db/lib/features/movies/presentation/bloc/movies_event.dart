part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

final class GotPopularMovies extends MoviesEvent {}
