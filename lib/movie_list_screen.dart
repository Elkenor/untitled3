import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:untitled3/services/tmdb_api_service.dart';
import 'package:untitled3/movie_detail_screen.dart';


class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final String apiKey = '80b3339080c08b0a26f21c2e20e886b7';
  final String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MGIzMzM5MDgwYzA4YjBhMjZmMjFjMmUyMGU4ODZiNyIsIm5iZiI6MTc0MDQ0NDQyNi4yNDMsInN1YiI6IjY3YmQxMzBhMThmMWU3N2NmYWE0NzljNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pyOlkdNqccH_tgg0askrLJELtW4CDfgQk-dfF1W14WI';
  List movies = [];
  List filteredMovies = [];
  List favoriteMovies = [];
  String searchQuery = "";
  String selectedGenre = "All";
  String sortBy = "Rating";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          onSelected: (value) {},
          itemBuilder: (BuildContext context) {
            return [
              'Profile', 'Settings', 'Notifications', 'Logout'
            ].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("In Theater", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("Box Office", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("Com", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text("Action"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text("Crime"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text("Comedy"),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text("Drama"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: TMDBApiService.fetchMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    return Center(
                      child: SizedBox(
                        height: 450,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final movie = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(movie: movie),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w400${movie['poster_path']}",
                                        fit: BoxFit.cover,
                                        height: 350,
                                        width: 250,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      movie['title'],
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.star, color: Colors.yellow, size: 18),
                                        Text(" ${movie['vote_average']}", style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
