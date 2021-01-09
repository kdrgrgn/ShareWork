import 'package:mobi/model/User/UserData.dart';

class TaskMessage {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<MessageData> data;

  TaskMessage(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  TaskMessage.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<MessageData>();
      json['data'].forEach((v) {
        data.add(new MessageData.fromJson(v));
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

class MessageData {
  int id;
  Person person;
  Null personTask;
  String message;
  String createDate;

  MessageData({this.id, this.person, this.personTask, this.message, this.createDate});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
    personTask = json['personTask'];
    message = json['message'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    data['personTask'] = this.personTask;
    data['message'] = this.message;
    data['createDate'] = this.createDate;
    return data;
  }
}

class Person {
  int id;
  int familyId;
  int personType;
  int debt;
  int taskCount;
  UserData user;
  String icon;
  int age;
  String createDate;
  Null ownedFamilyTaskList;

  Person(
      {this.id,
        this.familyId,
        this.personType,
        this.debt,
        this.taskCount,
        this.user,
        this.icon,
        this.age,
        this.createDate,
        this.ownedFamilyTaskList});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    personType = json['personType'];
    debt = json['debt'];
    taskCount = json['taskCount'];
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
    icon = json['icon'];
    age = json['age'];
    createDate = json['createDate'];
    ownedFamilyTaskList = json['ownedFamilyTaskList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyId'] = this.familyId;
    data['personType'] = this.personType;
    data['debt'] = this.debt;
    data['taskCount'] = this.taskCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['icon'] = this.icon;
    data['age'] = this.age;
    data['createDate'] = this.createDate;
    data['ownedFamilyTaskList'] = this.ownedFamilyTaskList;
    return data;
  }
}

