import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Shop/ShopItem.dart';

class ShopOrder {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<ShopOrderData> data;

  ShopOrder(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  ShopOrder.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<ShopOrderData>();
      json['data'].forEach((v) {
        data.add(new ShopOrderData.fromJson(v));
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

class ShopOrderData {
  int id;
  int previousOrderId;
  FamilyData family;
  ShopItemData familyShopItem;
  String createDate;
  String date;
  String dateString;
  int repeatId;
  int repeatType;
  int unit;
  int count;


  ShopOrderData(
      {this.id,
        this.previousOrderId,
        this.family,
        this.familyShopItem,
        this.createDate,
        this.dateString,
        this.date,
        this.repeatId,
        this.repeatType,
        this.unit,
        this.count});

  ShopOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    previousOrderId = json['previousOrderId'];
    family =
    json['family'] != null ? new FamilyData.fromJson(json['family']) : null;
    familyShopItem = json['familyShopItem'] != null
        ? new ShopItemData.fromJson(json['familyShopItem'])
        : null;
    createDate = json['createDate'];
    date = json['date'];
    repeatId = json['repeatId'];
    repeatType = json['repeatType'];
    dateString = json['dateString'];
    unit = json['unit'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['previousOrderId'] = this.previousOrderId;
    if (this.family != null) {
      data['family'] = this.family.toJson();
    }
    if (this.familyShopItem != null) {
      data['familyShopItem'] = this.familyShopItem.toJson();
    }
    data['createDate'] = this.createDate;
    data['date'] = this.date;
    data['dateString'] = this.dateString;
    data['repeatId'] = this.repeatId;
    data['repeatType'] = this.repeatType;
    data['unit'] = this.unit;
    data['count'] = this.count;
    return data;
  }
}


