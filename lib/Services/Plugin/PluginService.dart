

import 'dart:convert';
import 'dart:developer';

import 'package:mobi/Services/Plugin/PluginBase.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:http/http.dart' as http;

import '../ServiceUrl.dart';

class PluginService implements PluginBase{

  final ServiceUrl _serviceUrl = ServiceUrl();


  @override
  Future adduserplugin(Map<String, String> header, int pId) async {
    log( "reqqq add = " + jsonEncode({
      "pluginId": pId,
    }));
    var response = await http.post(_serviceUrl.addUserPlugin,
        headers: header,
        body: jsonEncode({
          "pluginId": pId,
        }));
    log("adduserplugin = " + response.body);


    //  final responseData = jsonDecode(response.body) as Map<String, dynamic>;

  }

  @override
  Future deleteuserplugin(Map<String, String> header, int pId) async {

    print("deleteuserplugin = " +_serviceUrl.deleteuserplugin+"?pId=$pId" );
    var response = await http.get(_serviceUrl.deleteuserplugin+"?pId=$pId",
      headers: header
      );

    log("deleteuserplugin = " + response.body);

 //   final responseData = jsonDecode(response.body) as Map<String, dynamic>;

  }

  @override
  Future<List<Plugins>> getpluginlist(Map<String, String> header) async {
    var response = await http.get(_serviceUrl.getPluginList,
        headers: header,);
    log("getpluginlist = " + response.body);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
   var a=FirstPlugin.fromJson(responseData);
print("uzunnlukk = " + a.data.length.toString());
    return a.data;

  }

}