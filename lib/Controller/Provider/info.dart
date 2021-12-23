import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:retrofit/retrofit.dart';
import '../Retrofit/TGTAPI.dart';
import '../Retrofit/mlogin.dart';


class ContentINFO with ChangeNotifier {
  var _res = 6;
  get res => _res;

  var _res2 = "description";
  get res2 => _res2;

  var _TGTinfo = [];
  get TGTinfo => _TGTinfo;

  void one(int m) {
    _res = m ;
    notifyListeners();
  }

  void two(String m){
    _res2 = m;
    notifyListeners();
  }

  void INFO(List<Oproduct> m){
    _TGTinfo = m;
    //print('heelo');
    //print(_TGTinfo[0].title);
    notifyListeners();
  }
}

class LoginINFO with ChangeNotifier{

  void retro_kakao(User m) {
    Dio dio = Dio();
    RestClient2 client = RestClient2(dio);

    client.getkakao(m).then((it) {
      print('-------------------------------------');
      print(it.toJson());
    });
  }

  void retro_naver(var m) {
    Dio dio = Dio();
    RestClient2 client = RestClient2(dio);

    client.getnaver(m).then((it) {
      print('-------------------------------------');
      print(it.toJson());
    });
  }

  NaverAccountResult? naverINFO;
  User? kakaoINFO;

  void LOGIN_naver(NaverAccountResult m){
    naverINFO = m;
    retro_naver(m);
    notifyListeners();
  }

  void LOGOUT_naver(var m){
    naverINFO = m;
    notifyListeners();
  }

  void LOGIN_kakao(User m){
    kakaoINFO = m;
    retro_kakao(m);
    notifyListeners();
  }

  void LOGOUT_kakao(var m){
    kakaoINFO = m;
    notifyListeners();
  }
}