import 'package:flutter/material.dart';
import './movieProvider.dart';

void main() {
  // Future<List<Movie>> movies = MovieProvider.getMovie();
  // print(movies);
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<List<Movie>> movies = MovieProvider.getMovie();
  bool isLoading = true;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        appBar: AppBar(
          backgroundColor :  Color.fromRGBO(179,18,23,1),
          title: const Text('MovieHam', style: TextStyle(fontFamily: 'NanumSquareEB')),
          elevation: 10,
          centerTitle : false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Go to the next page',
              onPressed: () {
              },
            ),
          ],
        ),
        // appBar : AppBar(
        //   backgroundColor: Color.fromRGBO(179,18,23,1),
        //   title : Text('movieHam'),
        // ),

        body : Center(
          child: FutureBuilder(
            future: movies,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data.);
              }else{
                return Text('loading');
              }
            },
          ),
        ),
      ),
    );
  }
}


