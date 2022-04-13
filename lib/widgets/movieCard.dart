import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String poster;
  final String overview;
  final String releaseDate;

  const MovieCard(
      {required this.title,
      required this.poster,
      required this.overview,
      required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.23,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500$poster",
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      releaseDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      margin: const EdgeInsets.only(top: 10.0),
                      child: SingleChildScrollView(
                        child: Text(
                          overview,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'RobotoCondensed',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //     width: MediaQuery.of(context).size.width * 0.1,
            //     child: const Icon(Icons.favorite))
          ],
        ),
      ),
    );
  }
}
