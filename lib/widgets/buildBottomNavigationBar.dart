import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Account.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/Pages/Dashboard/Dashboard.dart';
import 'file:///G:/flutterProjects/mobi/lib/Pages/FileManager/FolderManager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../Pages/Chat/MySharedPreferencesForChat.dart';

class BuildBottomNavigationBar extends StatefulWidget {
  int page;

  BuildBottomNavigationBar({
    this.page,
  });

  static double size = 25.0;
  static double selectSize = 35.0;

  @override
  _BuildBottomNavigationBarState createState() =>
      _BuildBottomNavigationBarState();
}

class _BuildBottomNavigationBarState extends State<BuildBottomNavigationBar> {
  List<Widget> _tabPage = [
    Dashboard(
      page: 0,
    ),
    CommunicationPage(),
    FolderManager(),
    AccountPage()
  ];
  List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  PersistentTabController _controller;

  final ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChat _controllerChat = Get.put(ControllerChat());
  MySharedPreferencesForChat _countDB = MySharedPreferencesForChat.instance;
  String count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PersistentTabController(initialIndex: widget.page ?? 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controllerChat.setContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _countDB.getCount("chat").then((value) {
      if (value != null) {
        setState(() {
          count = value.first;
        });
      } else {
        setState(() {
          count = null;
        });
      }
    });
    return PersistentTabView(
      context,

      controller: _controller,
      screens: _tabPage,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      onItemSelected: (index) {},

      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      //routeAndNavigatorSettings: RouteAndNavigatorSettings(navigatorKeys:navigatorKeys),
      hideNavigationBar: false,
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }

  _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/newsIcons/thumbnail_ikon_5_7.png",
        ),
        title: ("Home"),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: [
            Image.asset(
              "assets/newsIcons/thumbnail_ikon_3_3.png",
            ),
            Align(
              alignment: Alignment.topLeft,
              child: count == null
                  ? Container()
                  : CircleAvatar(
                      radius: 6,
                      backgroundColor: Get.theme.backgroundColor,
                      child: Text(
                        count,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            )
          ],
        ),
        title: ("Message"),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/newsIcons/thumbnail_ikon_5_2.png",
        ),
        title: ("Cloud"),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: _controllerDB.user.value.data.profilePhoto == null
            ? Image.asset(
                "assets/newsIcons/thumbnail_ikonlar_ek_4.png",
              )
            : CircleAvatar(
                backgroundImage: Image.network(
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                        // _controllerDB.user.value.data.profilePhoto,

                        )
                    .image,
                radius: 12,
                backgroundColor: Colors.transparent,
              ),
        title: ("Account"),
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
      ),
    ];
  }
}
