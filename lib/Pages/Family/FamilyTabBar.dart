
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/Budget/BudgetListPage.dart';
import 'package:mobi/Pages/Family/Gift/GiftList.dart';
import 'package:mobi/Pages/Family/Shop/ShopAddPage.dart';
import 'package:mobi/Pages/Family/Task/FamilyAddTaskPage.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import 'package:mobi/widgets/buildFamilyBottomNavigationBar.dart';

class FamilyTabBar extends StatefulWidget {

  int tabIndex;


  FamilyTabBar({this.tabIndex});

  @override
  _FamilyTabBarState createState() => _FamilyTabBarState();
}

class _FamilyTabBarState extends State<FamilyTabBar>   with SingleTickerProviderStateMixin {
  TabController _controller;

  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controllerDB = Get.put(ControllerDB());


  List<Widget> listTab = [
    Tab(icon: Text("Task")),
    Tab(icon: Text("Social")),
    Tab(icon: Text("Gift")),
    Tab(icon: Text("Budget")),
    Tab(icon: Text("Shop")),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=TabController(initialIndex: widget.tabIndex??0,length: listTab.length,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          Container(
            width: 30,
            height: 30,
            child: Image.network(
                "https://www.share-work.com/newsIcons/thumbnail_ikon_7_5.png"),
          ),
          SizedBox(width: 10,)
        ],

        bottom: TabBar(
          onTap: (index) {
            // Should not used it as it only called when tab options are clicked,
            // not when user swapped
          },
          controller: _controller,
          indicatorColor: background,
          labelColor: themeColor,
          tabs: listTab,
          isScrollable: true,

        ),
        title: Text("Family"),
      ),
      body:TabBarView(
        controller: _controller,
        children: [
          FamilyAddTaskPage(),
          Center(child: Text("Social"),),
          GiftList(),
          BudgetList(),
          ShopAddPage()

        ],
      ),
    );
  }
}
