// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hi_flt/widget/counter.dart';
import 'package:hi_flt/widget/buttons.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'TGTAPI.dart';
import 'main.dart';
import 'providers/counts.dart';
import 'providers/contentinfo_retro.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentINFO()),
      ],
      child: TGTContent_test(),
    ),
  );
}

class TGTContent_test extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body: SafeArea(
          child: TGTContentWidget(),
        ),
      ),
    );
  }
}

class TGTContentWidget extends StatefulWidget {
  const TGTContentWidget({Key? key}) : super(key: key);

  @override
  _TGTContentWidgetState createState() => _TGTContentWidgetState();
}

class _TGTContentWidgetState extends State<TGTContentWidget> {
  void retro2() {
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    client.getoproduct().then((it) {
      context.read<ContentINFO>().one(it[1].title);
      context.read<ContentINFO>().two(it[0].user);
      // context.read<info>().three(it);
      // provider에 list 통으로 넣어두고
      // 여기서 []접근하고 활용할라했는데
      // 그렇게 안되니까 앞에서 list벗겨서 넣어야겠다.
      logger.i(it);
    });
  }

  late RestClient client;

  @override
  void initState() {
    super.initState();
    print('hi');
    //retro2();

    // Dio dio = Dio();
    // client = RestClient(dio);
    //
    // Future.microtask(() async {
    //   final test = await client.getoproduct();
    //   logger.i(test);
    // });
  }

  var hoho = ['111', '222', '333'];

  Widget getTestWidgets(List<String> strings) {
    return new Row(children: strings.map((item) => new Text(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 130,
                width: 130,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0)),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    'images/415.PNG',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: 130,
                width: 180,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0)),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                    title: Text(
                      context.watch<ContentINFO>().res,
                      style: TextStyle(
                        fontFamily: 'BalsamiqSans',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    subtitle: Text(
                      context.watch<ContentINFO>().res2.toString(),
                    ),
                  ),
                ),
              ),
            ]),
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Image.asset(
                      'images/415.PNG',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 60,
                                child: Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02),
                                  alignment: Alignment.centerLeft,
                                  height: double.infinity,
                                  color: Colors.white,
                                  child: Text(
                                    "title",
                                    style: TextStyle(
                                      fontFamily: 'BalsamiqSans',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 17,
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                flex: 23,
                                child: Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  alignment: Alignment.centerRight,
                                  height: double.infinity,
                                  color: Colors.white,
                                  child: Text(
                                    "locate",
                                    style: TextStyle(
                                      fontFamily: 'BalsamiqSans',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.02,
                              0,
                              MediaQuery.of(context).size.width * 0.02,
                              MediaQuery.of(context).size.width * 0.01,
                            ),
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            color: Colors.white,
                            child: Text(
                              "dddd",
                              style: TextStyle(
                                fontFamily: 'BalsamiqSans',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.width * 0.01,
                                0,
                                0),
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            color: Colors.white,
                            child: Text(
                              "inguser",
                              style: TextStyle(
                                fontFamily: 'BalsamiqSans',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        for (var a in hoho) Text(a),
        getTestWidgets(hoho),
        Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 130,
                width: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: Colors.orange,
                )),
              ),
              Container(
                height: 130,
                width: 50,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: Colors.orange,
                )),
              ),
              Container(
                height: 130,
                width: 50,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: Colors.orange,
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// children: <Widget>[
// Card(
// child: Image.asset('images/415.PNG',
// height: 130,
// width: 130,
// fit: BoxFit.fill,
// ),
// ),
// Container(
// height: 130.0,
// //width: double.infinity,
// //padding: EdgeInsets.all(20.0),
// child: Card(
// //margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
// color: Colors.white,
// child: Padding(
// padding: EdgeInsets.all(20),
// child: Counter(),
// ),
// ),
// )
// ]
