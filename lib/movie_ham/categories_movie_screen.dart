import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

import '../models/api_result_model.dart';
import '../provider/movie_provider.dart';

class CategoriesMovieScreen extends StatefulWidget {
  @override
  State<CategoriesMovieScreen> createState() => _CategoriesMovieScreen();
}

class _CategoriesMovieScreen extends State<CategoriesMovieScreen> {
  final needTextKeywordGroup = ["배우", "감독", "제목"];
  final screen_name = [
    // "categorisedMovieScreen",
    "randomMovieScreen",
    "categoriesMovieScreen",
    "myPageScreen"
  ];
  final Map<String, List<String>> group = {
    "언어": ["한국어", "영어", "일본어"],
    "장르": [
      '판타지',
      '코미디',
      '전쟁',
      '음악',
      '역사',
      '액션',
      '애니메이션',
      '스릴러',
      '서부',
      '범죄',
      '미스터리',
      '모험',
      '로맨스',
      '드라마',
      '다큐멘터리',
      '공포',
      '가족',
      'TV' '영화',
      'SF'
    ],
    "개봉연도": List.generate(30, (index) => '${DateTime.now().year - index}')
  };

  var expandedGroup = [];
  var selectedGroup = "";
  var selectedGroupKeyword = "";
  var currentPage = 0;
  late List<Movie>? currentMovies = [];
  late List<Movie>? nextMovies = [];
  final ScrollController _controller = ScrollController();
  var scrollLoading = false;
  late FocusNode focusNode = FocusNode();
  late var errorMessage = null;

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
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        scrollLoading = true;
      });
      nextMovies = await MovieProvider.getMovies(
          userId: user.id,
          group: selectedGroup,
          groupKeyword: selectedGroupKeyword,
          countPerPage: '10',
          pageIndex: '$currentPage');
      setState(() {
        scrollLoading = false;
        currentPage++;
        currentMovies!.addAll(nextMovies!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<User>(context);
    });
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: currentMovies!.length > 0
            ? AppBar(
                backgroundColor: Colors.black,
                title: Container(
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
                            onPressed: () {
                              setState(() {
                                currentMovies = [];
                                selectedGroup = "";
                                selectedGroupKeyword = "";
                                currentPage = 0;
                              });
                            },
                          )
                        ],
                      ),
                    )),
                elevation: 10,
                centerTitle: false,
              )
            : AppBar(
                backgroundColor: Colors.black,
                title: Container(
                child: CustomCheckBoxGroup(
                  margin: EdgeInsets.only(left:15, right:15,),
                  buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.white,
                  ),
                  enableShape: true,
                  shapeRadius: 100,
                  horizontal: false,
                  buttonLables: [
                    "새로운 영화",
                    "나의 무비함",
                  ],
                  buttonValuesList: [
                    "new",
                    "classified",
                  ],
                  width: 120,
                  selectedBorderColor: Color.fromRGBO(179, 18, 23, 1),
                  unSelectedBorderColor: Color.fromRGBO(179, 18, 23, 1),
                  selectedColor: Color.fromRGBO(179, 18, 23, 1),
                  unSelectedColor: Colors.black,
                  padding: 5,
                  checkBoxButtonValues: (List<dynamic> test ) { print(test); },
                )
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.black,
            child: selectedGroup.isNotEmpty && currentMovies!.length >= 1
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
                                    top: 10, bottom: 15, left: 10, right: 10),
                                child: GestureDetector(
                                    child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff333333),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        height: 250,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: GestureDetector(
                                              onTap: () {
                                                detailScreen(
                                                    currentMovies![index]
                                                        .movieId,
                                                    user.id);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: currentMovies![index]
                                                          .backdropPath
                                                          .isNotEmpty
                                                      ? DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              currentMovies![
                                                                      index]
                                                                  .backdropPath),
                                                        )
                                                      : DecorationImage(
                                                          image: AssetImage(
                                                              'images/logo/logoW.png'),
                                                        ),
                                                ),
                                              ),
                                            )),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              height: 45,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                currentMovies![index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ))),
                              );
                            }),
                      ),
                      scrollLoading
                          ? Positioned(
                              bottom: 5,
                              left: MediaQuery.of(context).size.width / 2 - 28,
                              child: Container(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  semanticsLabel: 'Circular progress indicator',
                                ),
                              ))
                          : Container()
                    ],
                  )
                : Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: group.keys.toList().length +
                            needTextKeywordGroup.length,
                        itemBuilder: (context, index) {
                          if (group.keys.toList().length > index)
                            return Card(
                              shape: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 1),
                              ),
                              color: Colors.black,
                              shadowColor: Colors.white,
                              child: ExpansionTile(
                                onExpansionChanged: (state) {
                                  setState(() {
                                    focusNode.unfocus();
                                    state
                                        ? expandedGroup.add(index)
                                        : expandedGroup.remove(index);
                                    selectedGroup = "";
                                  });
                                },
                                trailing: Icon(
                                  expandedGroup.contains(index)
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    group.keys.toList()[index],
                                    style: const TextStyle(
                                      letterSpacing: 5,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    height: 250 < (group[group.keys.toList()[index]]?.length.toDouble())! * 60 ? 250 : (group[group.keys.toList()[index]]?.length.toDouble())! * 60,
                                    child: ListView.builder(
                                        itemCount:
                                            group[group.keys.toList()[index]]
                                                ?.length,
                                        itemBuilder: (context, index2) {
                                          return ListTile(
                                            onTap: () async {
                                              setState(() {
                                                scrollLoading = true;
                                              });
                                              currentMovies =
                                                  (await MovieProvider.getMovies(
                                                userId: user.id,
                                                group: '${group.keys.toList()[index]}',
                                                groupKeyword: '${group[group.keys.toList()[index]]![index2]}',
                                                countPerPage: '10',
                                                pageIndex: '$currentPage',
                                              ))!;

                                              setState(() {
                                                scrollLoading = false;
                                                currentMovies = currentMovies;
                                                selectedGroup =
                                                    group.keys.toList()[index];
                                                selectedGroupKeyword = group[
                                                    group.keys.toList()[
                                                        index]]![index2];
                                                currentPage++;
                                              });
                                            },
                                            title: Text(
                                              group[group.keys
                                                  .toList()[index]]![index2],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            );
                          else
                            return Column(
                              children: [
                                Card(
                                    shape: Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    color: Colors.black,
                                    shadowColor: Colors.white,
                                    child: needTextKeywordGroup[index -
                                                group.keys.toList().length] ==
                                            selectedGroup
                                        ? TextField(
                                            cursorHeight: 25,
                                            autocorrect: false,
                                            autofocus: false,
                                            onSubmitted: (keyword) async {
                                              currentMovies =
                                                  await MovieProvider.getMovies(
                                                userId: user.id,
                                                group: needTextKeywordGroup[index - group.keys.toList().length],
                                                groupKeyword: keyword,
                                                countPerPage: '10',
                                                pageIndex: '0',
                                              );
                                              setState(() {
                                                errorMessage = selectedGroup;
                                                currentMovies = currentMovies;
                                              });
                                            },
                                            focusNode: focusNode,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            decoration: InputDecoration(
                                              // border: OutlineInputBorder(),
                                              // labelText: '$selectedGroup',
                                              errorText: errorMessage,
                                            ))
                                        : ListTile(
                                            title: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedGroup =
                                                    needTextKeywordGroup[index -
                                                        group.keys
                                                            .toList()
                                                            .length];
                                              });
                                              focusNode.requestFocus();
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Text(
                                                needTextKeywordGroup[index -
                                                    group.keys.toList().length],
                                                style: const TextStyle(
                                                  letterSpacing: 5,
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ))),
                              ],
                            );
                        }))),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.red,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            onTap: (index) => {
              if (index != 1)
                Navigator.pushNamed(context, '/${screen_name[index]}')
            },
            selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
            currentIndex: 1,
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
    Navigator.pushNamed(context, '/detailsMovieScreen',
        arguments: {"movie": movie, "userId": userId});
  }
}
