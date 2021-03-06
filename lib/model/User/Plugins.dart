import 'package:mobi/model/Customers/Customers.dart';
import 'package:mobi/model/Office/OfficeData.dart';

import 'Modules.dart';
class FirstPlugin {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<Plugins> data;

  FirstPlugin(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  FirstPlugin.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<Plugins>();
      json['data'].forEach((v) {
        data.add(new Plugins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['exceptionInfo'] = this.exceptionInfo;
    data['pageSortSearch'] = this.pageSortSearch;
    data['hasError'] = this.hasError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Plugins {
  int pluginId;
  String pluginName;
  bool isActive;
  String iconUrl;
  List<OfficeData> officeList;
  List<CustomerData> customerList;
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

    if (json['officeList'] != null) {
      officeList = new List<OfficeData>();
      json['officeList'].forEach((v) {
        officeList.add(new OfficeData.fromJson(v));
      });
    }else{
      officeList=null;
    }

    if (json['customerList'] != null) {
      customerList = new List<CustomerData>();
      json['customerList'].forEach((v) {
        customerList.add(new CustomerData.fromJson(v));
      });
    }else{
      customerList=null;
    }
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