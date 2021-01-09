import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Pages/Family/Budget/BudgetListPage.dart';
import 'package:mobi/Pages/Family/Gift/GiftList.dart';
import 'package:mobi/Pages/Family/Shop/ShopAddPage.dart';

/*
class FamilyBottomNavigationBar extends StatelessWidget {
  Color themeColor = Get.theme.accentColor;
  static double size = 30.0;
  static double selectSize = 40.0;

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerChange);

    return GetBuilder<ControllerChange>(builder: (c) {
      return WillPopScope(
        onWillPop: () async {
          c.removeFamilyTab();
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
                      if (c.familiyTabIndex.last == 1) {
                        // c.removeFamilyTab();
                        // Get.back();
                      } else {
                        //Get.to();
                      }
                    },
                    child: Image.network(
                      "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_5.png",
                      height: c.familiyTabIndex.last == 1 ? selectSize : size,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (c.familiyTabIndex.last == 2) {
                        // c.removeFamilyTab();
                        // Get.back();
                      } else {
                        Get.to(GiftList());
                      }
                    },
                    child: Image.network(
                      "https://www.share-work.com/newsIcons/thumbnail_ikon_3_7.png",
                      height: c.familiyTabIndex.last == 2 ? selectSize : size,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (c.familiyTabIndex.last == 2) {
                        // c.removeFamilyTab();
                        // Get.back();
                      } else {
                        Get.to(GiftList());
                      }
                    },
                    child: Image.network(
                      "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_8.png",
                      height: c.familiyTabIndex.last == 2 ? selectSize : size,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      if (c.familiyTabIndex.last == 3) {
                        // c.removeFamilyTab();
                        // Get.back();
                      } else {
                        //  c.updateFamily(3);
                        Get.to(BudgetList());
                      }
                    },
                    child: Image.network(
                      "https://share-work.com/newsIcons/thumbnail_ikon_4_2.png",
                      height: c.familiyTabIndex.last == 3 ? selectSize : size,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (c.familiyTabIndex.last == 4) {
                        // c.removeFamilyTab();
                        // Get.back();
                      } else {
                        Get.to(ShopAddPage());

                        //Get.to();
                      }
                    },
                    child: Image.network(
                      "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_3.png",
                      height: c.familiyTabIndex.last == 4 ? selectSize : size,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (c.familiyTabIndex.last == 4) {
                        // c.removeFamilyTab();
                        // Get.back();
                      } else {
                        Get.to(ShopAddPage());

                        //Get.to();
                      }
                    },
                    child: Image.network(
                      "https://www.share-work.com/newsIcons/thumbnail_ikon_7_8.png",
                      height: c.familiyTabIndex.last == 4 ? selectSize : size,
                    ),
                  ),
                ]),
          ),
        ),
      );
    });
  }
}
*/

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
