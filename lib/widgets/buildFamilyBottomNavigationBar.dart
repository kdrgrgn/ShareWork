import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';

class BuilFamilyBottomNavigationBar extends StatelessWidget {
  Color themeColor = Get.theme.accentColor;

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
          children:[

            Image.network(
              "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_5.png",
              height: 30,
            ),
            Image.network(
              "https://www.share-work.com/newsIcons/thumbnail_ikon_3_7.png",
              height: 30,
            ),
            SizedBox(width: 10,),
            Image.network(
              "https://www.share-work.com/newsIcons/thumbnail_ikon_4_13.png",
              height: 30,
            ),  Image.network(
              "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_3.png",
              height: 30
            ),


          ]
        ),
      ),
    );/*BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.grey[600],
        items: familyBottomItems());*/
  }

  List<BottomNavigationBarItem> familyBottomItems() {
    return [
      BottomNavigationBarItem(
        icon: Tab(
          icon: Image.network(
            "https://www.share-work.com/newsIcons/thumbnail_ikon_7_8.png",
          ),
        ),
        label: "Anons",
      ),
      BottomNavigationBarItem(
        icon: Tab(
          icon: Image.network(
            "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_5.png",
            height: 36,
          ),
        ),
        label: "Social",
      ),
      BottomNavigationBarItem(
        icon: Tab(
          icon: Image.network(
            "https://www.share-work.com/newsIcons/thumbnail_ikon_3_7.png",
            height: 40,
          ),
        ),
        label: "Gift",
      ),
      BottomNavigationBarItem(
        icon: Tab(
          icon: Image.network(
            "https://www.share-work.com/newsIcons/thumbnail_ikon_4_13.png",
            height: 40,
          ),
        ),
        label: "Budget",
      ),
      BottomNavigationBarItem(
        icon: Tab(
          icon: Image.network(
            "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_3.png",
            height: 40,
          ),
        ),
        label: "Shop",
      ),
    ];
  }

/*


Family tab icon
Anons
https://www.share-work.com/newsIcons/thumbnail_ikon_7_8.png
social
https://www.share-work.com/newsIcons/thumbnail_ikon_7_16.png
gift
https://www.share-work.com/newsIcons/thumbnail_ikon_3_7.png
budget
https://www.share-work.com/newsIcons/thumbnail_ikon_4_13.png

shop
https://www.share-work.com/newsIcons/thumbnail_ikon_4_3.png
  */

}
