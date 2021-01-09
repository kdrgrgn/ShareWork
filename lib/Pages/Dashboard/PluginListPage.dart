import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/widgets/ModuleWidget.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class PluginListPage extends StatefulWidget {
  @override
  _PluginListPageState createState() => _PluginListPageState();
}

class _PluginListPageState extends State<PluginListPage> {

  final ControllerDB _controller = Get.put(ControllerDB());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plugins"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

floatingActionButton: FloatingActionButton(
  onPressed: () {

  },
  child: Tab(
    icon: Icon(
      Icons.add,
      color: Colors.white,
      size: 40,
    ),
  ),
),
      bottomNavigationBar: BuildBottomNavigationBar(),
      body:  ListView.builder(
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        itemCount: _controller.user.value.data.plugins.length,
        itemBuilder: (context, index) {
          Plugins _plugin =
          _controller.user.value.data.plugins[index];
          return ModuleWidget(
              title: _plugin.pluginName,
              path: _plugin.iconUrl);
        },
      ),

    );
  }
}
