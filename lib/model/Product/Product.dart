import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/User/UserData.dart';

class Product {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<ProductData> data;

  Product(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Product.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<ProductData>();
      json['data'].forEach((v) {
        data.add(new ProductData.fromJson(v));
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

class ProductData {
  int id;
  int price;
  String createDate;
  CscData category;
  UserData user;
  List<Images> images;
  List<UploadImages> uploadImages;
  String title;
  String description;
  CscData country;
  CscData city;
  CscData district;
  int isDeleted;

  ProductData(
      {this.id,
        this.price,
        this.createDate,
        this.category,
        this.user,
        this.images,
        this.title,
        this.description,
        this.country,
        this.city,
        this.district,
        this.isDeleted});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    createDate = json['createDate'];
    category = json['category'] != null
        ? new CscData.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) { images.add(new Images.fromJson(v)); });
    }
    if (json['uploadImages'] != null) {
      uploadImages = new List<UploadImages>();
      json['uploadImages'].forEach((v) { uploadImages.add(new UploadImages.fromJson(v)); });
    }
    title = json['title'];
    description = json['description'];
    country =
    json['country'] != null ? new CscData.fromJson(json['country']) : null;
    city = json['city'] != null ? new CscData.fromJson(json['city']) : null;
    district = json['district'] != null
        ? new CscData.fromJson(json['district'])
        : null;

    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.id!=null) {
      data['id'] = this.id;
    }

    data['price'] = this.price;
    if(this.createDate!=null) {
      data['createDate'] = this.createDate;
    }

    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.uploadImages != null) {
      data['uploadImages'] = this.uploadImages.map((v) => v.toJson()).toList();
    }

    data['title'] = this.title;
    data['description'] = this.description;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district.toJson();
    }
    if(this.isDeleted!=null) {
      data['isDeleted'] = this.isDeleted;
    }
    return data;
  }
}


class Images {
  int id;
  int messageId;
  int ocrStatus;
  String fileName;
  String path;
  String thumbnailUrl;
  String extension;
  int ocrResult;
  String ocrDate;
  int moduleType;
  int userId;
  int customerId;
  int todoId;
  int projectId;
  String createDate;
  String ocrStatusText;
  String folderName;
  int totalFileCount;

  Images({this.id, this.messageId, this.ocrStatus, this.fileName, this.path, this.thumbnailUrl, this.extension, this.ocrResult, this.ocrDate, this.moduleType, this.userId, this.customerId, this.todoId, this.projectId, this.createDate, this.ocrStatusText, this.folderName, this.totalFileCount});

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

class UploadImages {
  String fileName;
  String directory;
  String fileContent;
  List<int> imageByteArray;

  UploadImages({this.fileName, this.directory, this.fileContent, this.imageByteArray});

  UploadImages.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    directory = json['directory'];
    fileContent = json['fileContent'];
    imageByteArray = json['imageByteArray'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['directory'] = this.directory;
    data['fileContent'] = this.fileContent;
    data['imageByteArray'] = this.imageByteArray;
    return data;
  }
}