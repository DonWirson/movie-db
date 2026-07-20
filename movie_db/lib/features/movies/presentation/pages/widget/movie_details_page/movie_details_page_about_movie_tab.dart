import 'package:flutter/material.dart';

class MovieDetailsPageAboutMovieTab extends StatelessWidget {
  final String? overview;

  const MovieDetailsPageAboutMovieTab({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        (overview == null || overview!.isEmpty)
            ? 'Sin descripción disponible.'
            : overview!,
        style: const TextStyle(color: Colors.white70, height: 1.4),
      ),
    );
  }
}
