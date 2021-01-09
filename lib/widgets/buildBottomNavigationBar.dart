import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Pages/Account.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/Pages/Dashboard/Dashboard.dart';
import 'package:mobi/Pages/MailPage.dart';
import 'package:mobi/widgets/FolderManager.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  List<Widget> _tabPage = [
    Dashboard(),
    CommunicationPage(),
    FolderManager(),
    AccountPage()
  ];

  static double size = 25.0;
  static double selectSize = 35.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerChange>(builder: (c) {
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
                    if (c.tabIndex.last == 0) {
                      c.removeTab();
                      Get.back();
                    } else {
                      c.updateTabState(0);
                      Get.to(_tabPage[0]);
                    }
                  },
                  child: Image.network(
                    "https://www.share-work.com/newsIcons/thumbnail_ikon_5_7.png",
                    height: c.tabIndex.last == 0 ? selectSize : size,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (c.tabIndex.last == 1) {
                      c.removeTab();

                      Get.back();
                    } else {
                      c.updateTabState(1);
                      Get.to(_tabPage[1]);
                    }
                  },
                  child: Image.network(
                    "https://www.share-work.com/newsIcons/thumbnail_ikon_3_8.png",
                    height: c.tabIndex.last == 1 ? selectSize : size,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if (c.tabIndex.last == 2) {
                      c.removeTab();

                      Get.back();
                    } else {
                      c.updateTabState(2);
                      Get.to(_tabPage[2]);
                    }
                  },
                  child: Image.network(
                    "https://share-work.com/newsIcons/thumbnail_ikon_5_2.png",
                    height: c.tabIndex.last == 2 ? selectSize : size,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (c.tabIndex.last == 3) {
                      c.removeTab();

                      Get.back();
                    } else {
                      c.updateTabState(3);
                      Get.to(_tabPage[3]);
                    }
                  },
                  child: Image.network(
                    "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_4.png",
                    height: c.tabIndex.last == 3 ? selectSize : size,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
