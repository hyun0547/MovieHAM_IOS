import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/api_result_model.dart';

class DetailsMovieScreen extends StatefulWidget{
  const DetailsMovieScreen({super.key});

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreen();

}

class _DetailsMovieScreen extends State<DetailsMovieScreen>{
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Movie movie = arguments["movie"];
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child:Column(
              children: [

                //section1 start
                Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        opacity: 0.6,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            movie.backdropPath
                        ),
                      ),
                    ),
                    height: 350.0,
                  ),
                  Container(
                    height: 350.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.black87.withOpacity(0.0),
                            Colors.black,
                          ],
                        )),
                  ),
                  Container(
                    height: 350,
                    child: Column(
                      children: [
                          Expanded(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          iconSize: 25,
                                          color: Colors.white,
                                          icon: const Icon(Icons.arrow_back_ios),
                                          tooltip: '볼거에요',
                                          onPressed: () => Navigator.of(context).pop()),
                                      Container(child: Row(
                                       children: [
                                         IconButton(
                                             iconSize: 25,
                                             color: Colors.white,
                                             icon: const Icon(Icons.add),
                                             tooltip: '볼거에요',
                                             onPressed: () async {
                                             }),
                                         IconButton(
                                             iconSize: 25,
                                             color: Colors.white,
                                             icon: const Icon(Icons.share),
                                             tooltip: '볼거에요',
                                             onPressed: () async {
                                             }),
                                       ],
                                      ),)
                                    ],
                                  ),
                                )
                              )
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 30),
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  width: 150,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          movie.posterPath
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 15, top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              movie.title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Text(
                                              "(${movie.originalTitle})",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  color: Colors.white70
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          padding: EdgeInsets.only(left: 6, right: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(2),
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.white70
                                            ),
                                          ),
                                          child: Text(
                                            "12+",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8,
                                                color: Colors.white70
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                )
                              ],)
                          ),
                      ],
                    ),
                  )
                ]),
                //section1 end

                //section2 start
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "줄거리",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          movie.overview,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.white70
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //section2 end

                //section3 start
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "감독/출연진",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.white
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              height: 90,
                              child: ListView.builder(
                                  scrollDirection:Axis.horizontal,
                                  itemCount: movie.peopleList.length,
                                  itemBuilder: (context, index) {
                                    People people = movie.peopleList[index];
                                    return SizedBox(
                                      width: 80, // set this
                                      child: Column(children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  people.profilePath
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          height: 20,
                                          child: Text(
                                            "${people.name}",
                                            textAlign:TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ]),
                                    );
                                  }),
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                //section3 end

                //section3 start
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "관련영화",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 110,
                        child: ListView.builder(
                            scrollDirection:Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 145, // set this
                                child: Column(children: [
                                  Container(
                                    height: 80,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/rzdPqYx7Um4FUZeD8wpXqjAUcEm.jpg"
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    height: 20,
                                    child: Text(
                                      "$index",
                                      textAlign:TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            }),
                      )
                    ],
                  ),
                )
                //section3 end


              ],
            ),
          ),
        )
    );
  }
}