import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togetor/View/ui/tgt_side_bar.dart';
import 'package:togetor/View/ui/tgtbutton.dart';
import 'package:togetor/View/ui/tgttop_bar.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert' as convert;

class TGTChatPage extends StatefulWidget {
  final int productID;
  const TGTChatPage({Key? key, required this.productID}) : super(key: key);

  @override
  _TGTChatPageState createState() => _TGTChatPageState();
}

class _TGTChatPageState extends State<TGTChatPage> {
  final TextEditingController _controller = TextEditingController();
  bool isFirst = true;
  late List<Chat> chatList = [];
  final key3 = const Key('key3');
  final _userId = "user";
  final WebSocketChannel _channel =
      IOWebSocketChannel.connect('ws://localhost:9000');
  final String _title = "Chat Chat";
  @override
  Widget build(BuildContext context) {
    _firstMessage();
    return Scaffold(
      key: key3,
      endDrawer: const TGTSideBar(),
      appBar: TGTtop_bar(appBar: AppBar(), title: "채팅 페이지", key: key3),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _streamBuilder(),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.message_sharp,
                      ),
                      suffix: TGTButton(
                        width: 20.0,
                        height: 20.0,
                        color: const Color(0x00ffffff),
                        child: const Icon(
                          Icons.send,
                          color: Color(0xff18A0FB),
                        ),
                        onPressed: () {
                          _sendMessage();
                        },
                      ),
                    ),
                    controller: _controller,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Flexible _streamBuilder() {
    return Flexible(
        fit: FlexFit.tight,
        child: StreamBuilder(
          stream: _channel.stream,
          builder: (context, snapshot) {
            if (isFirst) {
              var jsonData = convert.json.decode(snapshot.data.toString());
              jsonData["data"]
                  .forEach((chat) => chatList.add(Chat.fromJson(chat)));
              isFirst = false;
            } else {
              String _message = "";
              if (snapshot.data != null) {
                var jsonData = convert.json.decode(snapshot.data.toString());
                _message = jsonData["data"];
                var type = jsonData["type"];
                if (type == "newPeople") {
                  var newChater = jsonData["newChater"];
                  _message = "$newChater님이 입장하였습니다.";
                }
                Chat nowChat = Chat(
                  participant: _userId,
                  chatting: _message,
                  chatTime: DateTime.now().toString(),
                );
                print(_message);
                chatList.add(nowChat);
              }
            }
            return Scrollbar(
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  var _flag = "N";
                  if (_userId == chatList[index].participant) {
                    _flag = "T";
                  } else {
                    _flag = "F";
                  }
                  return ChatTile(
                    chat: chatList[index],
                    userFlag: _flag,
                  );
                },
              ),
            );
          },
        ));
  }

  void _firstMessage() {
    var data = {
      "type": "firstinfo",
      "userid": _userId,
      "productid": widget.productID,
    };
    var jsonData = convert.json.encode(data);
    _channel.sink.add(jsonData);
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      var data = {
        "type": "message",
        "userid": _userId,
        "productid": widget.productID,
        "data": "${_controller.text}"
      };
      var jsonData = convert.json.encode(data);
      _channel.sink.add(jsonData);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

class ChatTile extends StatelessWidget {
  final Chat chat;
  final String userFlag;
  const ChatTile({Key? key, required this.chat, required this.userFlag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    TextAlign textAlign;

    String flag = chat.chatting.substring(chat.chatting.length - 1);
    if (userFlag == "T") {
      color = Color(0x7fffffff);
      textAlign = TextAlign.end;
    } else if (userFlag == "F") {
      color = Color(0x7fffffff);
      textAlign = TextAlign.start;
    } else {
      color = Color(0xf0c7c7c7);
      textAlign = TextAlign.center;
    }
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          chat.chatting,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            background: Paint()..color = color,
          ),
        ),
      ),
    );
  }
}

class Chat {
  String participant;
  String chatting;
  String chatTime;

  Chat(
      {required this.participant,
      required this.chatting,
      required this.chatTime});

  factory Chat.fromJson(Map<String, dynamic> parseJson) {
    return Chat(
        participant: parseJson["participant"],
        chatting: parseJson["chatting"],
        chatTime: parseJson["chattime"]);
  }
}
