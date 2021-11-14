import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:togetor/ui/tgtbutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:togetor/ui/tgtcontentdetail.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TGTContentDetail());
  }
}
