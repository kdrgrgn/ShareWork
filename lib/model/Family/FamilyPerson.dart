import 'package:mobi/model/User/UserData.dart';

import 'FamilyTasks.dart';

class FamilyPerson {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  Data data;

  FamilyPerson(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  FamilyPerson.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['exceptionInfo'] = this.exceptionInfo;
    data['pageSortSearch'] = this.pageSortSearch;
    data['hasError'] = this.hasError;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int familyId;
  int personType;
  UserData user;
  String icon;
  int age;
  String createDate;
  List<FamilyTaskData> ownedFamilyTaskList;

  Data(
      {this.id,
        this.familyId,
        this.personType,
        this.user,
        this.icon,
        this.age,
        this.createDate,
        this.ownedFamilyTaskList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    personType = json['personType'];
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
    icon = json['icon'];
    age = json['age'];
    createDate = json['createDate'];
    if (json['ownedFamilyTaskList'] != null) {
      ownedFamilyTaskList = new List<FamilyTaskData>();
      json['ownedFamilyTaskList'].forEach((v) {
        ownedFamilyTaskList.add(new FamilyTaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyId'] = this.familyId;
    data['personType'] = this.personType;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['icon'] = this.icon;
    data['age'] = this.age;
    data['createDate'] = this.createDate;
    if (this.ownedFamilyTaskList != null) {
      data['ownedFamilyTaskList'] =
          this.ownedFamilyTaskList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


