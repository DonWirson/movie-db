import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/features/movies/presentation/pages/movie_details.dart';
import 'package:movie_db/features/movies/presentation/pages/movies_landing_page.dart';


class AppRoutes {
  
static final GoRouter router = GoRouter(
  routes: <RouteBase>[
    //Vista principal :D
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MoviesLandingPage();
      },

      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const MovieDetails();
          },
        ),
      ],
    ),
  ],
);
}
