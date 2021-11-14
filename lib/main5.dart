import 'package:flutter/material.dart';
import 'package:hi_flt/widget/tgtcontentwidget.dart';
import 'package:hi_flt/widget/tgtcontentwidget2.dart';
import 'package:provider/provider.dart';
import 'providers/contentinfo_retro.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentINFO()),
      ],
      child: TGTlistpage(),
    ),
  );
}

class TGTlistpage extends StatefulWidget {
  const TGTlistpage({Key? key}) : super(key: key);

  @override
  _TGTlistpageState createState() => _TGTlistpageState();
}

class _TGTlistpageState extends State<TGTlistpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body: SafeArea(
          child: ListView.separated(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index){
              return Container(
                height: 50,
                color: Colors.amber[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
              );
            },
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}
