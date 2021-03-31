import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';

class Services {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<ServiceData> data;

  Services(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Services.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<ServiceData>();
      json['data'].forEach((v) {
        data.add(new ServiceData.fromJson(v));
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

class ServiceData {
  int id;
  int createdUserId;
  String description;
  String title;
  List<Images> images;
  String modifiedDate;
  String createdDate;
  CscData service;
  CscData country;
  CscData city;
  CscData district;

  ServiceData(
      {this.id,
        this.createdUserId,
        this.description,
        this.title,
        this.images,
        this.modifiedDate,
        this.createdDate,
        this.service,
        this.country,
        this.city,
        this.district});

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdUserId = json['createdUserId'];
    description = json['description'];
    title = json['title'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    modifiedDate = json['modifiedDate'];
    createdDate = json['createdDate'];
    service =
    json['service'] != null ? new CscData.fromJson(json['service']) : null;
    country =
    json['country'] != null ? new CscData.fromJson(json['country']) : null;
    city = json['city'] != null ? new CscData.fromJson(json['city']) : null;
    district = json['district'] != null
        ? new CscData.fromJson(json['district'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdUserId'] = this.createdUserId;
    data['description'] = this.description;
    data['title'] = this.title;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['modifiedDate'] = this.modifiedDate;
    data['createdDate'] = this.createdDate;
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district.toJson();
    }
    return data;
  }


}

class Images {
  int id;
  int messageId;
  int ocrStatus;
  String fileName;
  Null path;
  Null thumbnailUrl;
  Null extension;
  int ocrResult;
  String ocrDate;
  int moduleType;
  int userId;
  int customerId;
  int todoId;
  int projectId;
  String createDate;
  Null ocrStatusText;
  Null folderName;
  int totalFileCount;

  Images(
      {this.id,
        this.messageId,
        this.ocrStatus,
        this.fileName,
        this.path,
        this.thumbnailUrl,
        this.extension,
        this.ocrResult,
        this.ocrDate,
        this.moduleType,
        this.userId,
        this.customerId,
        this.todoId,
        this.projectId,
        this.createDate,
        this.ocrStatusText,
        this.folderName,
        this.totalFileCount});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['messageId'];
    ocrStatus = json['ocrStatus'];
    fileName = json['fileName'];
    path = json['path'];
    thumbnailUrl = json['thumbnailUrl'];
    extension = json['extension'];
    ocrResult = json['ocrResult'];
    ocrDate = json['ocrDate'];
    moduleType = json['moduleType'];
    userId = json['userId'];
    customerId = json['customerId'];
    todoId = json['todoId'];
    projectId = json['projectId'];
    createDate = json['createDate'];
    ocrStatusText = json['ocrStatusText'];
    folderName = json['folderName'];
    totalFileCount = json['totalFileCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['messageId'] = this.messageId;
    data['ocrStatus'] = this.ocrStatus;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['extension'] = this.extension;
    data['ocrResult'] = this.ocrResult;
    data['ocrDate'] = this.ocrDate;
    data['moduleType'] = this.moduleType;
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['todoId'] = this.todoId;
    data['projectId'] = this.projectId;
    data['createDate'] = this.createDate;
    data['ocrStatusText'] = this.ocrStatusText;
    data['folderName'] = this.folderName;
    data['totalFileCount'] = this.totalFileCount;
    return data;
  }
}