import 'package:flutter/material.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_card.dart';

class TopWatchedMovies extends StatelessWidget {
  final List mostWatchedMovies;
  const TopWatchedMovies({super.key, required this.mostWatchedMovies});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieCard(
          movieUrl:
              "https://play-lh.googleusercontent.com/WycZ4i_q08YOJ92jMD1gNG6VPqDnccrDtRvUKEKkq4OySWNPrUGsFq2z0-nX8BNkNzUK5xjWeTk_nKSf-f4=w240-h480-rw",
          movieName: "",
        ),
      ],
    );
  }
}
