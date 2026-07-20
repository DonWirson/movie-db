import 'package:flutter/material.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/top_watched_movies.dart';

class MoviesLandingPage extends StatelessWidget {
  const MoviesLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Que ver")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TopWatchedMovies(mostWatchedMovies: [1, 2, 3, 45]),
          ],
        ),
      ),
    );
  }
}
