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
      body: SafeArea(child: yap(ress:'as'),
        ),
      ),
    );
  }
}

class yap extends StatefulWidget {
  final ress;
  const yap({Key? key, this.ress}) : super(key: key);

  @override
  _yapState createState() => _yapState();
}

class _yapState extends State<yap> {
  String res = 'bb';

  void retro() {
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    client.getTasks().then((it) {
      res = it[0].name;
      logger.i(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   retro();
    //   logger.i('hello'+res);
    // }); // 첨부터 레트로 적용되서 렌더링 될 수 없나
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 200.0,
          width: double.infinity,
          //padding: EdgeInsets.all(20.0),
          child: Card(
            margin: EdgeInsets.all(20.0),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(res,
                  style: TextStyle(
                    fontFamily: 'BalsamiqSans',
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  )),
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
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("asdfasdf",
                    style: TextStyle(
                      fontFamily: 'BalsamiqSans',
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                    ))),
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
        GestureDetector(
          onTap: () {
            logger.i('taptatp');
            Dio dio = Dio();
            RestClient client = RestClient(dio);

            client.getTasks().then((it) {
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
                Text(
                  'PKNU ${widget.ress}',
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
        ),
      ],
    );
  }
}
