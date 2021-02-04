import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Account.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/Pages/Dashboard/Dashboard.dart';
import 'package:mobi/Pages/MailPage.dart';
import 'package:mobi/widgets/FolderManager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../NotificationHandler.dart';

class BuildBottomNavigationBar extends StatefulWidget {
  int page;

  BuildBottomNavigationBar({this.page,});

  static double size = 25.0;
  static double selectSize = 35.0;

  @override
  _BuildBottomNavigationBarState createState() => _BuildBottomNavigationBarState();
}

class _BuildBottomNavigationBarState extends State<BuildBottomNavigationBar> {
  List<Widget> _tabPage = [
    Dashboard(page: 0,),
    CommunicationPage(),
    FolderManager(),
    AccountPage()
  ];
  List<GlobalKey<NavigatorState>> navigatorKeys=[
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];


  PersistentTabController _controller ;

  final ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChat _controllerChat = Get.put(ControllerChat());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller= PersistentTabController(initialIndex: widget.page??0);
    WidgetsBinding.instance.addPostFrameCallback((_) {


      _controllerChat.setContext(context);


    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,

        controller: _controller,
        screens: _tabPage,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        onItemSelected: (index){

        },

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
        hideNavigationBar:false ,
        navBarStyle:
        NavBarStyle.style9, // Choose the nav bar style with this property.

    );
    /*GetBuilder<ControllerChange>(builder: (c) {
      return WillPopScope(
        onWillPop: () async {
          c.removeTab();
          return true;
        },
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          color: Colors.white,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    if (c.tabIndexList.last == 0) {
                      c.removeTab();
                      Get.back();
                    } else {
                      c.updateTabState(0);
                      Get.to(_tabPage[0]);
                    }
                  },
                  child: Image.network(
                    "https://www.share-work.com/newsIcons/thumbnail_ikon_5_7.png",
                    height: c.tabIndex.value == 0 ? selectSize : size,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (c.tabIndexList.last == 1) {
                      c.removeTab();

                      Get.back();
                    } else {
                      c.updateTabState(1);
                      Get.to(_tabPage[1]);
                    }
                  },
                  child: Image.network(
                    "https://share-work.com/newsIcons/thumbnail_ikon_3_3.png",
                    height: c.tabIndex.value == 1 ? selectSize : size,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if (c.tabIndexList.last == 2) {
                      c.removeTab();

                      Get.back();
                    } else {
                      c.updateTabState(2);
                      Get.to(_tabPage[2]);
                    }
                  },
                  child: Image.network(
                    "https://share-work.com/newsIcons/thumbnail_ikon_5_2.png",
                    height: c.tabIndex.value == 2 ? selectSize : size,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (c.tabIndexList.last == 3) {
                      c.removeTab();

                      Get.back();
                    } else {
                      c.updateTabState(3);
                      Get.to(_tabPage[3]);
                    }
                  },
                  child: _controller.user.value.data.profilePhoto == null?Image.network(
                         "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_4.png",
                    height: c.tabIndex.value == 3 ? selectSize : size,
                  ):CircleAvatar(
                    backgroundImage:Image.network(
                      _controller.user.value.data.profilePhoto,
                    ).image ,
                    radius: c.tabIndex.value == 3 ? 15 : 12,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });*/
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
        icon: Image.asset(
            "assets/newsIcons/thumbnail_ikon_3_3.png",
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
        icon: _controllerDB.user.value.data.profilePhoto == null ? Image
            .asset(
          "assets/newsIcons/thumbnail_ikonlar_ek_4.png",
        ) : CircleAvatar(
          backgroundImage: Image
              .network(
            _controllerDB.user.value.data.profilePhoto,

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
