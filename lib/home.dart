import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final categoryDepth1 = ["장르","연도","나라"];
  final category = {
    "장르": ["멜로", "스릴러", "드라마"],
    "연도": ["2000", "2010", "2020"],
    "나라": ["한국", "일본", "미국"]
  };

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
          child : ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                    shape : RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.black,
                    shadowColor: Colors.white,
                    child: ListTile(
                      title: Text(
                          categoryDepth1[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                );
              }),
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
