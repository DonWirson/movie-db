import 'package:flutter/material.dart';

//Card de pelicula, utilizado para mostrar peliculas en toda la app
class MovieCard extends StatelessWidget {
  static const double _width = 110;
  static const double _height = 200;

  final String movieUrl;
  final String movieName;
  final int? rank;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movieUrl,
    required this.movieName,
    this.rank,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: movieName,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (rank != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movieUrl,
                  height: _height,
                  width: _width,
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return _placeholder(
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => _placeholder(
                    child: const Icon(Icons.movie, color: Colors.white54),
                  ),
                ),
              ),

            Positioned(left: -5, bottom: -10, child: _RankNumber(rank: rank!)),
          ],
        ),
      ),
    );
  }

  Widget _placeholder({required Widget child}) {
    return Container(
      height: _height,
      width: _width,
      color: Colors.white10,
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _RankNumber extends StatelessWidget {
  final int rank;

  const _RankNumber({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$rank',
      style: const TextStyle(
        fontSize: 55,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        height: 1,
        color: Colors.white,
        shadows: [Shadow(color: Colors.black87, blurRadius: 10)],
      ),
    );
  }
}
