import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/config/http/tmdb_config.dart';
import 'package:movie_db/config/injection_container.dart';
import 'package:movie_db/features/movies/data/models/movie_details.dart';
import 'package:movie_db/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_details_page/movie_details_page_about_movie_tab.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_details_page/movie_details_page_header.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_details_page/movie_details_page_info_chip.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoviesBloc>()..add(GotMovieDetails(movieId: movieId)),
      child: const _MovieDetailsView(),
    );
  }
}

class _MovieDetailsView extends StatelessWidget {
  const _MovieDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is GotMovieDetailsSuccessful) {
              return _MovieDetailsContent(movie: state.movieDetails);
            }

            if (state is GotMovieDetailsFailed) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white70),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _MovieDetailsContent extends StatelessWidget {
  static const List<String> _tabs = ['About Movie', 'Reviews', 'Cast'];

  final MovieDetails movie;

  const _MovieDetailsContent({required this.movie});

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath == null
        ? null
        : '${TmdbConfig.imageBaseUrl}${movie.posterPath}';
    final backdropUrl = movie.backdropPath == null
        ? null
        : '${TmdbConfig.imageBaseUrl}${movie.backdropPath}';
    final year = movie.releaseDate?.year.toString() ?? '-';
    final genre = movie.genres.isEmpty ? '-' : movie.genres.first.name;

    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          MovieDetailsPageHeader(
            backdropUrl: backdropUrl,
            posterUrl: posterUrl,
            rating: movie.voteAverage,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    MovieDetailsPageInfoChip(
                      icon: Icons.calendar_today,
                      label: year,
                    ),
                    const SizedBox(width: 16),
                    MovieDetailsPageInfoChip(
                      icon: Icons.access_time,
                      label: '${movie.runtime} Minutes',
                    ),
                    const SizedBox(width: 16),
                    MovieDetailsPageInfoChip(
                      icon: Icons.confirmation_number_outlined,
                      label: genre,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.blueAccent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [for (final tab in _tabs) Tab(text: tab)],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                MovieDetailsPageAboutMovieTab(overview: movie.overview),
                const Center(
                  child: Text(
                    'Sin reseñas por ahora',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const Center(
                  child: Text(
                    'Reparto no disponible',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
