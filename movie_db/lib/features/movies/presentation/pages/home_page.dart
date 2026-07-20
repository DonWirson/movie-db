import 'package:flutter/material.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/home_page/top_watched_movies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [TopWatchedMovies()]);
  }
}
