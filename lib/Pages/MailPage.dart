import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class MailPage extends StatefulWidget {
  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  Color themeColor = Get.theme.accentColor;


  List<MenuItem> _listMenu = [
    MenuItem(title: "Inbox",icon: Icons.inbox_outlined,number: "153"),
    MenuItem(title: "Draft",icon: Icons.drafts_outlined,number: "27"),
    MenuItem(title: "Archive",icon: Icons.archive_outlined),
    MenuItem(title: "Send",icon: Icons.send),
    MenuItem(title: "snoozed",icon: Icons.snooze_outlined),
    MenuItem(title: "Group",icon: Icons.group),
    MenuItem(title: "Junk E-Mail",icon: Icons.folder_open_rounded,number: "30"),
    MenuItem(title: "conversation history",icon: Icons.folder_sharp),
  ];

  List<Mail> _listmail = [
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message:
            "This is message sdfsdfs fsfsdfhsiufs dfusidfiushdfis fsodhifoisfoisdf oisdhfoisdjf sdfnsoidfdijfisdjf",
        isRead: false),
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message:
            "This is message sdfsdfs fsfsdfhsiufs dfusidfiushdfis fsodhifoisfoisdf oisdhfoisdjf sdfnsoidfdijfisdjf",
        isRead: true),
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message:
            "This is message sdfsdfs fsfsdfhsiufs dfusidfiushdfis fsodhifoisfoisdf oisdhfoisdjf sdfnsoidfdijfisdjf",
        isRead: false),
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message:
            "This is message sdfsdfs fsfsdfhsiufs dfusidfiushdfis fsodhifoisfoisdf oisdhfoisdjf sdfnsoidfdijfisdjf",
        isRead: true),
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message:
            "This is message sdfsdfs fsfsdfhsiufs dfusidfiushdfis fsodhifoisfoisdf oisdhfoisdjf sdfnsoidfdijfisdjf",
        isRead: false),
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message:
            "This is message sdfsdfs fsfsdfhsiufs dfusidfiushdfis fsodhifoisfoisdf oisdhfoisdjf sdfnsoidfdijfisdjf",
        isRead: false),
    Mail(
        title: "This is title",
        sender: "Kadir Gorgun",
        message: "This",
        isRead: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   /*   floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Tab(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
     // bottomNavigationBar: BuildBottomNavigationBar(),

      appBar: AppBar(
        backgroundColor: themeColor,
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              color:  Colors.white,
            ),
          ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Mail",),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: _listmail.length,
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 35, top: 5),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _listmail[index].sender,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: _listmail[index].isRead
                                            ? Colors.grey[500]
                                            : Colors.black),
                                  ),
                                  Text(_listmail[index].date),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    _listmail[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: _listmail[index].isRead
                                            ? Colors.grey[500]
                                            : Colors.black),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _listmail[index].message,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: _listmail[index].isRead
                                          ? Colors.grey[500]
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Drawer(
            child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Faircircle",
                  style: TextStyle(color: themeColor),
                ),
                subtitle: Text("a.kadirgrgn@gmail.com"),
                trailing: Icon(Icons.notifications_none_outlined),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Favourites",
                ),
                trailing: Icon(Icons.edit),
              ),
              ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Delete",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    leading: Icon(Icons.delete),
                  );
                },
              ),
              Divider(),

              ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemCount: _listMenu.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_listMenu[index].title,
                        style: TextStyle(color: Colors.grey[500])),
                    trailing: _listMenu[index].number==null?Container(
                      width: 1,
                    ):Container(
                      color: index==0?themeColor.withOpacity(0.8):Colors.grey[400],
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          _listMenu[index].number,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    leading: Icon(_listMenu[index].icon),
                  );
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class Mail {
  String title;
  String sender;
  String message;
  bool isRead;
  String date;

  Mail(
      {this.title, this.sender, this.message, this.isRead, this.date: "15:22"});
}

class MenuItem {
  String title;
  IconData icon;
  String number;

  MenuItem(
      {this.title,  this.icon, this.number});
}


