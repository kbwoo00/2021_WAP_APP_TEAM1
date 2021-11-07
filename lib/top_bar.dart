import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class top_bar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'together',//상단바 제목작성
      theme:ThemeData(
          primarySwatch: Colors.blue
      ),
      home : MyPage(),
    );
  }
}

class MyPage extends StatefulWidget{
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('together'),
        centerTitle: false, elevation:0.0,

        leading: IconButton(
            icon:Icon(Icons.arrow_left_rounded),
            onPressed: (){
              print('gotoback(navigation위젯');
            }

        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.account_circle,
        //     ),
        //     onPressed: (){},
        //   ),
        // ],
      ),

      endDrawer : Drawer(
          child : ListView(
            padding : EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child:Text('Drawer'),
                decoration: BoxDecoration(
                  color:Colors.blue,),
              ),
            ],
          )
      ),
    );
  }

}