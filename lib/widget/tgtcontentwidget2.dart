import 'package:flutter/material.dart';

class tgtcontentwidget2 extends StatelessWidget {
  const tgtcontentwidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

