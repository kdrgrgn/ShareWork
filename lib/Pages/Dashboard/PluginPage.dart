import 'package:flutter/material.dart';
import 'package:mobi/model/User/Modules.dart';
import 'package:mobi/model/User/Plugins.dart';

import 'package:mobi/widgets/ModuleWidget.dart';

class PluginPage extends StatefulWidget {
  Plugins plugin;

  PluginPage({this.plugin});

  @override
  _PluginPageState createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide()
                ),
              ),


              items: [
                DropdownMenuItem(
                  value: '0',
                  child: Text("User Test"),
                ),
                DropdownMenuItem(
                  value: '1',
                  child: Text("User Test1"),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text("User Test2"),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildListView() {
    List<Modules> _modules=widget.plugin.modules;
    return ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      itemCount: _modules.length,
      itemBuilder: (context, index) {
        return ModuleWidget(
          title: _modules[index].moduleName,
          path: _modules[index].iconUrl,
          notification: 0
        );
      },
    );
  }
}
