import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_db/features/movies/data/models/movie.dart';
import 'package:movie_db/features/movies/data/models/movie_details.dart';
import 'package:movie_db/features/movies/data/models/paginated_response.dart';
import 'package:movie_db/features/movies/data/movie_service.dart';
import 'package:movie_db/features/movies/presentation/bloc/movies_bloc.dart';

class MockMovieService extends Mock implements MovieService {}

Movie _buildMovie(int id) => Movie(
  id: id,
  title: 'Movie $id',
  overview: 'Overview $id',
  posterPath: '/poster$id.jpg',
  backdropPath: '/backdrop$id.jpg',
  releaseDate: DateTime(2024, 1, id),
  voteAverage: 7.5,
  popularity: 100,
  adult: false,
  originalLanguage: 'en',
  genreIds: const [1, 2],
);

const _movieDetails = MovieDetails(
  id: 1,
  title: 'Movie 1',
  overview: 'Overview 1',
  posterPath: '/poster1.jpg',
  backdropPath: '/backdrop1.jpg',
  releaseDate: null,
  voteAverage: 7.5,
  runtime: 120,
  genres: [],
);

void main() {
  late MockMovieService movieService;
  late MoviesBloc moviesBloc;

  setUp(() {
    movieService = MockMovieService();
    moviesBloc = MoviesBloc(movieService: movieService);
  });

  tearDown(() {
    moviesBloc.close();
  });

  test('el estado inicial es MoviesInitial', () {
    expect(moviesBloc.state, isA<MoviesInitial>());
  });

  group('GotPopularMovies', () {
    blocTest<MoviesBloc, MoviesState>(
      'emite [InProgress, Successful] cuando movieService responde exitosamente',
      build: () {
        when(() => movieService.getTrendingMovies()).thenAnswer(
          (_) async => PaginatedResponse(
            page: 1,
            results: List.generate(3, _buildMovie),
            totalPages: 1,
            totalResults: 3,
          ),
        );
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotPopularMovies()),
      expect: () => [
        isA<GotPopularMoviesInProgress>(),
        isA<GotPopularMoviesSuccessful>().having(
          (state) => state.movies.length,
          'movies.length',
          3,
        ),
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'limita el resultado a topMoviesLimit películas',
      build: () {
        when(() => movieService.getTrendingMovies()).thenAnswer(
          (_) async => PaginatedResponse(
            page: 1,
            results: List.generate(20, _buildMovie),
            totalPages: 1,
            totalResults: 20,
          ),
        );
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotPopularMovies()),
      expect: () => [
        isA<GotPopularMoviesInProgress>(),
        isA<GotPopularMoviesSuccessful>().having(
          (state) => state.movies.length,
          'movies.length',
          MoviesBloc.topMoviesLimit,
        ),
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emite [InProgress, Failed] cuando movieService lanza una excepción',
      build: () {
        when(
          () => movieService.getTrendingMovies(),
        ).thenThrow(Exception('network error'));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotPopularMovies()),
      expect: () => [
        isA<GotPopularMoviesInProgress>(),
        isA<GotPopularMoviesFailed>().having(
          (state) => state.message,
          'message',
          'No se pudieron cargar las películas populares.',
        ),
      ],
    );
  });

  group('GotMovieDetails', () {
    blocTest<MoviesBloc, MoviesState>(
      'emite [InProgress, Successful] cuando movieService responde exitosamente',
      build: () {
        when(
          () => movieService.getMovieDetails(any()),
        ).thenAnswer((_) async => _movieDetails);
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotMovieDetails(movieId: 1)),
      expect: () => [
        isA<GotMovieDetailsInProgress>(),
        isA<GotMovieDetailsSuccessful>().having(
          (state) => state.movieDetails,
          'movieDetails',
          _movieDetails,
        ),
      ],
      verify: (_) {
        verify(() => movieService.getMovieDetails(1)).called(1);
      },
    );

    blocTest<MoviesBloc, MoviesState>(
      'emite [InProgress, Failed] cuando movieService lanza una excepción',
      build: () {
        when(
          () => movieService.getMovieDetails(any()),
        ).thenThrow(Exception('not found'));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotMovieDetails(movieId: 1)),
      expect: () => [
        isA<GotMovieDetailsInProgress>(),
        isA<GotMovieDetailsFailed>().having(
          (state) => state.message,
          'message',
          'No se pudieron cargar los detalles de la película.',
        ),
      ],
    );
  });

  group('GotSearchedMovies', () {
    blocTest<MoviesBloc, MoviesState>(
      'emite [InProgress, Successful] cuando movieService responde exitosamente',
      build: () {
        when(() => movieService.searchMovies(any())).thenAnswer(
          (_) async => PaginatedResponse(
            page: 1,
            results: [_buildMovie(1)],
            totalPages: 1,
            totalResults: 1,
          ),
        );
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotSearchedMovies(query: 'batman')),
      expect: () => [
        isA<GotSearchedMoviesInProgress>(),
        isA<GotSearchedMoviesSuccessful>().having(
          (state) => state.movies.length,
          'movies.length',
          1,
        ),
      ],
      verify: (_) {
        verify(() => movieService.searchMovies('batman')).called(1);
      },
    );

    blocTest<MoviesBloc, MoviesState>(
      'emite [InProgress, Failed] cuando movieService lanza una excepción',
      build: () {
        when(
          () => movieService.searchMovies(any()),
        ).thenThrow(Exception('search failed'));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(GotSearchedMovies(query: 'batman')),
      expect: () => [
        isA<GotSearchedMoviesInProgress>(),
        isA<GotSearchedMoviesFailed>().having(
          (state) => state.message,
          'message',
          'No se pudieron buscar las películas.',
        ),
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'emite [Initial] cuando el query está vacío, sin llamar a movieService',
      build: () => moviesBloc,
      act: (bloc) => bloc.add(GotSearchedMovies(query: '')),
      expect: () => [isA<MoviesInitial>()],
      verify: (_) {
        verifyNever(() => movieService.searchMovies(any()));
      },
    );

    blocTest<MoviesBloc, MoviesState>(
      'emite [Initial] cuando el query solo tiene espacios en blanco',
      build: () => moviesBloc,
      act: (bloc) => bloc.add(GotSearchedMovies(query: '   ')),
      expect: () => [isA<MoviesInitial>()],
      verify: (_) {
        verifyNever(() => movieService.searchMovies(any()));
      },
    );
  });
}
