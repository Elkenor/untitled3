import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {
  final List<Map> movies;

  MovieSearchDelegate(this.movies);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = movies.where((movie) {
      final title = movie['title']?.toLowerCase() ?? '';
      return title.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final movie = results[index];
        return ListTile(
          title: Text(movie['title'] ?? 'Unknown'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movie: movie),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}

class MovieDetailScreen extends StatelessWidget {
  final Map movie;

  MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['title'] ?? 'Movie Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                  height: 400,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              movie['title'] ?? 'Unknown',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              movie['overview'] ?? 'No description available.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 5),
                Text('${movie['vote_average'] ?? 'N/A'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
