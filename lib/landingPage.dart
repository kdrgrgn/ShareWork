import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Login/SignUpPage.dart';
import 'Controller/ControllerChange.dart';
import 'Controller/ControllerChat.dart';
import 'Controller/ControllerDB.dart';
import 'NotificationHandler.dart';

import 'Pages/Login/SignInPage.dart';
import 'Pages/Setup/OfficeSetup.dart';
import 'widgets/MyCircularProgress.dart';
import 'widgets/buildBottomNavigationBar.dart';

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
            return c.user.value.data.userType == 1 &&
                c.user.value.data.officeServiceId == 0
                ?OfficeSetup()
                : BuildBottomNavigationBar();
          }
      );
    });
  }
}
