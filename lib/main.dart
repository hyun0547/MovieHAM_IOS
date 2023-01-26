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
  Future<List<Movie>> movies = MovieProvider.getMovie();
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
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
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
                                  image: NetworkImage(
                                      snapshot.data![0].posters.split("|")[0]),
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
                                          snapshot.data![0].plotKor,
                                          style: const TextStyle(
                                            letterSpacing: 1,
                                            wordSpacing: 1,
                                            fontSize: 20,
                                            fontFamily: 'NanumSquareEB',
                                            color: Color.fromRGBO(255, 255, 255, 1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ) 
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.all(5),
                                    child: Image(
                                        width: 30,
                                        image: AssetImage('images/rating/KMRB_${(snapshot.data![0].rating ?? "").substring(0, 2)}.png')),
                                  ),
                                ],
                              )
                          ),
                        ),

                        Container(
                            color: Colors.black,
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  snapshot.data![0].title,
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
                                  "[${snapshot.data![0].genre}]",
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
          onTap: (index) => {  Navigator.pushNamed(context, '/$index')},
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet),
              label: '오늘의 추천',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              label: '마이 페이지',
            ),
          ],
          unselectedItemColor: Colors.white,
          selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
        ),
      ),
    );
  }
}
