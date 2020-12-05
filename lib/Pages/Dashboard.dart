import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mobi/widgets/plugin.dart';

import 'CareServicePage.dart';
import 'DebtPage.dart';
import 'HomePage.dart';
import 'LawyerPage.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Color themeColor;
  List<Widget> item;
  List<Widget> title;
  int initialPage = 0;
  TextStyle drawerStyle;
  List<Map<String, dynamic>> menuItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    item = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: HomePage(),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DebtPage(),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CareServicePage(),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: LawyerPage(),
      )
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeColor = Theme
          .of(context)
          .accentColor;

      drawerStyle = TextStyle(color: themeColor, fontSize: 15);
      titleBuilder();
    });

    getMenuItem();
  }

  void titleBuilder() {
    setState(() {
      title = [
        Builder(
          builder: (context) =>
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/images/logo/png txt/256h/Artboard 1.png",
                  fit: BoxFit.contain,
                  // height: 15,
                  // width: 34,
                ),
              ),
        ),
        Text("Debt", style: TextStyle(color: themeColor),
        ),
        Text("Care Service", style: TextStyle(color: themeColor),
        ),
        Text("Lawyer", style: TextStyle(color: themeColor),
        ),
      ];
    });

  }

  getMenuItem() {
    menuItems = [
      {
        'title': "Debt",
        'path': "assets/images/svg_png/debt office/gray/128h/Artboard 1.png",
      },
      {
        'title': "Care Service",
        'path': "assets/images/svg_png/care service/gray/128h/Artboard 1.png",
      },
      {
        'title': "Lawyer",
        'path': "assets/images/svg_png/rechsanwalt/gray/128h/Artboard 1.png",
      },
      {
        'title': "Project",
        'path':
        "assets/images/svg_png/project managment/gray/128h/Artboard 1.png",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            // heightFactor: 11.5,
            alignment: Alignment(0, 0.87),
            child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {},
                child: CircleAvatar(
                    backgroundColor: themeColor,
                    radius: 40,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 35,
                      color: Colors.white,
                    ))),
          ),
          initialPage == 0
              ? Align(
            // heightFactor: 11.5,
            alignment: Alignment(1, 0.7),
            child: FloatingActionButton(
              heroTag: "btn1",
              tooltip: "add-on",
              onPressed: () {},
              child: Tab(
                icon: Image.asset(
                  "assets/images/svg_png/add on/add on red/40.png",
                ),
              ),
            ),
          )
              : Container(),
        ],
      ),
      appBar: AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) =>
                  InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        "assets/images/svg_png/profile/red/128h/Artboard 1.png",
                        fit: BoxFit.contain,
                        // height: 15,
                        // width: 34,
                      ),
                    ),
                  ),
            ),
            title[initialPage],
            Icon(
              Icons.notifications_active_outlined,
              color: Colors.red,
            )
          ],
        ),
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "user name",
                                style: drawerStyle,
                              ),
                              Text(
                                "mail",
                                style: drawerStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add-on",
                            style: drawerStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyPlugin(
                        title: menuItems[0]['title'],
                        path: menuItems[0]['path']),
                    MyPlugin(
                        title: menuItems[1]['title'],
                        path: menuItems[1]['path']),
                    MyPlugin(
                        title: menuItems[2]['title'],
                        path: menuItems[2]['path']),
                    MyPlugin(
                        title: menuItems[3]['title'],
                        path: menuItems[3]['path']),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        color: themeColor,
                      ),
                      Text(
                        "Çıkıs",
                        style: drawerStyle,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            icon: Tab(
              icon: Image.asset(
                  "assets/images/svg_png/home/red/128h/Artboard 1.png"),
            ),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: Tab(
              icon: Image.asset(
                  "assets/images/svg_png/my cloud/my cloud red/128.png"),
            ),
            label: "My Cloud",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Container(),
            ),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Tab(
              icon: Image.asset(
                  "assets/images/svg_png/communication/red/128h/Artboard 1.png"),
            ),
            label: "Communication",
          ),
          BottomNavigationBarItem(
            icon: Tab(
              icon: Image.asset(
                  "assets/images/svg_png/search/search red/128.png"),
            ),
            label: "Arama",
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 180,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Carousel(
                autoplay: false,
                dotBgColor: Colors.transparent,
                dotColor: Colors.grey,
                dotIncreasedColor: themeColor,
                onImageChange: (pre, current) {
                  setState(() {
                    initialPage = current;
                  });
                },
                images: item,
              ))
        ],
      ),
    );
  }
}
