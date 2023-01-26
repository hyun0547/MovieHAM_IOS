import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        child: Text("Home")
      ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: (index) => {Navigator.pushNamed(context, '/$index')},
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet),
              label: '오늘의 추천',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              label: '마이 페이지',
            ),
          ],
          unselectedItemColor: Colors.white,
          selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
        ),
      ),
    );
  }
}
