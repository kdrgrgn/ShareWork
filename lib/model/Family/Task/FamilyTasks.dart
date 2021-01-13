import 'package:mobi/model/User/UserData.dart';

class FamilyTasks {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<FamilyTaskData> data;

  FamilyTasks(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  FamilyTasks.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<FamilyTaskData>();
      json['data'].forEach((v) {
        data.add(new FamilyTaskData.fromJson(v));
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

class FamilyTaskData {
  int id;
  String createDate;
  String date;
  String dateString;
  String description;
  String picture;
  String title;
  String category;
  int status;
  int points;
  int familyPersonTaskId;
  int repeatId;
  int repeatType;
  List<LikePersonList> likePersonList;



  FamilyTaskData(
      {this.id,
        this.createDate,
        this.date,
        this.dateString,
        this.description,
        this.picture,
        this.title,
        this.likePersonList,
        this.category,
        this.status,
        this.points,
        this.familyPersonTaskId,
        this.repeatId,
        this.repeatType});

  FamilyTaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    date = json['date'];
    dateString = json['dateString']??"";
    description = json['description'];
    picture = json['picture'];
    title = json['title'];
     if (json['likePersonList'] != null) {
      likePersonList = new List<LikePersonList>();
      json['likePersonList'].forEach((v) {
        likePersonList.add(new LikePersonList.fromJson(v));
      });
    }
    category = json['category'];
    status = json['status'];
    points = json['points'];
    familyPersonTaskId = json['familyPersonTaskId'];
    repeatId = json['repeatId'];
    repeatType = json['repeatType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['date'] = this.date;
    data['dateString'] = this.dateString;
    data['description'] = this.description;
    data['picture'] = this.picture;
    data['title'] = this.title;
    data['category'] = this.category;
    data['status'] = this.status;
    data['likePersonList'] = this.likePersonList;
    data['points'] = this.points;
    data['familyPersonTaskId'] = this.familyPersonTaskId;
    data['repeatId'] = this.repeatId;
    data['repeatType'] = this.repeatType;
    return data;
  }
}


class LikePersonList {
  int id;
  int familyId;
  int personType;
  int debt;
  int taskCount;
  UserData user;
  Null icon;
  int age;
  String createDate;
  Null ownedFamilyTaskList;

  LikePersonList(
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

  LikePersonList.fromJson(Map<String, dynamic> json) {
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
