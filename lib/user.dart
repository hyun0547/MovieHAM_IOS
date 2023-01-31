import 'package:flutter/material.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
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
            child: Text("User")
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          onTap: (index) => {Navigator.pushNamed(context, '/$index')},
          selectedItemColor: Color.fromRGBO(179, 18, 23, 1),
          currentIndex: 2,
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
              icon: Icon(Icons.people,),
              label: '마이 페이지',
            ),
          ],
          unselectedItemColor: Colors.white,
        ),
      ),
    );
  }
}
