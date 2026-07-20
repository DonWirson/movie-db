import 'package:flutter/material.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/home_page/top_watched_movies.dart';

class HomePage extends StatelessWidget {
  static const List<String> _categoryTabs = [
    'Now playing',
    'Upcoming',
    'Top rated',
    'Popular',
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categoryTabs.length,
      child: Column(
        children: [
          TopWatchedMovies(),

          SizedBox(height: 15),

          TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [for (final tab in _categoryTabs) Tab(text: tab)],
          ),
        ],
      ),
    );
  }
}
