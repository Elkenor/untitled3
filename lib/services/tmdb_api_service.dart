import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBApiService {
  static const String apiKey = '80b3339080c08b0a26f21c2e20e886b7';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MGIzMzM5MDgwYzA4YjBhMjZmMjFjMmUyMGU4ODZiNyIsIm5iZiI6MTc0MDQ0NDQyNi4yNDMsInN1YiI6IjY3YmQxMzBhMThmMWU3N2NmYWE0NzljNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pyOlkdNqccH_tgg0askrLJELtW4CDfgQk-dfF1W14WI';

  static Future<List<dynamic>> fetchMovies() async {
    const String url = 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
