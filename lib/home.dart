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
      "멜로/로맨스",
      "드라마",
      "에로",
      "코메디",
      "가족",
      "뮤지컬",
      "공포",
      "SF",
      "액션",
      "스릴러",
      "어드벤처",
      "판타지",
      "미스터리",
      "범죄",
      "시대극/사극",
      "전쟁",
      "무협",
      "스포츠",
      "로드무비",
      "서부",
      "뮤직",
      "옴니버스",
      "전기",
      "실험",
      "아동",
      "역사",
      "인물",
      "재난"
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
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _controller.position.moveTo(_controller.position.maxScrollExtent);
      nextMovies = await MovieProvider.getCategorisedMovie(category: currentCategory,keywords: currentKeyword,pageIndex: currentPageIndex,countPerPage: 10);
      setState(() {
        currentPageIndex = currentPageIndex + 1;
        itemCount = currentMovies.length;
        currentMovies = List.from(currentMovies)..addAll(nextMovies);
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
                                          category: categoryCode[categoryDepth1[index]],
                                          keywords: category[categoryDepth1[index]]![index2],
                                          pageIndex: index,
                                          countPerPage: 10,
                                        );

                                        setState(()  {
                                          currentMovies = currentMovies;
                                          itemCount = currentMovies.length;
                                          currentCategory = categoryCode[
                                              categoryDepth1[index]];
                                          currentKeyword = category[
                                              categoryDepth1[index]]![index2];
                                          currentPageIndex = index + 1;
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
              : ListView.builder(
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
                                      .posters
                                      .split('|')[0]),
                                ),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
        ),
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
