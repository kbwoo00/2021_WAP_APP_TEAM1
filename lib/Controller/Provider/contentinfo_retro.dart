import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Retrofit/TGTAPI.dart';


class ContentINFO with ChangeNotifier {
   var _res = "loading";
   get res => _res;

   var _res2 = "description";
   get res2 => _res2;

   var _TGTinfo = [];
   get TGTinfo => _TGTinfo;

   void one(String m) {
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

   void retro() {
     Dio dio = Dio();
     RestClient client = RestClient(dio);

     client.getoproduct().then((it) async{
       _res = it[0].title;
       print("----------------------------");
     });
     notifyListeners();
   }

}