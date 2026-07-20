import 'package:flutter/material.dart';
import 'package:movie_db/config/app_theme.dart';
import 'package:movie_db/config/injection_container.dart';
import 'package:movie_db/config/router_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie Db :D',
      theme: AppTheme.theme,
      routerConfig: AppRoutes.router,
    );
  }
}
