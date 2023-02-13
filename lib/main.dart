import 'package:flutter/material.dart';
import './movieProvider.dart';
import './user.dart';
import './home.dart';

void main() {
  // Future<List<Movie>> movies = MovieProvider.getMovie();
  // print(movies);
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/0',
      routes: {
        '/0': (context) => App(),
        '/1': (context) => Home(),
        "/2": (context) => User(),
      },
    ),
  );
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<Movie> movie = MovieProvider.getMovie(57759);
  bool isLoading = true;
  bool _plotVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            child: const Image(
              image: AssetImage('images/logo/logoW.png'),
              width: 150,
            ),
          ),
          elevation: 10,
          centerTitle: false,
        ),
        body: FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          GestureDetector(
                            onTapDown: (e) {
                              setState(() {
                                _plotVisible = !_plotVisible;
                              });
                            },
                            onTapUp: (e) {
                              setState(() {
                                _plotVisible = !_plotVisible;
                              });
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.7392,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot
                                        .data!.posterPath
                                        .split("|")[0]),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Visibility(
                                      visible: _plotVisible,
                                      child: Container(
                                          alignment: Alignment.center,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                          child: Container(
                                            margin: EdgeInsets.all(20),
                                            child: Text(
                                              snapshot.data!.overview,
                                              style: const TextStyle(
                                                letterSpacing: 1,
                                                wordSpacing: 1,
                                                fontSize: 20,
                                                fontFamily: 'NanumSquareEB',
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                    ),
                                    // Container(
                                    //   alignment: Alignment.topRight,
                                    //   margin: EdgeInsets.all(5),
                                    //   child: snapshot.data!.rating.isEmpty ? null : Image(
                                    //       width: 30,
                                    //       image: AssetImage(
                                    //            'images/rating/KMRB_${((snapshot.data!.rating).substring(0, 2) == '전체' ? "All" : (snapshot.data!.rating).substring(0, 2))}.png')
                                    //   ),
                                    // ),
                                  ],
                                )),
                          ),
                          Positioned(
                              bottom: 10,
                              right: 0,
                              child:  Column(
                                children: [
                                  IconButton(
                                      iconSize: 50,
                                      color: Colors.white,
                                      icon: const Icon(Icons.thumb_up),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {
                                        // setState(() {movie = MovieProvider.getMovie(int.parse(snapshot.data!.movieSeq)-1);});
                                      }),
                                  IconButton(
                                      iconSize: 50,
                                      color: Colors.white,
                                      icon: const Icon(Icons.thumb_down),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {
                                        // setState(() {movie = MovieProvider.getMovie(int.parse(snapshot.data!.movieSeq)-1);});
                                      }),
                                  IconButton(
                                      iconSize: 50,
                                      color: Colors.white,
                                      icon: const Icon(Icons.next_plan),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {
                                        // setState(() {movie = MovieProvider.getMovie(int.parse(snapshot.data!.movieSeq)-1);});
                                      }),
                                  IconButton(
                                      iconSize: 50,
                                      color: Colors.white,
                                      icon: const Icon(Icons.add_chart),
                                      tooltip: 'Increase volume by 10',
                                      onPressed: () {
                                        // setState(() {movie = MovieProvider.getMovie(int.parse(snapshot.data!.movieSeq)-1);});
                                      }),
                                ],
                              ),
                          )
                        ]),
                        Container(
                            color: Colors.black,
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  snapshot.data!.title,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'NanumSquareEB',
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "[${snapshot.data!.genreList}]",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'NanumSquareEB',
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ));
              }
              return Text("no Data");
            } else {
              return Text('loading');
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: (index) => {Navigator.pushNamed(context, '/$index')},
          selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
          currentIndex: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: '오늘의 추천',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet),
              label: '카테고리',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people,),
              label: '마이 페이지',
            ),
          ],
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }

  void getNextMovie() {}
}
