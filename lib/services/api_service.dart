import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movies.dart';

class ApiService {
  static const _baseUrl = 'http://www.omdbapi.com/';
  static const _apiKey  = '59b5e0f5';

  /// Search OMDb by title (returns up to 10 results)
  Future<List<Movie>> searchMovies(String query) async {
    final uri = Uri.parse('$_baseUrl?apikey=$_apiKey&s=${Uri.encodeComponent(query)}');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Search failed (${res.statusCode})');
    }

    final body = json.decode(res.body) as Map<String, dynamic>;
    if (body['Response'] == 'True' && body['Search'] is List) {
      final List list = body['Search'];
      return list.map((j) => Movie.fromOmdbJson(j)).toList();
    }
    // No matches or error
    return [];
  }

  /// Fetch full details of a single movie by IMDb ID
  Future<MovieDetail> fetchMovieDetail(String imdbID) async {
    final uri = Uri.parse('$_baseUrl?apikey=$_apiKey&i=$imdbID&plot=full');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Detail fetch failed (${res.statusCode})');
    }

    final body = json.decode(res.body) as Map<String, dynamic>;
    if (body['Response'] == 'True') {
      return MovieDetail.fromJson(body);
    }
    throw Exception('Movie not found');
  }
}
