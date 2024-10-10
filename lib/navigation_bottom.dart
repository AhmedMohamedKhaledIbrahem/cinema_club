import 'package:cinema_club/features/add_movie_favorite/presentation/screens/movie_favorite_screen.dart';
import 'package:cinema_club/features/getmovies/presentation/screens/movie_search_screen.dart';
import 'package:cinema_club/features/getmovies/presentation/screens/movies_screen.dart';
import 'package:cinema_club/features/setting/presentation/screens/setting_screen.dart';
import 'package:cinema_club/generated/l10n.dart';
import 'package:flutter/material.dart';

class MoviesNav extends StatefulWidget {
  const MoviesNav({
    super.key,
  });

  @override
  State<MoviesNav> createState() => _MoviesNavState();
}

class _MoviesNavState extends State<MoviesNav> {
  int _currentIndex = 0;

  // Define the two screens: MoviesScreen (this one) and SearchScreen
  final List<Widget> _screens = [
    const MoviesScreen(),
    const MovieSearchScreen(),
    const MovieFavoriteScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade900,
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).homeLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: S.of(context).searchLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: S.of(context).favoriteLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).settingLabel,
          ),
        ],
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }
}
