import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CallsPage.dart';
import 'ChatList.dart';


class CommunicationPage extends StatefulWidget {

  Widget bottomNavBar;


  CommunicationPage({this.bottomNavBar});

  @override
  _CommunicationPageState createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  Color themeColor = Get.theme.accentColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // NotificationHandler().init(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    double orjWidth = MediaQuery.of(context).size.width;
    double cameraWidth = orjWidth/24;
    double yourWidth = (orjWidth - cameraWidth)/7;
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(


        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "ShareWork",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: themeColor,
          bottom: TabBar(
          isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal:(orjWidth - ( cameraWidth + yourWidth*3))/8),
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "STATUS",
              ),
              Tab(
                text: "CALLS",
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Container(child: Text(" Camera Page")),
            ChatList(),
            Container(child: Text(" story page")),
            CallsPage(),
          ],
        ),

      ),
    );
  }
}
