import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:untitled3/movie_list_screen.dart';
import 'movie_detail_screen.dart';
import 'package:untitled3/movie_detail_screen.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: MovieListScreen(),
    );
  }
}

