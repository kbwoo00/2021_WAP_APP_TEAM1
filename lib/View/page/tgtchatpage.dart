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
      IOWebSocketChannel.connect('ws://192.168.11.101:9000');
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 50.0);
  }

  void initState() {
    super.initState();
    print(widget.productID);
  }

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
                      border: const OutlineInputBorder(),
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
            // 메세지 오면
            if (snapshot.hasData) {
              // 첫 입장이라면 이전 채팅 불러와야함.
              if (isFirst) {
                var jsonData = convert.json.decode(snapshot.data.toString());
                print("hkkkkkkkkkkkkkkkkk");
                print(jsonData);
                if (jsonData["data"] != null) {
                  jsonData["data"]
                      .forEach((chat) => chatList.add(Chat.fromJson(chat)));
                }
                isFirst = false;
              } else {
                // 메세지 받음
                var jsonData = convert.json.decode(snapshot.data.toString());
                print(jsonData);
                var _message = jsonData["data"];
                var nowUserId = jsonData["name"];
                // String userId='';
                print('----------------------------');
                print(nowUserId);
                var type = jsonData["type"];
                if (type == "newPeople") {
                  var userId = jsonData["newChater"];
                  _message = "$userId님이 입장하였습니다.";
                } else if (type == "leavePeople") {
                  var userId = jsonData["leaveChater"];
                  _message = "${userId}님이 퇴장하였습니다.";
                }
                // 여기 firstinfo하고 leaveinfo는 name에 반환하는게 없어서
                // 퇴장할 때 json["name"]에 null값 받아서 에러나는건데
                // 일단 임시적으로 서버쪽에서 name도 넘기게 함

                // 지금 userid는 임시로 정하고 테스트한거 인지

                Chat nowChat = Chat(
                  participant: nowUserId, //nowUserId
                  chatting: _message,
                  chatTime: DateTime.now().toString(),
                );
                // 메세지 추가
                chatList.add(nowChat);
                // 제일 아래로 스크롤
                _scrollToBottom();
              }
            }
            return Scrollbar(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatList.length,
                itemBuilder: (BuildContext context, int index) {
                  var _flag = false;
                  if (_userId == chatList[index].participant) {
                    _flag = true;
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

  // 처음 입장인지
  void _firstMessage() {
    var data = {
      "type": "firstinfo",
      "userid": _userId,
      "productid": widget.productID,
    };
    var jsonData = convert.json.encode(data);
    _channel.sink.add(jsonData);
  }

  // 메세지 보내
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      var data = {
        "type": "message",
        "userid": _userId, //_userId
        "productid": widget.productID,
        "data": "${_controller.text}"
      };
      var jsonData = convert.json.encode(data);
      _channel.sink.add(jsonData);
    }
  }

  // void leave(){
  //   var data = {
  //     "type": "leaveinfo",
  //     "userid": _userId,
  //     "productid": widget.productID,
  //   };
  //   var jsonData = convert.json.encode(data);
  //   _channel.sink.add(jsonData);
  // }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

// ChatTile
class ChatTile extends StatelessWidget {
  final Chat chat;
  final bool userFlag;
  const ChatTile({Key? key, required this.chat, required this.userFlag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    TextAlign textAlign;

    // user 확인
    if (userFlag) {
      color = Color(0x7ff123456);
      textAlign = TextAlign.end;
    } else {
      color = Color(0x7f000000);
      textAlign = TextAlign.start;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: chat.participant,
                style: const TextStyle(
                  color: Colors.black,
                )),
            const TextSpan(text: "\n"),
            TextSpan(
              text: chat.chatting,
              style: const TextStyle(
                color: Color(0xff000000),
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: "\n"),
            TextSpan(
              text: chat.chatTime,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Chatting 정보 담을 클래스
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
        participant: "익명${parseJson['participant'][2]}",
        chatting: parseJson["chatting"],
        chatTime: parseJson["chattime"]);
  }
}
