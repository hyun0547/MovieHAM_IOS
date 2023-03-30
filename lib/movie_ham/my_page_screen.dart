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
        body: Container(
          padding:EdgeInsets.only(left: 15, right: 15),
          color:Colors.black,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Card(
                      shape: Border(
                        bottom: BorderSide(color: Colors.white, width: 1),
                      ),
                      color: Colors.black,
                      shadowColor: Colors.white,
                      child: ExpansionTile(
                        title: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "test",
                            style: const TextStyle(
                              letterSpacing: 5,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        children: <Widget>[
                          SizedBox(
                            child: ListView.builder(
                                itemCount:
                                10,
                                itemBuilder: (context, index2) {
                                  return ListTile(
                                    title: Text(
                                      "test",
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
                    ),
                    Card(
                      shape: Border(
                        bottom: BorderSide(color: Colors.white, width: 1),
                      ),
                      color: Colors.black,
                      shadowColor: Colors.white,
                      child: ExpansionTile(
                        title: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "test",
                            style: const TextStyle(
                              letterSpacing: 5,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        children: <Widget>[
                          SizedBox(
                            child: ListView.builder(
                                itemCount:
                                10,
                                itemBuilder: (context, index2) {
                                  return ListTile(
                                    title: Text(
                                      "test",
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
                    ),
                  ],
                ),
              )
            ],
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