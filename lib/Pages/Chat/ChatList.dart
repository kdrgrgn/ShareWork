import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'MySharedPreferencesForChat.dart';
import 'NewChat.dart';
import 'package:mobi/model/Chat/Chat.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'ChatRoom.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Color themeColor = Get.theme.accentColor;
  bool isLoading = true;
  Chat _chat;
  List<String> count;

  ControllerChat _controllerChat = Get.put(ControllerChat());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  MySharedPreferencesForChat _countDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _countDB = MySharedPreferencesForChat.instance;


      _chat = await _controllerChat.getChatListWithoutMessages(
          header: _controllerDB.headers());
      count=List.filled(_chat.data.length,null,growable: true);
      int i=0;
      _chat.data.forEach((element) {
        count[i]=null;
        i++;
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => NewChat(),
          ));
        },
        heroTag: "hero",
        child: Tab(
          icon: Icon(
            Icons.message,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: isLoading
          ? MyCircular()
          : GetBuilder<ControllerChat>(
            builder: (_chatC) {
              return ListView.builder(
                  itemCount: _chatC.chatData.length,
                  itemBuilder: (context, index) {
                    _countDB.getCount(_chatC.chatData[index].id.toString()).then((value) {

                      if (value != null) {

                        setState(() {
                          count[index] = value.first;

                        });



                      } else {
                        setState(() {
                          count[index] = null;

                        });
                      }

                    });
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.2))),
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          _chatC.chatData[index].isGroup == 1
                              ? _chatC.chatData[index].title
                              : _chatC.chatData[index].userList.first.firstName +
                                  " " +
                              _chatC.chatData[index].userList.first.lastName,
                          style: TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          _chatC.chatData[index].messageList.first.message ?? "",
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Container(
                          child: Column(
                            children: [
                              Text(
                          _chatC.chatData[index].lastMessageDate.substring(11),
                                style: TextStyle(fontSize: 14),
                              ),
                              count[index] ==
                                      null
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Get.theme.backgroundColor,
                                      child: Text(
                                        count[index] ?? 0.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(_chatC.chatData[index]
                                  .groupPhoto
                                  .isEmpty
                              ? "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
                              : _chatC.chatData[index].groupPhoto),
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => ChatRoom(
                                        id: _chatC.chatData[index].id,
                                      )));
                        },
                      ),
                    );
                  });
            }
          ),
    );
  }

  String dateCut(String date) {
    date.substring(11);
  }
}
