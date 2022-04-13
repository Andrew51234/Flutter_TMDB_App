import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbAPI {
  static late TMDB _tmdb;

  static Future moviesInit() async {
    await dotenv.load();
    var apiKeyV3 = dotenv.env['API_KEY_V3'] ?? '';
    var apiKeyV4 = dotenv.env['API_KEY_V4'] ?? '';
    _tmdb = TMDB(
      ApiKeys(apiKeyV3, apiKeyV4),
    );
  }

  static Future<Map> getTrendingMovies() async {
    var movies = await _tmdb.v3.trending.getTrending(
      mediaType: MediaType.movie,
    );
    return movies;
  }

  static Future<Map> getNextPage(int page) async {
    var movieList = _tmdb.v3.trending.getTrending(
      mediaType: MediaType.movie,
      page: page,
    );
    return movieList;
  }

  static Future<Map> getNextPageSearch(int page, String movieName) async {
    var movieList = _tmdb.v3.search.queryMovies(movieName, page: page);
    return movieList;
  }

  static Future<Map> findMovie(String movieName) async{
    var movieList = await _tmdb.v3.search.queryMovies(movieName);
    return movieList;
  }
}
