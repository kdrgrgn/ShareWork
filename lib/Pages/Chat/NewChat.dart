import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/NotificationHandler.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/model/User/UserData.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import 'ChatRoom.dart';
import 'NewGroupChat.dart';

class NewChat extends StatefulWidget {
  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  Color themeColor = Get.theme.accentColor;
  bool isLoading = true;

  List<UserData> _userList = [];

  ControllerChat _controllerChat = Get.put(ControllerChat());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  ControllerDB _controllerDB = Get.put(ControllerDB());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _userList = await _controllerDB.getUserListExceptCurrent(
          header: _controllerDB.headers());

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CommunicationPage(),
                  ));
                },
                child: Icon(Icons.arrow_back)),
            Text("  Kullanıcı Seç"),
          ],
        ),
      ),
      body: isLoading
          ? MyCircular()
          : ListView(
              children: buildList(),
            ),
    );
  }

  List<Widget> buildList() {
    List<Widget> widgets;

    widgets = [
      InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NewGroupChat()));
        },
        child: Container(
          height: 80,
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))),
          child: Center(
            child: ListTile(
              title: Text("Grup Olustur"),
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                backgroundImage: Image.asset(
                  "assets/newsIcons/thumbnail_ikon_3_2.png",
                ).image,
              ),
              trailing: Icon(Icons.add_circle_outline_rounded),
            ),
          ),
        ),
      )
    ];
    int index = 0;
    for (UserData e in _userList) {
      widgets.add(buildPersonListTile(index));
      index++;
    }

    return widgets;
  }

  buildPersonListTile(int index) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.2))),
      child: ListTile(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          _controllerChat.insertChat(
              header: _controllerDB.headers(), id: _userList[index].id).then((value) {
                setState(() {
                  isLoading=false;
                });

            Navigator.of(context, rootNavigator: true)
                .pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => ChatRoom(
                  id: value,
                )));
          });



        },
        title:
            Text(_userList[index].firstName + " " + _userList[index].lastName),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          backgroundImage: Image.network(
            _controllerChange.urlUsers + _userList[index].profilePhoto,
          ).image,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
