import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/tgt_side_bar.dart';
import '../ui/tgttop_bar.dart';
import '../ui/tgtcontentwidget.dart';
import '../../Controller/Retrofit/TGTAPI.dart';
import '../../Controller/Provider/info.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ContentINFO()),
//         // ChangeNotifierProvider(create: (_) => ContentINFO()),
//       ],
//       child: TGTlistpage(),
//     ),
//   );
// }

class TGTlistpage extends StatefulWidget {
  const TGTlistpage({Key? key}) : super(key: key);

  @override
  _TGTlistpageState createState() => _TGTlistpageState();
}

class _TGTlistpageState extends State<TGTlistpage> {
  var _controller;
  var message;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
        print(message);
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // setState(() {
      //   message = "reach the top";
      //   print(message);
      // });
      retro2();
      print("retro running");
    }
    //print(_controller.offset);
  }

  final key1 = const Key('key1');

  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();

    retro2();
    print("hello");
  }

  void retro2() {
    Dio dio = Dio();
    RestClient client = RestClient(dio);

    client.getoproduct().then((it) {
      context.read<ContentINFO>().INFO(it);
      print(it);
    });
  }

  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  //var testmap = { 'title':'안녕하세요', 'title2':'하이요'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key1,
      endDrawer: TGTSideBar(),
      appBar: TGTtop_bar(appBar: AppBar(), title: "Contents list", key: key1),
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: ListView.builder(
          controller: _controller,
          itemCount: context.watch<ContentINFO>().TGTinfo.length,
          itemBuilder: (BuildContext context, int index) {
            return TGTContentWidget(
              TGTlist: context.watch<ContentINFO>().TGTinfo[index],
              index: index,
            );
          }, //separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}

// class TGTlistpage extends StatelessWidget {
//
//   var testmap = { 'title':'안녕하세요'};
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.cyan,
//         body: SafeArea(
//           child: ListView.builder(
//             itemCount: 6,
//             itemBuilder: (BuildContext context, int index){
//               return TGTContentWidget(testtile: "한글로 테스트",
//                 testlist: testmap,
//               );
//             },
//             //separatorBuilder: (BuildContext context, int index) => const Divider(),
//           ),
//         ),
//       ),
//     );
//   }
// }
