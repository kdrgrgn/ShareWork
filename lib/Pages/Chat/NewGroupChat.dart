import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Chat/ChatRoom.dart';
import 'package:mobi/model/User/UserData.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import 'NewChat.dart';

class NewGroupChat extends StatefulWidget {
  @override
  _NewGroupChatState createState() => _NewGroupChatState();
}

class _NewGroupChatState extends State<NewGroupChat> {
  Color themeColor = Get.theme.accentColor;
  bool isLoading = true;

  List<UserData> _userList = [];
  double width = 0;
  double height = 0;

  List<int> _selected = [];
  List<UserData> _selectedUser = [];

  ControllerChange _controllerChange = Get.put(ControllerChange());
  ControllerChat _controllerChat = Get.put(ControllerChat());
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
      floatingActionButton: _selected.length == 0
          ? Container()
          : FloatingActionButton(
        onPressed: () {
          _showTitleDiolog();
        },
        child: Tab(
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.white,

            size: 30,
          ),
        ),
      ), appBar: AppBar(
      title: Row(
        children: [
          InkWell(onTap: (){
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(
              builder: (context) => NewChat(),
            ));

          },child: Icon(Icons.arrow_back)),
          Text("  Grup Olustur"),
        ],
      ),
    ),
      body: isLoading
          ? MyCircular()
          : Column(
        children: [
          AnimatedContainer(
            width: width,
            height: height,

            duration: Duration(milliseconds: 400),

            child: ListView.builder(
              itemCount: _selectedUser.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              controller: ScrollController(keepScrollOffset: true),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 30,
                        backgroundImage: Image
                            .network(
                          _controllerChange.urlUsers +
                              _selectedUser[index].profilePhoto,
                        )
                            .image,
                      ),
                      Text(
                        _selectedUser[index].firstName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _userList.length,
              controller: ScrollController(keepScrollOffset: true),
              itemBuilder: (contex, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.2))),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        if (_selected.contains(_userList[index].id)) {
                          _selectedUser.remove(_userList[index]);
                          _selected.remove(_userList[index].id);
                          if (_selected.length == 0) {
                            width = 0;
                            height = 0;
                          }
                        } else {
                          _selectedUser.add(_userList[index]);

                          _selected.add(_userList[index].id);
                          width = Get.width;
                          height = 95;
                        }
                      });
                    },
                    title:
                    Text(_userList[index].firstName + " " +
                        _userList[index].lastName),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      backgroundImage: Image
                          .network(
                        _controllerChange.urlUsers +
                            _userList[index].profilePhoto,
                      )
                          .image,
                    ),
                    trailing: _selected.contains(_userList[index].id)
                        ? Icon(
                      Icons.check_box,
                      color: Colors.green,
                    )
                        : Icon(Icons.check_box_outline_blank),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTitleDiolog() {
    final _formKeyDiolog = GlobalKey<FormState>();
    String title;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              RaisedButton(
                color: Colors.green,
                child: Text("Tamam"),
                onPressed: () async {
                  if (_formKeyDiolog.currentState.validate()) {
                    _formKeyDiolog.currentState.save();

                   _controllerChat.insertGroupChat(
                        header: _controllerDB.headers(),
                        title: title,
                        ids: _selected).then((value) {
                    print("id = " +value.toString());

                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => ChatRoom(id: value,),
                    ));
                   });



                  }
                },
              )   ,           RaisedButton(
                color: Colors.red,
                child: Text("Vazgec"),
                onPressed: (){
                  Get.back(closeOverlays: true);
                },
              ),
            ],
            title: Text("Lutfen grup basligini giriniz"),
            content: Container(
                child: Form(
                  key: _formKeyDiolog,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "eksik";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      title = value;
                    },
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                )),
          );
        });
  }

/*List<Widget> buildList() {
    List<Widget> widgets;

    widgets = [];
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
        onTap: () {
          setState(() {

          if (_selected.contains(_userList[index].id)) {
            _selectedUser.remove(_userList[index]);
            _selected.remove(_userList[index].id);
            if(_selected.length==0){
              width=0;
              height=0;
            }
          } else {
            _selectedUser.add(_userList[index]);

            _selected.add(_userList[index].id);
            width=double.infinity;
            height=80;
          }
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
        trailing: _selected.contains(_userList[index].id)
            ? Icon(
                Icons.check_box,
                color: Colors.green,
              )
            : Icon(Icons.check_box_outline_blank),
      ),
    );
  }*/
}
