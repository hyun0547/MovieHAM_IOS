import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

import '../models/api_result_model.dart';
import '../provider/movie_provider.dart';

class CategoriesMovieScreen extends StatefulWidget{
  @override
  State<CategoriesMovieScreen> createState() => _CategoriesMovieScreen();
}

class _CategoriesMovieScreen extends State<CategoriesMovieScreen>{
  final screen_name = ["randomMovieScreen", "categoriesMovieScreen", ""];
  final List<String> years = List.generate(30, (index) => "${DateTime.now().year - index}");
  final group = {"언어":["한국어", "영어", "일본어"], "장르":["액션"], "개봉연도":[]};

  var groupSelected = false;
  late List<Movie>? currentMovies;
  final ScrollController _controller = ScrollController();
  var scrollLoading = true;

  var user;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent * 0.8 &&
        !_controller.position.outOfRange) {
      print("test");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState((){
      user = Provider.of<User>(context);
    });
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
        body: Container(
            color: Colors.black,
            child: groupSelected
                ? Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: currentMovies?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 15,
                          ),
                          child: GestureDetector(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 250,
                                child: Column(children: [
                                  Expanded(
                                    child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(currentMovies![index].backdropPath),
                                      ),
                                    ),
                                  ),),
                                  Container(
                                    padding: EdgeInsets.only(left: 15, bottom: 5),
                                    height: 30,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      currentMovies![index].title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                      ),
                                    ),
                                  )
                                ],)
                              )),
                        );
                      }),
                ),
                scrollLoading
                    ? Container()
                    : Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 0,
                  child: const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      semanticsLabel: 'Circular progress indicator',
                    ),
                  ),
                )
              ],
            )
                : ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.black,
                    shadowColor: Colors.white,
                    child: ExpansionTile(
                      title: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          group.keys.toList()[index],
                          style: const TextStyle(
                            letterSpacing: 5,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      children: <Widget>[
                        SizedBox(
                          height: (group[group.keys.toList()[index]]?.length.toDouble())! * 60,
                          child: ListView.builder(
                              itemCount:
                              group[group.keys.toList()[index]]?.length,
                              itemBuilder: (context, index2) {
                                return ListTile(
                                  onTap: () async {
                                    currentMovies = (await MovieProvider
                                        .getNotClassifiedMovies(
                                      user.id,
                                      '${group.keys.toList()[index]}',
                                      '${group[group.keys.toList()[index]]![index2]}',
                                      '10',
                                      '0',
                                    ))!;
                                    print(currentMovies);

                                    setState(() {
                                      currentMovies = currentMovies;
                                      groupSelected = true;
                                      // itemCount = currentMovies.length;
                                      // currentCategory = categoryCode[
                                      // categoryDepth1[index]];
                                      // currentKeyword = category[
                                      // categoryDepth1[index]]![index2];
                                      // currentPageIndex = 0;
                                    });
                                  },
                                  title: Text(
                                    group[group.keys.toList()[index]]![index2],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                })),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: (index) => {Navigator.pushNamed(context, '/${screen_name[index]}')},
          selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
          currentIndex: 1,
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
              icon: Icon(
                Icons.people,
              ),
              label: '마이 페이지',
            ),
          ],
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }

}