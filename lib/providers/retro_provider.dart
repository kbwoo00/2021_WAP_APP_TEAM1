import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hi_flt/TGTAPI.dart';

import '../API.dart';
import '../main.dart';

// String retro() {
//   String res = 'hello';
//
//   Dio dio = Dio();
//   RestClient client = RestClient(dio);
//
//   client.getTasks().then((it) async{
//     res = it[0].name;
//     //logger.i(res);
//   });
//
//   logger.i(res);
//   return res;
// }


class info with ChangeNotifier {
   var _res = "loading";
   get res => _res;

   var _res2 = "description";
   get res2 => _res2;

   // var _res3 = [];
   // get res3 => _res3;

   void one(String m) {
     _res = m ;
     notifyListeners();
   }

   void two(String m){
     _res2 = m;
     notifyListeners();
   }

   // void three(List<Oproduct> m){
   //   _res3 = m;
   //   print('heelo');
   //   print(_res3[0].title);
   //   notifyListeners();
   //   // 여기까지 잘나오는데 최종 띄울 때 instance도 제대로 잡히는데
   //   // 자꾸 invalid value라하네
   // }
}

// widget build단에서 얻어와야한다 (hint)