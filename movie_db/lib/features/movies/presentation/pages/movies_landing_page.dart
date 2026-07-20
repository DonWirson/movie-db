import 'package:flutter/material.dart';
import 'package:movie_db/config/app_colors.dart';
import 'package:movie_db/features/movies/presentation/enum/navigation_bar_enum.dart';
import 'package:movie_db/features/movies/presentation/pages/home_page.dart';
import 'package:movie_db/features/movies/presentation/pages/search_page.dart';
import 'package:movie_db/features/movies/presentation/pages/widget/home_page/top_watched_movies.dart';

class MoviesLandingPage extends StatefulWidget {
  const MoviesLandingPage({super.key});

  @override
  State<MoviesLandingPage> createState() => _MoviesLandingPageState();
}

class _MoviesLandingPageState extends State<MoviesLandingPage> {
  NavigationBarEnum _selectedItem = NavigationBarEnum.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Que ver")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IndexedStack(
          index: _selectedItem.index,
          children: [
            //Pages a mostrar
            //Home, Buscar, Watch List(no pidieron esto)
            HomePage(),
            SearchPage(),
            Center(
              child: Text(
                "Nada por ahora :D",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
      //Barra de navegación
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedItem.index,
        onTap: (index) =>
            setState(() => _selectedItem = NavigationBarEnum.values[index]),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.mainColor,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        items: [
          for (final item in NavigationBarEnum.values)
            BottomNavigationBarItem(icon: Icon(item.icon), label: item.label),
        ],
      ),
    );
  }
}
