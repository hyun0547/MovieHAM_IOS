import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:movieham_app/provider/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/login_model.dart';
import '../provider/kakao_login.dart';

class RandomMovieScreen extends StatefulWidget{
  const RandomMovieScreen({super.key});

  @override
  State<RandomMovieScreen> createState() => _RandomMovieScreenState();

}

class _RandomMovieScreenState extends State<RandomMovieScreen>{
  final screen_name = ["randomMovieScreen", "", ""];
  var _plotVisible = false;
  var user;

  @override
  Widget build(BuildContext context) {
    setState((){
      user = Provider.of<User>(context);
    });
    return MaterialApp(
      home: Scaffold(
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
          future: MovieProvider.getNotClassifiedMovie(Provider.of<User>(context).id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }
            else{
              return Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child:Stack(children: <Widget>[
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
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot.data!.posterPath),
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
                                              style: TextStyle(
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
                                    tooltip: '볼거에요',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${snapshot.data!.movieId}', seenYn:"N", wishStatus: "W");
                                      setState(() {});
                                    }),
                                IconButton(
                                    iconSize: 50,
                                    color: Colors.white,
                                    icon: const Icon(Icons.thumb_down),
                                    tooltip: '안볼거에요',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${snapshot.data!.movieId}', seenYn:"N", wishStatus: "N");
                                      setState(() {});
                                    }),
                                IconButton(
                                    iconSize: 50,
                                    color: Colors.white,
                                    icon: const Icon(Icons.next_plan),
                                    tooltip: '모르겠어요',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${snapshot.data!.movieId}', seenYn:"N", wishStatus: "D");
                                      setState(() {});
                                    }),
                                IconButton(
                                    iconSize: 50,
                                    color: Colors.white,
                                    icon: const Icon(Icons.add_chart),
                                    tooltip: '이미 봤어요',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${snapshot.data!.movieId}', seenYn:"Y", wishStatus: "Y");
                                      setState(() {});
                                    }),
                              ],
                            ),
                          )
                        ]),
                    ),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.bottomLeft,
                    child: Row(
                    children: <Widget>[
                      Text(
                        snapshot.data!.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'NanumSquareEB',
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${List.generate(snapshot.data.genreList.length, (index) => snapshot.data.genreList[index].name)}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'NanumSquareEB',
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                )
                ])
              );
    }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: (index) => {Navigator.pushNamed(context, '/${screen_name[index]}')},
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

}