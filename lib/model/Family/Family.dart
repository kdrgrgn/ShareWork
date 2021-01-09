import 'package:mobi/model/User/UserData.dart';

import 'Task/FamilyTasks.dart';

class Family {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  FamilyData data;

  Family(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Family.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    data = json['data'] != null ? new FamilyData.fromJson(json['data']) : null;
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

  @override
  String toString() {
    return 'Family{statusCode: $statusCode, exceptionInfo: $exceptionInfo, pageSortSearch: $pageSortSearch, hasError: $hasError, data: $data}';
  }
}

class FamilyData {
  int id;
  int chatId;
  String createDate;
  String picture;
  String title;
  List<PersonList> personList;
  List<FamilyTaskData> availableTaskList;
  List<FamilyTaskData> allTaskList;

  FamilyData(
      {this.id,
        this.chatId,
        this.createDate,
        this.picture,
        this.title,
        this.personList,
        this.availableTaskList,
        this.allTaskList});

  FamilyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chatId'];
    createDate = json['createDate'];
    picture = json['picture'];
    title = json['title'];
    if (json['personList'] != null) {
      personList = new List<PersonList>();
      json['personList'].forEach((v) {
        personList.add(new PersonList.fromJson(v));
      });
    }
    if (json['availableTaskList'] != null) {
      availableTaskList = new List<FamilyTaskData>();
      json['availableTaskList'].forEach((v) {
        availableTaskList.add(new FamilyTaskData.fromJson(v));
      });
    }
    if (json['allTaskList'] != null) {
      allTaskList = new List<FamilyTaskData>();
      json['allTaskList'].forEach((v) {
        allTaskList.add(new FamilyTaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    data['createDate'] = this.createDate;
    data['picture'] = this.picture;
    data['title'] = this.title;
    if (this.personList != null) {
      data['personList'] = this.personList.map((v) => v.toJson()).toList();
    }
    if (this.availableTaskList != null) {
      data['availableTaskList'] =
          this.availableTaskList.map((v) => v.toJson()).toList();
    }
    if (this.allTaskList != null) {
      data['allTaskList'] = this.allTaskList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{id: $id, chatId: $chatId, createDate: $createDate, picture: $picture, title: $title, personList: $personList, availableTaskList: $availableTaskList, allTaskList: $allTaskList}';
  }
}

class PersonList {
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

  PersonList(
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

  PersonList.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'PersonList{id: $id, familyId: $familyId, personType: $personType, debt: $debt, taskCount: $taskCount, user: $user, icon: $icon, age: $age, createDate: $createDate, ownedFamilyTaskList: $ownedFamilyTaskList}';
  }
}

