import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';

enum TabItem { HomePage, MyCloud, Communication, Search, Profile }

class TabItemData {
  final Widget icon;
  final String label;
  static double size = 30.0;
  static double selectSize = 35.0;

  static ControllerChange _controllerChange = Get.put(ControllerChange());

  TabItemData({this.icon, this.label});

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.HomePage: TabItemData(
      icon: InkWell(
        onTap: () {
          _controllerChange.updateTabState(0);
        },
        child: Image.network(
          "https://www.share-work.com/newsIcons/thumbnail_ikon_5_7.png",
          height: size,
        ),
      ),
      label: "Home",
    ),
    TabItem.MyCloud: TabItemData(
      icon: InkWell(
        onTap: () {
          _controllerChange.updateTabState(1);
        },
        child: Image.network(
          "https://www.share-work.com//newsIcons/thumbnail_ikon_3_8.png",
          height: size,
        ),
      ),
      label: "Message",
    ),
    TabItem.Communication: TabItemData(
      icon: InkWell(
        onTap: () {
          _controllerChange.updateTabState(2);
        },
        child: Image.network(
          "https://www.share-work.com/newsIcons/thumbnail_ikon_3_10.png",
          height: size,
        ),
      ),
      label: "Communication",
    ),
    TabItem.Search: TabItemData(
      icon: InkWell(
        onTap: () {
          _controllerChange.updateTabState(3);
        },
        child: Image.network(
          "https://www.share-work.com/newsIcons/thumbnail_ikon_7_11.png",
          height: size,
        ),
      ),
      label: "Search",
    ),
  };
}

/*Tab iconlar
Home
https://www.share-work.com/newsIcons/thumbnail_ikon_5_7.png
message
https://www.share-work.com//newsIcons/thumbnail_ikon_3_8.png
comunication
https://www.share-work.com/newsIcons/thumbnail_ikon_3_10.png
search
https://www.share-work.com/newsIcons/thumbnail_ikon_7_11.png*/

/*
    Widget child ;
    if(tabItem == TabItem.HomePage)
      child = Dashboard();
    else if(tabItem == TabItem.MyCloud)
      child = FolderManager();
    else if(tabItem == TabItem.Scan)
      child = CameraList();
    else if(tabItem == TabItem.Communication)
      child = CommunicationPage();
    else if (tabItem == TabItem.Search) child = Container();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }*/
