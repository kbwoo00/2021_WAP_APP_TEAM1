// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hi_flt/API.dart';
import 'package:hi_flt/widget/counter.dart';
import 'package:hi_flt/widget/buttons.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'providers/counts.dart';
import 'providers/retro_provider.dart';

final logger = Logger();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counts()),
        ChangeNotifierProvider(create: (_) => info()),
      ],
      child: Test(),
    ),
  );
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

  @override
  void initState(){
    super.initState();
    print('hi');
    retro2();
    //context.read<info>().one("jabjab");
  }

  String res = 'bb';

  void retro2() {
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    client.getTasks().then((it) {
      context.read<info>().one(it[0].name);
      logger.i("retro2 hahaha");
    });
  }

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
                child: Counter(),
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
        // CircleAvatar(
        //   radius: 80.0,
        //   backgroundImage: AssetImage('images/415.PNG'),
        // ),
        GestureDetector(
          onTap: () {
            logger.i('taptatp');
            Dio dio = Dio();
            RestClient client = RestClient(dio);

            client.getTasks().then((it) {
              setState(() {
                res = it[2].name;
                context.read<info>().one(res);
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
                  context.watch<info>().res.toString()+'${widget.ress}',
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
        Container(
          child: Buttons()
        )
      ],
    );
  }
}
