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
import 'providers/retro_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => info()),
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
      context.read<info>().one(it[1].title);
      context.read<info>().two(it[0].user);
      // context.read<info>().three(it);
      // provider에 list 통으로 넣어두고
      // 여기서 []접근하고 활용할라했는데
      // 그렇게 안되니까 앞에서 list벗겨서 넣어야겠다.
      logger.i(it);
    });
  }

  late RestClient client;

  @override
  void initState(){
    super.initState();
    print('hi');
    retro2();

    // Dio dio = Dio();
    // client = RestClient(dio);
    //
    // Future.microtask(() async {
    //   final test = await client.getoproduct();
    //   logger.i(test);
    // });
  }

  var hoho = ['111', '222', '333'];

  Widget getTestWidgets(List<String> strings)
  {
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
                    contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                    title: Text(
                      context.watch<info>().res,
                      style: TextStyle(
                        fontFamily: 'BalsamiqSans',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    subtitle: Text(
                      context.watch<info>().res2.toString(),
                    ),
                  ),
                ),
              ),
            ]),
        SizedBox(
          height: 20,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/415.PNG',
                height: 130,
                width: 130,
                fit: BoxFit.fill,
              ),
            ]),
        for(var a in hoho) Text(a),
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
                    )
                ),
              ),
              Container(
                height: 130,
                width: 50,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.orange,
                  )
                ),
              ),
              Container(
                height: 130,
                width: 50,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.orange,
                    )
                ),
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
