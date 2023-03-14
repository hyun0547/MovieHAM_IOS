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
  final needTextKeywordGroup = ["배우", "감독"];
  final screen_name = ["randomMovieScreen", "categoriesMovieScreen", ""];
  final Map<String, List<String>> group = {
    "언어":["한국어", "영어", "일본어"],
    "장르":['판타지','코미디','전쟁','음악','역사','액션','애니메이션','스릴러','서부','범죄','미스터리','모험','로맨스','드라마','다큐멘터리','공포','가족','TV' '영화','SF'],
    "개봉연도":List.generate(30, (index) => '${DateTime.now().year-index}')
  };

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
      setState((){
        scrollLoading = true;
      });
      nextMovies = await MovieProvider.getNotClassifiedMovies(user.id, selectedGroup, selectedGroupKeyword, '10', '$currentPage');
      setState((){
        scrollLoading = false;
        currentPage++;
        currentMovies!.addAll(nextMovies!);
      });
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
                            top: 10,
                            bottom: 15,
                          ),
                          child: GestureDetector(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xff333333),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 250,
                                child: Column(children: [
                                  Expanded(
                                    child: Container(
                                    decoration: BoxDecoration(
                                      image:  currentMovies![index].backdropPath.isNotEmpty? DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(currentMovies![index].backdropPath),
                                      ) : DecorationImage(
                                        image: AssetImage('images/logo/logoW.png'),
                                      ),
                                    ),
                                  ),),
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    height: 45,
                                    alignment: Alignment.centerLeft,
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
                    ? Positioned(
                    bottom: 5,
                    left: MediaQuery.of(context).size.width / 2 - 28,
                    child: Container(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        semanticsLabel: 'Circular progress indicator',
                      ),
                    )
                )
                    :Container()
              ],
            )
                : ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemCount: group.keys.toList().length + needTextKeywordGroup.length,
                itemBuilder: (context, index) {
                  if(group.keys.toList().length > index)
                    return Card(
                      shape: Border(
                        bottom: BorderSide(color: Colors.white, width: 1),
                      ),
                      color: Colors.black,
                      shadowColor: Colors.white,
                      child: ExpansionTile(
                        trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                        ),
                        title: Padding(
                          padding: EdgeInsets.all(5),
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
                            height: 250 < (group[group.keys.toList()[index]]?.length.toDouble())! * 60 ? 250 : (group[group.keys.toList()[index]]?.length.toDouble())! * 60,
                            child: ListView.builder(
                                itemCount:
                                group[group.keys.toList()[index]]?.length,
                                itemBuilder: (context, index2) {
                                  return ListTile(
                                    onTap: () async {
                                      setState((){
                                        scrollLoading = true;
                                      });
                                      currentMovies = (await MovieProvider
                                          .getNotClassifiedMovies(
                                        user.id,
                                        '${group.keys.toList()[index]}',
                                        '${group[group.keys.toList()[index]]![index2]}',
                                        '10',
                                        '$currentPage',
                                      ))!;

                                      setState(() {
                                        scrollLoading = false;
                                        currentMovies = currentMovies;
                                        selectedGroup = group.keys.toList()[index];
                                        selectedGroupKeyword = group[group.keys.toList()[index]]![index2];
                                        currentPage++;
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
                  else return Card(
                      shape: Border(
                        bottom: BorderSide(color: Colors.white, width: 1),
                      ),
                    color: Colors.black,
                    shadowColor: Colors.white,
                    child: needTextKeywordGroup[index-group.keys.toList().length] == selectedGroup?
                    TextField(
                        cursorHeight: 25,
                        autocorrect:false,
                        autofocus:false,
                        onSubmitted:(keyword) async {
                          currentMovies = await MovieProvider.getNotClassifiedMovies(
                            user.id, needTextKeywordGroup[index-group.keys.toList().length], keyword,
                            '10', '0',
                          );
                          setState((){
                            if(selectedGroup == '배우'){
                              errorMessage = "배우";
                            }
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
                        )
                    ):
                      ListTile(
                      title: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedGroup = needTextKeywordGroup[index-group.keys.toList().length];
                          });
                          focusNode.requestFocus();
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            needTextKeywordGroup[index-group.keys.toList().length],
                            style: const TextStyle(
                              letterSpacing: 5,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    )
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