import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailScreen extends StatefulWidget {
  final Map<String, dynamic> movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  List<dynamic> cast = [];

  @override
  void initState() {
    super.initState();
    fetchCast();
  }

  Future<void> fetchCast() async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/${widget.movie['id']}/credits?api_key=80b3339080c08b0a26f21c2e20e886b7"),
    );
    if (response.statusCode == 200) {
      setState(() {
        cast = json.decode(response.body)['cast'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.movie['backdrop_path']}",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(widget.movie['release_date'] ?? 'Unknown'),
                      const SizedBox(width: 20),
                      Text(widget.movie['adult'] ? "18+" : "PG-13"),
                      const SizedBox(width: 20),
                      const Icon(Icons.access_time, size: 18, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text("${widget.movie['runtime']} min"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 8.0,
                    children: (widget.movie['genres'] ?? []).map<Widget>((genre) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          genre['name'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.movie['overview'] ?? "No description available.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Cast & Crew",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cast.length,
                      itemBuilder: (context, index) {
                        final castMember = cast[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w200${castMember['profile_path']}",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  castMember['name'] ?? "Unknown",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text("Watch Trailer"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}