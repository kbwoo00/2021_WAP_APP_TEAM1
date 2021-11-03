// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hi_flt/API.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() {
  runApp(Test());
}

class Test extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.teal,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: double.infinity,
                  //padding: EdgeInsets.all(20.0),
                  child: Card(
                    margin: EdgeInsets.all(20.0),
                    color:Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: API()
                    ),
                    // child: ListTile(
                    //   title: Text('제목'),
                    //   subtitle: Text('test123aaaaaa'),
                    //   isThreeLine: true,
                    //   dense: false,
                    // ),
                  ),
                ),
                Container(
                  height: 200.0,
                  width: double.infinity,
                  //padding: EdgeInsets.all(20.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20,0,20,20),
                    color:Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("asdfasdf",
                            style: TextStyle(
                              fontFamily: 'BalsamiqSans',
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                            ))
                    ),
                    // child: ListTile(
                    //   title: Text('제목'),
                    //   subtitle: Text('test123aaaaaa'),
                    //   isThreeLine: true,
                    //   dense: false,
                    // ),
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   height: 100.0,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //   )
                // ),
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage: AssetImage('images/415.PNG'),
                ),
                tab(),
              ],
            ),
          ),
        )
    );
  }
}

class tab extends StatefulWidget {
  const tab({Key? key}) : super(key: key);

  @override
  _tabState createState() => _tabState();
}

class _tabState extends State<tab> {
  String res = 'aa';

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap:(){
          logger.i('taptatp');
          Dio dio = Dio();
          RestClient client = RestClient(dio);

          client.getTasks().then((it){
            setState(() {
              res = it[0].name;
              logger.i(res);
            });
          });
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('PKNU $res',
                style: TextStyle(
                  fontFamily: 'BalsamiqSans',
                  fontSize: 40.0,
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  //letterSpacing: 2.5,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.touch_app,
                size: 50.0,
                color: Colors.amber.shade100,
              ),
            ],
          ),
        ),
      );
  }
}


class API extends StatefulWidget {
  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  /* RestClient 초기화 */
  //RestClient client;
  String res = 'aa';

  @override
  void initState() {
    super.initState();
    /* initState 내부에 초기화를 시켜줘요.
    *  파라미터에 Dio를 넣겠다고 설정헀었죠.
    *  일단 dio 부터 만들어주고, RestClient에 dio를 파라미터로 넣어줘요. */
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    /* initState 내부에서 간단한 테스트가 가능해요. */
    client.getTasks().then((it) => logger.i(it[0].name));
  }

  // Future<String> yap() async{
  //   Dio dio = Dio();
  //   RestClient client = RestClient(dio);
  //   final hey = await client.getTasks();
  //   return hey[0].name;
  // }

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    setState(() {
      client.getTasks().then((it){
        res = it[0].name;
        logger.i('api setstate');
      });
    });

    // client.getTasks().then((it){
    //   setState(() {
    //     res = it[0].name;
    //   });
    // });
    logger.i(res);
    //logger.i('yyyy');
    //logger.i(res);
    return Text("$res",
        style: TextStyle(
          fontFamily: 'BalsamiqSans',
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        )
    );
  }
}