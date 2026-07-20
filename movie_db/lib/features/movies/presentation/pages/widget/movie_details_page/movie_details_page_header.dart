import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/movie_details_page/movie_details_page_circle_icon_button.dart';

class MovieDetailsPageHeader extends StatelessWidget {
  static const double _backdropHeight = 220;
  static const double _posterWidth = 90;
  static const double _posterHeight = 130;

  final String? backdropUrl;
  final String? posterUrl;
  final double rating;

  const MovieDetailsPageHeader({
    super.key,
    required this.backdropUrl,
    required this.posterUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _backdropHeight + _posterHeight / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: _backdropHeight,
            width: double.infinity,
            child: backdropUrl == null
                ? Container(color: Colors.white10)
                : Image.network(backdropUrl!, fit: BoxFit.cover),
          ),

          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MovieDetailsPageCircleIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => context.pop(),
                ),
                const Text(
                  'Detail',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MovieDetailsPageCircleIconButton(
                  icon: Icons.bookmark_border,
                  onTap: () {},
                ),
              ],
            ),
          ),

          Positioned(
            right: 16,
            top: _backdropHeight - 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 24,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: posterUrl == null
                  ? Container(
                      width: _posterWidth,
                      height: _posterHeight,
                      color: Colors.white10,
                    )
                  : Image.network(
                      posterUrl!,
                      width: _posterWidth,
                      height: _posterHeight,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
