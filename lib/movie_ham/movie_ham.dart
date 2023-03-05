import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieham_app/movie_ham/random_movie_screen.dart';

class MovieHam extends StatefulWidget {
  const MovieHam({super.key});

  @override
  State<MovieHam> createState() => _MovieHamState();
}

class _MovieHamState extends State<MovieHam> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/randomMovieScreen",
      routes: {
        "/randomMovieScreen": (context) => RandomMovieScreen(),
      },
    );
  }
}