import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Camera/CameraPage.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/widgets/ModuleWidget.dart';

class CameraList extends StatefulWidget {
  @override
  _CameraListState createState() => _CameraListState();
}

class _CameraListState extends State<CameraList> {
  final ControllerDB _controller = Get.put(ControllerDB());

  List<Plugins> plugins;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugins = _controller.user.value.data.plugins;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kamera listesi")),
      body: ListView.builder(
        itemCount: plugins.length,
        itemBuilder: (context, index) {
          return ModuleWidget(
              title: plugins[index].pluginName,
              path: plugins[index].iconUrl,
              page: CameraPage(),
              );
        },
      ),
    );
  }
}
