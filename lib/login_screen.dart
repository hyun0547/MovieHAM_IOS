import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:movieham_app/provider/kakao_login.dart';
import 'package:movieham_app/models/login_model.dart';

class LoginScreen extends StatelessWidget {
  final viewModel = LoginModel(KakaoLogin());
  static final storage = FlutterSecureStorage();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      storage.write(
                          key: "user", value: jsonEncode(viewModel.user));
                    },
                    child: Image.asset('images/button/kakao_login.png'),
                  ),
                ],
              )
          ),
        ));
  }
}

