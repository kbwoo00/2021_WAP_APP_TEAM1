import 'package:flutter/foundation.dart';
import 'package:togetor/ui/tgtbutton.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:9000'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
            Row(
              children: <TGTButton>[
                TGTButton(
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("button add");
                  },
                ),
                TGTButton(
                  child: const Icon(
                    Icons.people,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print("button people");
                  },
                ),
                TGTButton(
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: _onPressedEvent,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onPressedEvent() {
    print('hihi');
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Togetor Demo',
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//       ),
//       home: ChangeNotifierProvider(
//         create: (BuildContext context) => TGTContentProvider(),
//         child: Home(),
//       ),
//     );
//   }
// }
