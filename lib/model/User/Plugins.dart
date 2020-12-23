import 'Modules.dart';

class Plugins {
  int pluginId;
  String pluginName;
  bool isActive;
  String iconUrl;
  Null officeList;
  Null customerList;
  List<Modules> modules;

  Plugins(
      {this.pluginId,
        this.pluginName,
        this.isActive,
        this.iconUrl,
        this.officeList,
        this.customerList,
        this.modules});

  Plugins.fromJson(Map<String, dynamic> json) {
    pluginId = json['pluginId'];
    pluginName = json['pluginName'];
    isActive = json['isActive'];
    iconUrl = json['iconUrl'];
    officeList = json['officeList'];
    customerList = json['customerList'];
    if (json['modules'] != null) {
      modules = new List<Modules>();
      json['modules'].forEach((v) {
        modules.add(new Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pluginId'] = this.pluginId;
    data['pluginName'] = this.pluginName;
    data['isActive'] = this.isActive;
    data['iconUrl'] = this.iconUrl;
    data['officeList'] = this.officeList;
    data['customerList'] = this.customerList;
    if (this.modules != null) {
      data['modules'] = this.modules.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Plugins{pluginId: $pluginId, pluginName: $pluginName, isActive: $isActive, iconUrl: $iconUrl, officeList: $officeList, customerList: $customerList, modules: $modules}';
  }
}