import 'package:flutter/material.dart';

GlobalKey globalkey = GlobalKey();

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[600]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Assistant',
          style: TextStyle(color: Colors.grey[600]),
        ),
        centerTitle: true,
      ),
    );
  }
}
