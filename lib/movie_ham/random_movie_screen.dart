import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomMovieScreen extends StatefulWidget{
  const RandomMovieScreen({super.key});

  @override
  State<RandomMovieScreen> createState() => _RandomMovieScreenState();
}

class _RandomMovieScreenState extends State<RandomMovieScreen>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("RandomMovieScreen"),),
      ),
    );
  }

}