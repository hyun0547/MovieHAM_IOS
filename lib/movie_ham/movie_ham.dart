import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:movieham_app/movie_ham/random_movie_screen.dart';
import 'package:provider/provider.dart';

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
          "/randomMovieScreen": (context) => Provider(create: (context) =>Provider.of<User>,child:RandomMovieScreen()),
        },
    );
  }
}