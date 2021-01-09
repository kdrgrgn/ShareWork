import '../FamilyPerson.dart';
import 'FamilyTasks.dart';
class RepeatTasks {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<RepeatTaskData> data;

  RepeatTasks(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  RepeatTasks.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<RepeatTaskData>();
      json['data'].forEach((v) {
        data.add(new RepeatTaskData.fromJson(v));
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

class RepeatTaskData {
  int id;
  FamilyPersonData familyPerson;
  FamilyTaskData familyTask;
  String date;
  int status;
  int points;
  Null dateString;
  String createDate;

  RepeatTaskData(
      {this.id,
        this.familyPerson,
        this.familyTask,
        this.date,
        this.status,
        this.points,
        this.dateString,
        this.createDate});

  RepeatTaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyPerson = json['familyPerson'] != null
        ? new FamilyPersonData.fromJson(json['familyPerson'])
        : null;
    familyTask = json['familyTask'] != null
        ? new FamilyTaskData.fromJson(json['familyTask'])
        : null;
    date = json['date'];
    status = json['status'];
    points = json['points'];
    dateString = json['dateString'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.familyPerson != null) {
      data['familyPerson'] = this.familyPerson.toJson();
    }
    if (this.familyTask != null) {
      data['familyTask'] = this.familyTask.toJson();
    }
    data['date'] = this.date;
    data['status'] = this.status;
    data['points'] = this.points;
    data['dateString'] = this.dateString;
    data['createDate'] = this.createDate;
    return data;
  }
}
