

import 'package:flutter/material.dart';

import 'TabItemData.dart';

class BuildBottomNavigationBar extends StatelessWidget {


  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.HomePage: GlobalKey<NavigatorState>(),
    TabItem.MyCloud: GlobalKey<NavigatorState>(),
    TabItem.Communication: GlobalKey<NavigatorState>(),
    TabItem.Search: GlobalKey<NavigatorState>(),

  };





  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 12,
      color: Colors.white,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItemOlustur(TabItem.HomePage),
            _navItemOlustur(TabItem.MyCloud),
            SizedBox(width: 10,),
            _navItemOlustur(TabItem.Communication),
            _navItemOlustur(TabItem.Search),
          ],
        ),
      ),
    );


    /*BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 15,

        unselectedFontSize: 15,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.grey[600],
        items:
            [
          _navItemOlustur(TabItem.HomePage),
          _navItemOlustur(TabItem.MyCloud),
          _navItemOlustur(TabItem.Communication),
          _navItemOlustur(TabItem.Search),

            ]
    );*/

  }

  Widget _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];

    return olusturulacakTab.icon;
  }
}
