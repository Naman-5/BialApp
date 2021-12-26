import 'package:flutter/material.dart';

GlobalKey globalkey = GlobalKey();

class TextMessageBox extends StatelessWidget {
  final String message;
  final bool isUserMsg;
  const TextMessageBox(
      {Key? key, required this.message, required this.isUserMsg})
      : super(key: key);

  BorderRadiusGeometry getBoxRadius() => isUserMsg
      ? const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20))
      : const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20));

  Color? getBoxColor() => isUserMsg ? Colors.indigo[200] : Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 5, right: 15, left: 8),
      constraints: const BoxConstraints(maxWidth: 270),
      child: Text(message),
      decoration: BoxDecoration(
        borderRadius: getBoxRadius(),
        color: getBoxColor(),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = [
    {'message': 'Hi!! How may I help you', 'isUsrMsg': false}
  ];
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  Widget getQueryRow(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [TextMessageBox(message: message, isUserMsg: true)],
    );
  }

  Widget getReplyRow(String message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/chatbot.png'),
          ),
        ),
        TextMessageBox(message: message, isUserMsg: false)
      ],
    );
  }

  void handleSubmitted(String message) {
    _textController.clear();
    setState(() {
      _messages.insert(0, {'message': message, 'isUsrMsg': true});
    });
    _focusNode.requestFocus();
  }

  Widget getTextInputField() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.fromLTRB(18, 15, 0, 15),
      child: Row(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: TextField(
              controller: _textController,
              onSubmitted: handleSubmitted,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Message'),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () => handleSubmitted(_textController.text),
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          shape: const CircleBorder(),
          color: Colors.indigo[300],
          child: const Icon(
            Icons.send_rounded,
            size: 30,
            color: Colors.white,
          ),
        )
      ]),
    );
  }

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
      body: Column(
        children: [
          Flexible(
            child: ListView(
              reverse: true,
              children: List.generate(
                  _messages.length,
                  (index) => _messages[index]['isUsrMsg'] == true
                      ? getQueryRow(_messages[index]['message'].toString())
                      : getReplyRow(_messages[index]['message'].toString())),
            ),
          ),
          getTextInputField()
        ],
      ),
    );
  }
}
