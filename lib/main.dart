import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:movieham_app/login_screen.dart';
import 'package:movieham_app/provider/kakao_login.dart';
import 'package:movieham_app/movie_ham/random_movie_screen.dart';
import 'package:provider/provider.dart';

import 'intro_screen.dart';
import 'models/login_model.dart';
import 'movie_ham/movie_ham.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '5f562c7e9c84bdb767f3b3a2a9884ce8',
    javaScriptAppKey: '2494628c87e5299051a9686e86992a34',
  );

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  static final storage = FlutterSecureStorage();
  var userLoaded = false;
  var loginModel = LoginModel(KakaoLogin());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var userInfo = await storage.read(key: "user");
    
    setState((){
      userLoaded = true;
      loginModel.initLogin(jsonDecode(userInfo!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(child: child, opacity: animation);
      },
      child: userLoaded ? (loginModel.isLogined ? Provider(create:(context)=>loginModel.user, child:MovieHam()) : LoginScreen()): IntroScreen(),
    );
  }
}
