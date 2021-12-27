import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/Provider/info.dart';
import '../../Controller/Retrofit/TGTAPI.dart';
import '../page/tgtcontentdetail.dart';

class TGTContentWidget extends StatefulWidget {
  final TGTlist;
  final index;
  const TGTContentWidget({Key? key, this.TGTlist, this.index})
      : super(key: key);

  @override
  _TGTContentWidgetState createState() => _TGTContentWidgetState();
}

class _TGTContentWidgetState extends State<TGTContentWidget> {
  @override
  void initState() {
    super.initState();
    print('hi tgtcontentwidget');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TGTContentDetail(index: widget.index),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.005,
              horizontal: MediaQuery.of(context).size.width * 0.015),
          height: MediaQuery.of(context).size.height * 0.22,
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.3,
                        color: Colors.white70,
                      ),
                      color: Colors.black,
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(10),
                      // ),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                      // child: Image.asset(
                      //   'images/415.PNG',
                      //   fit: BoxFit.fill,
                      // ),
                      child: Builder(builder: (context) {
                        if (widget.TGTlist is Oproduct) {
                          return Image.network(
                              "http://192.168.11.101:5000/image/${widget.TGTlist.id}");
                        } else {
                          return Image.network(
                              'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201912/13/ed91135f-1189-429d-ae2a-507664b03924.jpg');
                        }
                      }),
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
                                  child: Builder(builder: (context) {
                                    if (widget.TGTlist is Oproduct) {
                                      return Text(
                                        "${widget.TGTlist.title}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          height: 1,
                                          fontFamily: 'BalsamiqSans',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "test title",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          height: 1,
                                          fontFamily: 'BalsamiqSans',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                        ),
                                      );
                                    }
                                  }),
                                  // child: Text(
                                  //   "${widget.TGTlist.title}",
                                  //   maxLines: 1,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: TextStyle(
                                  //     height: 1,
                                  //     fontFamily: 'BalsamiqSans',
                                  //     color: Colors.black,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontStyle: FontStyle.normal,
                                  //     fontSize:
                                  //         MediaQuery.of(context).size.width * 0.045,
                                  //   ),
                                  // ),
                                ),
                              ),
                              const Expanded(
                                flex: 17,
                                child: SizedBox(
                                  width: 1, //의미x
                                ),
                              ),
                              Expanded(
                                flex: 23,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  alignment: Alignment.centerRight,
                                  height: double.infinity,
                                  child: Builder(builder: (context) {
                                    if (widget.TGTlist is Oproduct) {
                                      return Text(
                                        "${widget.TGTlist.place}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          height: 1,
                                          fontFamily: 'BalsamiqSans',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.normal,
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "locate",
                                        style: TextStyle(
                                          height: 1,
                                          fontFamily: 'BalsamiqSans',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.normal,
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                        ),
                                      );
                                    }
                                  }),
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
                            child: Builder(builder: (context) {
                              if (widget.TGTlist is Oproduct) {
                                return Text(
                                  "${widget.TGTlist.detail}",
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: 'BalsamiqSans',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                );
                              } else {
                                return Text(
                                  "test detail hahahoho",
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: 'BalsamiqSans',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                );
                              }
                            }),
                            // child: Text(
                            //   "${widget.TGTlist.detail}",
                            //   maxLines: 3,
                            //   overflow: TextOverflow.fade,
                            //   style: TextStyle(
                            //     height: 1.2,
                            //     fontFamily: 'BalsamiqSans',
                            //     color: Colors.black,
                            //     fontWeight: FontWeight.normal,
                            //     fontStyle: FontStyle.normal,
                            //     fontSize: MediaQuery.of(context).size.width * 0.04,
                            //   ),
                            // ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.02,
                                MediaQuery.of(context).size.width * 0.01,
                                0,
                                0),
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            child: Builder(builder: (context) {
                              if (widget.TGTlist is Oproduct) {
                                return Text(
                                  "${widget.TGTlist.nowuser}/${widget.TGTlist.inguser}",
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: 'BalsamiqSans',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                );
                              } else {
                                return Text(
                                  "1/4",
                                  style: TextStyle(
                                    height: 1.2,
                                    fontFamily: 'BalsamiqSans',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                );
                              }
                            }),
                            // child: Text(
                            //   "${widget.TGTlist.nowuser}/${widget.TGTlist.inguser}",
                            //   style: TextStyle(
                            //     height: 1.2,
                            //     fontFamily: 'BalsamiqSans',
                            //     color: Colors.black,
                            //     fontWeight: FontWeight.normal,
                            //     fontStyle: FontStyle.normal,
                            //     fontSize: MediaQuery.of(context).size.width * 0.035,
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
