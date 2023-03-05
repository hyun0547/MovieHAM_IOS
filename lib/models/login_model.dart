import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:movieham_app/provider/social_login.dart';

class LoginModel{
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  LoginModel(this._socialLogin);

  Future initLogin(dynamic user) async{
    if (user != null ){
      this.user = User.fromJson(user);
      this.isLogined = true;
    }
  }

  Future login() async {
    isLogined = await _socialLogin.login();
    if(isLogined){
      user = await UserApi.instance.me();
    }
  }

  Future logout() async{
    _socialLogin.logout();
    isLogined = false;
    user = null;
  }

}