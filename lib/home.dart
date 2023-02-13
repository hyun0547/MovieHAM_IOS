import 'package:flutter/material.dart';

import 'movieProvider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final categoryDepth1 = ["장르", "개봉연도", "나라"];
  final category = {
    "장르": [
      "모험",
      "판타지",
      "애니메이션",
      "드라마",
      "공포",
      "액션",
      "코미디",
      "역사",
      "서부",
      "스릴러",
      "범죄",
      "다큐멘터리",
      "SF",
      "미스터리",
      "음악",
      "로맨스",
      "가족",
      "전쟁",
      "TV 영화",
    ],
    "개봉연도": ["2000", "2010", "2020"],
    "나라": ["대한민국", "일본", "미국"]
  };
  final categoryCode = {
    "장르": "genre",
    "개봉연도": "repRlsDate",
    "나라": "nation",
  };

  late final currentCategory;
  late final currentKeyword;
  var currentPageIndex;

  late List<Movie> nextMovies = [];
  late List<Movie> currentMovies = [];

  var itemCount;
  var scrollLoading = false;

  final ScrollController _controller = ScrollController();

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
        !_controller.position.outOfRange &&
        !scrollLoading) {
      setState(() {
        scrollLoading = true;
      });
      nextMovies = await MovieProvider.getCategorisedMovie(
          category: currentCategory,
          keywords: currentKeyword,
          pageIndex: currentPageIndex,
          countPerPage: 10);
      setState(() {
        currentMovies = List.from(currentMovies)..addAll(nextMovies);
        currentPageIndex = currentPageIndex + 1;
        itemCount = currentMovies.length;
        scrollLoading = false;
      });
    }
  }

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
        body: Container(
            color: Colors.black,
            child: currentMovies.isEmpty
                ? ListView.separated(
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
                              //apply padding to all four sides
                              child: Text(
                                categoryDepth1[index],
                                style: const TextStyle(
                                  letterSpacing: 5,
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            children: <Widget>[
                              SizedBox(
                                height: (category[categoryDepth1[index]]
                                        ?.length
                                        .toDouble())! *
                                    60,
                                child: ListView.builder(
                                    itemCount:
                                        category[categoryDepth1[index]]?.length,
                                    itemBuilder: (context, index2) {
                                      return ListTile(
                                        onTap: () async {
                                          currentMovies = await MovieProvider
                                              .getCategorisedMovie(
                                            category: categoryCode[
                                                categoryDepth1[index]],
                                            keywords: category[
                                                categoryDepth1[index]]![index2],
                                            pageIndex: 0,
                                            countPerPage: 10,
                                          );

                                          setState(() {
                                            currentMovies = currentMovies;
                                            itemCount = currentMovies.length;
                                            currentCategory = categoryCode[
                                                categoryDepth1[index]];
                                            currentKeyword = category[
                                                categoryDepth1[index]]![index2];
                                            currentPageIndex = 0;
                                          });
                                        },
                                        title: Text(
                                          textAlign: TextAlign.center,
                                          category[categoryDepth1[index]]![
                                              index2],
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ));
                    })
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            controller: _controller,
                            itemCount: itemCount,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 15,
                                ),
                                child: GestureDetector(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.2,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(currentMovies[index]
                                            .posterPath
                                            .split('|')[0]),
                                      ),
                                    ),
                                  ),
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
                  )),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: (index) => {Navigator.pushNamed(context, '/$index')},
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
