import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:movieham_app/provider/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/api_result_model.dart';
import '../models/login_model.dart';
import '../provider/kakao_login.dart';

class RandomMovieScreen extends StatefulWidget{
  const RandomMovieScreen({super.key});

  @override
  State<RandomMovieScreen> createState() => _RandomMovieScreenState();

}

class _RandomMovieScreenState extends State<RandomMovieScreen>{
  final screen_name = [
    // "categorizedMovieScreen",
    "randomMovieScreen",
    "categoriesMovieScreen",
    "myPageScreen"
  ];
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
          future: MovieProvider.getMovies(
              userId: Provider.of<User>(context).id,
              group: '전체',
              groupKeyword: '',
              countPerPage: '1',
              pageIndex: '0',
              classifiedYn: "N"
          ).then((value) => value![0]
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            else{
              var movie = snapshot.data as Movie;
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
                            onTapCancel: () {
                              setState(() {
                                _plotVisible = !_plotVisible;
                              });
                            },
                            child: Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.black,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          movie.posterPath,
                                          fit: BoxFit.fill,
                                        ), // Text(key['title']),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _plotVisible,
                                      child: Container(
                                          alignment: Alignment.center,
                                          color: Color.fromRGBO(0, 0, 0, 0.5),
                                          child: Container(
                                            padding: EdgeInsets.only(left:10, right:70),
                                            child: Text(
                                              movie.overview,
                                              softWrap: true,
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
                                    icon: const Icon(Icons.info_outline),
                                    tooltip: '상세',
                                    onPressed: () {
                                      detailScreen(movie.movieId, user.id);
                                    }),
                                IconButton(
                                    iconSize: 50,
                                    color: Colors.white,
                                    icon: const Icon(Icons.thumb_up),
                                    tooltip: '볼거에요',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${movie.movieId}', seenYn:"N", wishStatus: "W");
                                      setState(() {});
                                    }),
                                IconButton(
                                    iconSize: 50,
                                    color: Colors.white,
                                    icon: const Icon(Icons.remove_red_eye),
                                    tooltip: '이미 봤어요',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${movie.movieId}', seenYn:"Y", wishStatus: "Y");
                                      setState(() {});
                                    }),
                                IconButton(
                                    iconSize: 50,
                                    color: Colors.white,
                                    icon: const Icon(Icons.arrow_forward_outlined),
                                    tooltip: '다음',
                                    onPressed: () async {
                                      await MovieProvider.insertWish(userId:'${user.id}', movieId:'${movie.movieId}', seenYn:"N", wishStatus: "N");
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
                        movie.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'NanumSquareEB',
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${List.generate(movie.genreList.length, (index) => movie.genreList[index].name)}",
                        style: const TextStyle(
                          fontSize: 10,
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
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.red,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            onTap: (index) => {if(index!=0) Navigator.pushNamed(context, '/${screen_name[index]}')},
            selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
            currentIndex: 0,
            items: const <BottomNavigationBarItem>[
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.today),
              //   label: '오늘 뭐볼까',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: '새로운 영화',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_snippet),
                label: '카테고리',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                ),
                label: '마이 페이지',
              ),
            ],
            unselectedItemColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void detailScreen(int movieId, userId) async {
    var movie = await MovieProvider.getMovie(movieId);
    var wish = await MovieProvider.getWish(movieId:movieId, userId:userId);
    Navigator.pushNamed(context, '/detailsMovieScreen', arguments: {"movie":movie, "userId":userId, "wish":wish}).then((value){
      setState(() {});
    });
  }

}