import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/PluginController.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class PluginListPage extends StatefulWidget {
  @override
  _PluginListPageState createState() => _PluginListPageState();
}

class _PluginListPageState extends State<PluginListPage> {
  final ControllerDB _controller = Get.put(ControllerDB());
  final PluginController _controllerPlugin = Get.put(PluginController());
  Color background = Get.theme.backgroundColor;
  Color themeColor = Get.theme.accentColor;
  ControllerChange _controllerChange = ControllerChange();

  List<int> myPlugins = [];
  List<Plugins> plugins = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _controller.user.value.data.plugins.forEach((element) {
        myPlugins.add(element.pluginId);
      });
      plugins = await _controllerPlugin.getpluginlist(_controller.headers());

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plugins"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Tab(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      //  bottomNavigationBar: BuildBottomNavigationBar(),
      body: isLoading
          ? MyCircular()
          : ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: true),
              itemCount: plugins.length,
              itemBuilder: (context, index) {
                Plugins _plugin = plugins[index];
                print("plugin = $index = " + _plugin.pluginName);
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: themeColor.withOpacity(0.05),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 40,
                                    height: 30,
                                    child: Image.network(_plugin.iconUrl==null?"":
                                      _controllerChange.baseUrl +
                                          _plugin.iconUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: themeColor.withOpacity(0.05),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _plugin.pluginName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(myPlugins.contains(_plugin.pluginId)){
                                        _controllerPlugin.deleteuserplugin(_controller.headers(), _plugin.pluginId);
                                        setState(() {
                                          myPlugins.remove(_plugin.pluginId);

                                        });
                                      }else{
                                        _controllerPlugin.adduserplugin(_controller.headers(), _plugin.pluginId);
                                        setState(() {
                                          myPlugins.add(_plugin.pluginId);

                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: themeColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          myPlugins.contains(_plugin.pluginId)
                                              ? "Uninstall"
                                              : "Install",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
