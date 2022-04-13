import 'package:flutter/material.dart';
import '../main.dart';
import './home.dart';
import './search.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  late List<Map<String, Object>> _screens;
  int _currentIndex = 0;

  @override
  void initState() {
    _screens = [
      {
        'title': 'Movies',
        'screen': const Home(),
      },
      {
        'title': 'Search',
        'screen': const Search(),
      },
    ];

    super.initState();
  }

  void _navigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.movie_outlined,
          color: Colors.white,
        ),
        title: const Text(
          'Movie Wiz',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _screens[_currentIndex]['screen'] as Widget,
      //     Text(
      //   'work in progress',
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _currentIndex,
        onTap: _navigate,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favorites',
          // ),
        ],
      ),
    );
  }
}
