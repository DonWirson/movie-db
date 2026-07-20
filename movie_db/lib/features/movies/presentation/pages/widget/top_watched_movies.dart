import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/config/http/tmdb_config.dart';
import 'package:movie_db/config/injection_container.dart';
import 'package:movie_db/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_card.dart';

class TopWatchedMovies extends StatelessWidget {
  const TopWatchedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoviesBloc>()..add(GotPopularMovies()),
      child: const _TopWatchedMoviesView(),
    );
  }
}

class _TopWatchedMoviesView extends StatelessWidget {
  static const double _sectionHeight = 260;

  const _TopWatchedMoviesView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state is GotPopularMoviesFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is GotPopularMoviesSuccessful) {
          return SizedBox(
            height: _sectionHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: state.movies.length,
              separatorBuilder: (context, index) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(
                  movieUrl: movie.posterPath == null
                      ? ''
                      : '${TmdbConfig.imageBaseUrl}${movie.posterPath}',
                  movieName: movie.title,
                  rank: index + 1,
                );
              },
            ),
          );
        }

        if (state is GotPopularMoviesFailed) {
          return const SizedBox(
            height: _sectionHeight,
            child: Center(
              child: Text(
                'No se pudieron cargar las películas populares.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        }

        return const SizedBox(
          height: _sectionHeight,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
