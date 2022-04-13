import 'package:flutter/material.dart';

import 'dart:async';

import '../API/tmdbAPI.dart';
import '../widgets/movieCard.dart';

class Home extends StatefulWidget {
  @override
  const Home({Key?key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late var data = [];
  late bool isLoading = true;
  int page = 0;

  late ScrollController _scroller;

  void loadTMDB() async {
    var movieList = await TmdbAPI.getTrendingMovies();
    setState(() {
      isLoading = false;
      page = 1;
      data = movieList["results"];
    });
  }

  @override
  void dispose() {
    _scroller.removeListener(handleScrolling);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scroller = ScrollController()..addListener(handleScrolling);
    loadTMDB();
  }

  Future<void> handleScrolling() async {
    if (_scroller.offset >= _scroller.position.maxScrollExtent) {
      setState(() {
        ++page;
      });
      var next = await TmdbAPI.getNextPage(page);

      setState(() {
        data.addAll(next["results"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading && data.isNotEmpty
        ? ListView.builder(
      controller: _scroller,
            itemCount: data.length,
            itemBuilder: (BuildContext ctx, int index) {
              if (data[index]['original_title'] == null ||
                  data[index]['poster_path'] == null ||
                  data[index]['release_date'] == null ||
                  data[index]['overview'] == null) {
                return Container();
              }
              return MovieCard(
                title: data[index]['original_title'],
                poster: data[index]['poster_path'],
                releaseDate: data[index]['release_date'],
                overview: data[index]['overview'],
              );
            },
          )
        : !isLoading && data.isEmpty
            ? const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 22, fontFamily: 'RobotoCondensed'),
                ),
              )
            : const Center(child: CircularProgressIndicator());
  }
}
