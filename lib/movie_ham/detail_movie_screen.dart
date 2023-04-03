import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/api_result_model.dart';
import '../provider/movie_provider.dart';

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
    int userId = arguments["userId"];
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Column(
              children: [

                //section1 start
                Stack(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        opacity: 0.4,
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
                                         if(true)
                                         IconButton(
                                             iconSize: 25,
                                             color: Colors.white,
                                             icon: const Icon(Icons.delete),
                                             tooltip: '볼거에요',
                                             onPressed: () async {
                                               await MovieProvider.insertWish(userId:'${userId}', movieId:'${movie.movieId}', seenYn:"N", wishStatus: "W");
                                               showDialog<String>(
                                                 context: context,
                                                 builder: (BuildContext context) => AlertDialog(
                                                   content: const Text('위시 리스트에 저장 되었습니다.'),
                                                 ),
                                               );
                                             }),
                                         if(true)
                                         IconButton(
                                             iconSize: 25,
                                             color: Colors.white,
                                             icon: const Icon(true?Icons.circle_outlined:Icons.circle),
                                             tooltip: '볼거에요',
                                             onPressed: () async {
                                               await MovieProvider.insertWish(userId:'${userId}', movieId:'${movie.movieId}', seenYn:"N", wishStatus: "W");
                                               showDialog<String>(
                                                 context: context,
                                                 builder: (BuildContext context) => AlertDialog(
                                                   content: const Text('위시 리스트에 저장 되었습니다.'),
                                                 ),
                                               );
                                             }),
                                         if(false)
                                         IconButton(
                                             iconSize: 25,
                                             color: Colors.white,
                                             icon: const Icon(Icons.add),
                                             tooltip: '볼거에요',
                                             onPressed: () async {
                                               await MovieProvider.insertWish(userId:'${userId}', movieId:'${movie.movieId}', seenYn:"N", wishStatus: "W");
                                               showDialog<String>(
                                                 context: context,
                                                 builder: (BuildContext context) => AlertDialog(
                                                   content: const Text('위시 리스트에 저장 되었습니다.'),
                                                 ),
                                               );
                                             }),
                                         IconButton(
                                             iconSize: 25,
                                             color: Colors.white,
                                             icon: const Icon(Icons.share),
                                             tooltip: '공유하기',
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
                                            Container(
                                              child:Text(
                                                movie.title,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Container(
                                              child: Text(
                                                "(${movie.originalTitle})",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    color: Colors.white70
                                                ),
                                              ),
                                            )
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
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Row(
                                            children:[
                                              Row(children:
                                              List.generate(
                                                5,
                                                    (index) => Icon((double.parse(movie.voteAverage)/2).floor() > index ? Icons.star
                                                      : ((double.parse(movie.voteAverage)/2).floor() == index ? ((double.parse(movie.voteAverage)/2) < (double.parse(movie.voteAverage)/2).round() ? Icons.star_half : Icons.star_border) : Icons.star_border),
                                                  color:Colors.red,
                                                  size: 16,
                                                ),
                                              )
                                              )
                                              , Container(
                                                padding: EdgeInsets.only(left:5),
                                                child: Text(
                                                  "${double.parse(movie.voteAverage)/2}",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10,
                                                      color: Colors.white70
                                                  ),
                                                ),
                                              )
                                            ]
                                          ),
                                          ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child:Text(
                                            movie.releaseDate.replaceAll("-", " / "),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                color: Colors.white70
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: List.generate(movie.genreList.length, (index) =>
                                              Text(
                                                  (index>0&&index<movie.genreList.length?" / ":"")+movie.genreList[index].name,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 10,
                                                      color: Colors.white70
                                                  ),
                                              )
                                          )
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
                              height: 110,
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
                                            image: people.profilePath!="" ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  people.profilePath
                                              ),
                                            ) : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "images/icon/profile-icon.png"
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          height: 40,
                                          child: Text(
                                            "${people.name.length > 7 ? people.name.replaceAll(" ", "\n") : people.name}",
                                            softWrap: true,
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

                //section4 start
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
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
                        height: 160,
                        child: FutureBuilder(
                          future: MovieProvider.getMovies(
                              group: 'genre',
                              groupKeyword: '${movie.genreList[0].name}',
                              countPerPage: '10',
                              pageIndex: '0',
                          ),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData) {
                              List<Movie> relatedMovieList = snapshot.data;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 110, // set this
                                      child: Column(children: [
                                        Container(
                                          height: 130,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                5),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  relatedMovieList[index].posterPath
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          height: 20,
                                          child: Text(
                                            "${relatedMovieList[index].title}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ]),
                                    );
                                  });
                            }
                            else return Container();
                          }
                        )
                      )
                    ],
                  ),
                )
                //section4 end


              ],
            ),
          ),
        )
    );
  }
}