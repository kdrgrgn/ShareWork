import 'package:mobi/model/User/Plugins.dart';

abstract class PluginBase {
  Future<List<Plugins>> getpluginlist(Map<String, String> header);
  Future<Plugins> adduserplugin(Map<String, String> header,int pId);
  Future deleteuserplugin(Map<String, String> header ,int pId);
}
