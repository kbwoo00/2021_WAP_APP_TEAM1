import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'View/page/loginpage.dart';
import 'View/page/tgt_mypage.dart';
import 'View/page/tgtcontentdetail.dart';
import 'View/page/tgtlistpage.dart';
import 'View/page/tgtaddpage.dart';
import 'View/ui/tgtbutton.dart';
import 'Controller/Provider/info.dart';
import 'Controller/Provider/counter_provider.dart';

import 'package:http/http.dart' as http;
import 'package:togetor/View/ui/tgtcontentwidget.dart';
import 'dart:convert' as convert;

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentINFO()),
        ChangeNotifierProvider(create: (_) => LoginINFO()),
        ChangeNotifierProvider(create: (BuildContext context) => CountProvider()),
      ],
      child: MaterialApp(
        home: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Add(),
                  ),
                );
              },
              child: Text('등록 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TGTlistpage(),
                  ),
                );
              },
              child: Text('목록 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TGTContentDetail(),
                  ),
                );
              },
              child: Text('상세 페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TGTMyPageWidget(),
                  ),
                );
              },
              child: Text('마이페이지'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()
                  ),
                );
              },
              child: Text('로그인 페이지'),
            ),
            TGTButton(
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                print("button add");
              },
            ),
          ],
        ),
      )),
    );
  }
}

class add2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondScreen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go First Screen'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
