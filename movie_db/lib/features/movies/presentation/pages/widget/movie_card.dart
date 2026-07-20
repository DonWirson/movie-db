import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String movieUrl;
  final String movieName;

  const MovieCard({super.key, required this.movieUrl, required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Image.network(movieUrl),
    );
  }
}
