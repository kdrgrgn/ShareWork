import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';

class ChatRoom extends StatefulWidget {
  final ChatListItem person;

  ChatRoom({this.person});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Color themeColor = Get.theme.accentColor;

  final List<ChatMessage> messages = [
    ChatMessage(
        date: "9:10 am", isSentByMe: true, message: "Bike Customer CFP Franc"),
    ChatMessage(
        date: "9:10 am",
        isSentByMe: true,
        message: "instruction set grey applications"),
    ChatMessage(date: "9:10 am", isSentByMe: false, message: "Monitored"),
    ChatMessage(date: "9:10 am", isSentByMe: true, message: "local"),
    ChatMessage(date: "9:10 am", isSentByMe: false, message: "Functionality"),
    ChatMessage(
        date: "9:10 am",
        isSentByMe: true,
        message:
            "Bike Customer CFP Franc jndslianfasdnfasngkjbsnd sdjnfso idhodighnsudg"),
    ChatMessage(date: "9:10 am", isSentByMe: true, message: "local"),
    ChatMessage(date: "9:10 am", isSentByMe: false, message: "Functionality"),
    ChatMessage(
        date: "9:10 am",
        isSentByMe: true,
        message: "instruction set grey applications"),
    ChatMessage(date: "9:10 am", isSentByMe: false, message: "Monitored"),
  ];

  Widget renderChatMessage(ChatMessage message) {
    return Column(
      children: <Widget>[
        ChatBubble(
          clipper: ChatBubbleClipper1(
              type: message.isSentByMe
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble),
          alignment:
              message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20),
          backGroundColor: message.isSentByMe ? themeColor : Colors.white,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message.message,
              style: TextStyle(
                  color: message.isSentByMe ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderTextBox() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: "Your Message Here",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.attach_file,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor: themeColor,
            onPressed: () {},
            child: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) => InkWell(
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(widget.person.profileURL),
                  ),
                ),
              ),
            ),
            Text(
              widget.person.personName,
              style: TextStyle(color: themeColor),
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: themeColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse:true ,
              itemCount: messages.length,
              itemBuilder: (ctx, i) => renderChatMessage(messages[i]),
            ),
          ),
          Divider(),
          Container(
            child: renderTextBox(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isSentByMe;
  final String date;

  ChatMessage({this.message, this.isSentByMe, this.date});
}

class ChatListItem {
  final String profileURL;
  final String personName;
  final String lastMessage;
  final String date;

  ChatListItem({this.profileURL, this.personName, this.lastMessage, this.date});
}
