import 'package:flutter/material.dart';

enum TabItem { HomePage, MyCloud, Communication, Search,Profile }

class TabItemData {
  final Widget icon;
  final String label;
 static double size=32.0;

  TabItemData({this.icon, this.label});

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.HomePage: TabItemData(
      icon: Image.network(
        "https://www.share-work.com/newsIcons/thumbnail_ikon_5_7.png",
        height: size,
      ),
      label: "Home",
    ),
    TabItem.MyCloud: TabItemData(
      icon: Image.network(
        "https://www.share-work.com//newsIcons/thumbnail_ikon_3_8.png",
        height: size,
      ),
      label: "Message",
    ),

    TabItem.Communication: TabItemData(
      icon: Image.network(
        "https://www.share-work.com/newsIcons/thumbnail_ikon_3_10.png",
        height: size,
      ),
      label: "Communication",
    ),
    TabItem.Search: TabItemData(
      icon: Image.network(
        "https://www.share-work.com/newsIcons/thumbnail_ikon_7_11.png",
        height: size,
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
