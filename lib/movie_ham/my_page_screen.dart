import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget{
  @override
  State<MyPageScreen> createState() => _MyPageScreen();
}

class _MyPageScreen extends State<MyPageScreen>{
  final screen_name = [
    // "categorizedMovieScreen",
    "randomMovieScreen",
    "categoriesMovieScreen",
    "myPageScreen"
  ];
  @override
  Widget build(BuildContext context) {
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
        body: ListTile(
          title: Text(
            "마이페이지",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
              primaryColor: Colors.red,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              onTap: (index) => {if(index!=2) Navigator.pushNamed(context, '/${screen_name[index]}')},
              selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
              currentIndex: 2,
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
      )
    );
  }

}