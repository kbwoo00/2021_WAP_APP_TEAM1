import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text("프로필?"),
                decoration: BoxDecoration(color: Colors.blueGrey),
              ),
              ListTile(
                title: Text("마이페이지로 가기"),
                onTap: () {
                  //아래처럼 하면 사이드바가 사라지지 않은 상태에서 Mypage가 위에 덮어짐.
                  //사이드바가 사라지면서 이동할 수 있는 것도 찾아보기.
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyPage()));
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                title: Text("지도로 위치 찍기"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GoogleMap()));
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                title: Text("설정"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MyPage()));
                },
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          title: Text(
            "Togetor",
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
          actions: <Widget>[
            Container(
              child: IconButton(
                iconSize: 40,
                color: Colors.black,
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            )
          ]),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

List<bool> _buttonsState = List.generate(2, (index) => false);

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        title: Text(
          "마이페이지",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        leading: IconButton(
          iconSize: 30,
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: 60,
            alignment: Alignment.center,
            child: ToggleButtons(
              children: <Widget>[
                Container(
                    width: (MediaQuery.of(context).size.width - 36) / 2,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.production_quantity_limits,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        new SizedBox(
                          width: 4.0,
                        ),
                        new Text("내가 등록한",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                Container(
                    width: (MediaQuery.of(context).size.width - 36) / 2,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.production_quantity_limits_outlined,
                          size: 16.0,
                          color: Colors.yellow[800],
                        ),
                        new SizedBox(
                          width: 4.0,
                        ),
                        new Text("내가 참여중인",
                            style: TextStyle(
                                color: Colors.yellow[800],
                                fontSize: 15,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
              ],
              onPressed: (int index) => {
                setState(() {
                  _buttonsState[index] = !_buttonsState[index];
                })
              },
              isSelected: _buttonsState,
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleMap extends StatefulWidget {
  const GoogleMap({Key? key}) : super(key: key);

  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
