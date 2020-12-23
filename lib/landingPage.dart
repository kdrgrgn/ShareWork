import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Dashboard/Dashboard.dart';

import 'Controller/ControllerDB.dart';
import 'Pages/Login/SignInPage.dart';
import 'widgets/MyCircularProgress.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Get.put(ControllerDB());


    return GetBuilder<ControllerDB>(builder: (c) {
      return c.isLoading.value == true
          ? Scaffold(

        body: MyCircular(),
      ) : c.user.value == null ? SignInPage()
          : Dashboard();
    });
  }
}
