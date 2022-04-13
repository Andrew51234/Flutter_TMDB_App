import 'package:flutter/material.dart';

import '../API/tmdbAPI.dart';

import '../screens/home.dart';
import '../widgets/movieCard.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _query = TextEditingController();
  late var movies = [];
  late bool isLoading = true;
  late String query;

  void search() async {
    var movieList = await TmdbAPI.findMovie(query);
    setState(() {
      isLoading = false;
      movies = movieList["results"];
    });
  }

  void _handleSearch(String value) {
    if (_query.text.isEmpty) {
      return;
    } else {
      setState(() {
        query = value;
        search();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(10),
        child: TextField(
          style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: 'RaleWay',
              decoration: TextDecoration.none),
          controller: _query,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                _handleSearch(_query.text);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(Icons.search),
            ),
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber,
              ),
            ),
            labelText: 'Search for a movie',
          ),
          onSubmitted: _handleSearch,
        ),
      ),
      _query.text != ''
          ? !isLoading && movies.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      if (movies[index]['original_title'] == null ||
                          movies[index]['poster_path'] == null ||
                          movies[index]['release_date'] == null ||
                          movies[index]['overview'] == null) {
                        return Container();
                      }
                      return MovieCard(
                        title: movies[index]['original_title'],
                        poster: movies[index]['poster_path'],
                        releaseDate: movies[index]['release_date'],
                        overview: movies[index]['overview'],
                      );
                    },
                  ),
                )
              : !isLoading && movies.isEmpty
                  ? const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                            fontSize: 22, fontFamily: 'RobotoCondensed'),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator())
          : const Center(),
    ]);
  }
}
