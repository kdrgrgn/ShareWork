import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Customers/Customers.dart';
import 'package:mobi/model/User/Modules.dart';
import 'package:mobi/model/User/Plugins.dart';

import 'package:mobi/widgets/ModuleWidget.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class PluginPage extends StatefulWidget {
  Plugins plugin;

  PluginPage({this.plugin});

  @override
  _PluginPageState createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {
  ControllerDB _controllerDB = Get.put(ControllerDB());
  Customers _customers;
  bool isLoading = true;
  CustomerData _selectedCustomer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _customers = await _controllerDB.getCustomerList(
          headers: _controllerDB.headers(), pluginID: widget.plugin.pluginId);

      if(_customers.data.length!=0){
        _selectedCustomer = _customers.data[0];

      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : SingleChildScrollView(
            child: Column(
              children: [
                _customers.data.length == 0?Container():
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              width: 30,
                              height: 30,
                              child:
                                  Image.network(_selectedCustomer.profilePhoto)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(_selectedCustomer.firstName +
                              " " +
                              _selectedCustomer.lastName,overflow: TextOverflow.ellipsis,),
                        ),
                        Expanded(flex:1,child: Icon(Icons.search))
                      ],
                    ),
                  ),
                ),
                _customers.data.length == 0
                    ? Text("Customer yok")
                    : buildCirclePerson(),
                buildListView(),
              ],
            ),
          );
  }

  Widget buildListView() {
    List<Modules> _modules = widget.plugin.modules;
    return ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      itemCount: _modules.length,
      itemBuilder: (context, index) {
        return ModuleWidget(
            title: _modules[index].moduleName,
            path: _modules[index].iconUrl,
            notification: 0);
      },
    );
  }

  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: double.infinity,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _customers.data.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedCustomer = _customers.data[index];
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: Image.network(
                          _customers.data[0].profilePhoto)
                      .image,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
