import 'package:flutter/material.dart';
import 'package:hi_flt/TGTAPI.dart';

class TGTContentWidget extends StatefulWidget {
  final TGTlist;
  final test;
  const TGTContentWidget({Key? key, this.TGTlist, this.test}) : super(key: key);

  @override
  _TGTContentWidgetState createState() => _TGTContentWidgetState();
}

class _TGTContentWidgetState extends State<TGTContentWidget> {
  @override
  void initState() {
    super.initState();
    print('hi');
    //print(widget.testlist.length);
    print("${widget.test}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.005,
          horizontal: MediaQuery.of(context).size.width * 0.015),
      height: MediaQuery.of(context).size.height * 0.22,
      //width: MediaQuery.of(context).size.width * 0.1 , //width안먹힘 margin으로 컨트롤하자
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    child: Image.network(
                        "http://10.0.2.2:5000/image/${widget.TGTlist.id}"
                    ),
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
                              child: Text(
                                "${widget.TGTlist.title}",
                                maxLines:1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1,
                                  fontFamily: 'BalsamiqSans',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                ),
                              ),
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
                              child: Text(
                                "locate",
                                style: TextStyle(
                                  height: 1,
                                  fontFamily: 'BalsamiqSans',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
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
                        child: Text(
                          "${widget.TGTlist.detail}",
                          maxLines:3,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            height: 1.2,
                            fontFamily: 'BalsamiqSans',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
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
                        child: Text(
                          "${widget.TGTlist.nowuser}/${widget.TGTlist.inguser}",
                          style: TextStyle(
                            height: 1.2,
                            fontFamily: 'BalsamiqSans',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
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
    );
  }
}
