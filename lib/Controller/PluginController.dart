


import 'package:get/get.dart';
import 'package:mobi/Services/Plugin/PluginBase.dart';
import 'package:mobi/Services/Plugin/PluginService.dart';
import 'package:mobi/model/User/Plugins.dart';

class PluginController extends GetxController implements PluginBase {

  PluginService _service = PluginService();

  @override
  Future<Plugins> adduserplugin(Map<String, String> header, int pId) {
return _service.adduserplugin(header, pId);
  }

  @override
  Future deleteuserplugin(Map<String, String> header, int pId) {
    return _service.deleteuserplugin(header, pId);
  }

  @override
  Future<List<Plugins>> getpluginlist(Map<String, String> header) {
    return _service.getpluginlist(header);
  }
}