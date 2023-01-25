import 'package:flutter/material.dart';
import './movieProvider.dart';

void main() {
  // Future<List<Movie>> movies = MovieProvider.getMovie();
  // print(movies);
  runApp(
      MaterialApp(
        title: 'Named Routes Demo',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => App(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/second': (context) => const SecondScreen(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          title: Container(
            child: Image(
              image: AssetImage('images/logoW.png'),
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
                    color: Colors.black,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                snapshot.data![0].posters.split("|")[0]),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            snapshot.data![0].title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'NanumSquareEB',
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )));
              }
              return Text("no Data");
            } else {
              return Text('loading');
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
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
