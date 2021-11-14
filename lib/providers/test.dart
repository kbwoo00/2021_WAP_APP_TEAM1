import 'package:flutter/material.dart';

class MyScrollController with ChangeNotifier {
  var scrollController = ScrollController();
  var data = <int>[];
  var isLoading = false;
  var hasMore = false;
  var isShow = true;

  @override
  void initState() {
    // _getData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent && hasMore) {
        print("scroll hi hello");// _getData();
      }
    });

    // _getData() async {
    //   isLoading.value = true;
    //   await Future.delayed(Duration(seconds: 2));
    //   int offset = data.length;
    //   var appendData = List<int>.generate(10, (i) => i + 1 + offset);
    //   data.addAll(appendData);
    //   isLoading.value = false;
    //   hasMore.value = data.length < 30;
    // }
  }
}