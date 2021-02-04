import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/Pages/Dashboard/Dashboard.dart';
import 'package:mobi/Pages/Login/SignUpPage.dart';
import 'package:mobi/Pages/MailPage.dart';

import 'Controller/ControllerChange.dart';
import 'Controller/ControllerChat.dart';
import 'Controller/ControllerDB.dart';
import 'NotificationHandler.dart';
import 'Pages/Dashboard/PluginListPage.dart';
import 'Pages/Family/Task/FamilyAddTaskPage.dart';
import 'Pages/Login/SignInPage.dart';
import 'widgets/MyCircularProgress.dart';
import 'widgets/buildBottomNavigationBar.dart';
import 'widgets/buildFamilyBottomNavigationBar.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  ControllerChat _controllerChat = Get.put(ControllerChat());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerChat.setContext(context);
      NotificationHandler().init();

    });

}

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerDB());
    Get.put(ControllerChange());

    return GetBuilder<ControllerDB>(builder: (c) {
      return c.isLoading.value == true
          ? Scaffold(
        body: MyCircular(),
      )
          : c.user.value == null
          ? c.isSignIn.value
          ? SignInPage()
          : SignUpPage()
          : GetBuilder<ControllerChange>(
          builder: (controllerChange) {
            return BuildBottomNavigationBar();
          }
      );
    });
  }
}
/*

class LoadPage extends StatefulWidget {
  @override
  _LoadPageState createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  List<Widget> _tabPage = [
    Dashboard(),
    MailPage(),
    CommunicationPage(),
    Container(
      child: Center(
        child: Text("Search"),
      ),
    )
  ];

*//*
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };
*//*


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerChange>(builder: (_controllerChange) {
      print("tabb scaff = " + _controllerChange.tabIndex.string);

      return Scaffold(
          body: _tabPage[_controllerChange.tabIndex.last],

          resizeToAvoidBottomPadding: false,
          extendBody: true,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _controllerChange.familyIsActive.value
              ? _controllerChange.initialPage.value !=
              _controllerChange.familyCount.value
              ? buildFabPlugin()
              : FloatingActionButton(
            onPressed: () {
              _controllerChange.updateSelectedDate(DateTime.now());
              Get.to(FamilyAddTaskPage());
            },
            child: Tab(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          )
              : buildFabPlugin(),
          bottomNavigationBar: _controllerChange.familyIsActive.value &&
              _controllerChange.familyCount.value ==
                  _controllerChange.initialPage.value
              ? FamilyBottomNavigationBar()
              : BuildBottomNavigationBar());
    });
  }

  FloatingActionButton buildFabPlugin() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(PluginListPage());
      },
      child: Tab(
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}*/
