import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/config/http/tmdb_config.dart';
import 'package:movie_db/config/injection_container.dart';
import 'package:movie_db/core/util/widgets/search_input.dart';
import 'package:movie_db/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoviesBloc>(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  static const Duration _debounceDuration = Duration(milliseconds: 1500);

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      context.read<MoviesBloc>().add(GotSearchedMovies(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchInput(onChanged: _onQueryChanged),
        const SizedBox(height: 15),
        Expanded(
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is GotSearchedMoviesInProgress) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is GotSearchedMoviesFailed) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              }

              if (state is GotSearchedMoviesSuccessful) {
                if (state.movies.isEmpty) {
                  return const Center(
                    child: Text(
                      'No se encontraron películas.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(
                      movieId: movie.id,
                      movieUrl: movie.posterPath == null
                          ? ''
                          : '${TmdbConfig.imageBaseUrl}${movie.posterPath}',
                      movieName: movie.title,
                      onTap: () => context.push('/details/${movie.id}'),
                    );
                  },
                );
              }

              return const Center(
                child: Text(
                  'Busca una película por su nombre.',
                  style: TextStyle(color: Colors.white54),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
