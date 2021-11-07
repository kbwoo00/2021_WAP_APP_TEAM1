import 'package:flutter/material.dart';
import 'package:hi_flt/providers/counts.dart';
import 'package:provider/provider.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Counter');

    return Text(
      context.watch<Counts>().count.toString(),
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}