import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_db/features/movies/data/models/movie.dart';
import 'package:movie_db/features/movies/data/models/movie_details.dart';
import 'package:movie_db/features/movies/data/movie_service.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  static const int topMoviesLimit = 10;

  final MovieService movieService;

  MoviesBloc({required this.movieService}) : super(MoviesInitial()) {
    on<GotPopularMovies>(_onGotPopularMovies);
    on<GotMovieDetails>(_onGotMovieDetails);
  }

  Future<void> _onGotPopularMovies(
    GotPopularMovies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(GotPopularMoviesInProgress());
    try {
      final response = await movieService.getTrendingMovies();
      emit(
        GotPopularMoviesSuccessful(
          movies: response.results.take(topMoviesLimit).toList(),
        ),
      );
    } catch (_) {
      emit(GotPopularMoviesFailed('No se pudieron cargar las películas populares.'));
    }
  }

  Future<void> _onGotMovieDetails(
    GotMovieDetails event,
    Emitter<MoviesState> emit,
  ) async {
    emit(GotMovieDetailsInProgress());
    try {
      final movieDetails = await movieService.getMovieDetails(event.movieId);
      emit(GotMovieDetailsSuccessful(movieDetails: movieDetails));
    } catch (_) {
      emit(
        GotMovieDetailsFailed('No se pudieron cargar los detalles de la película.'),
      );
    }
  }
}
