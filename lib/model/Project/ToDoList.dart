import 'package:mobi/model/Project/OutUserList.dart';
import 'package:mobi/model/Project/ProjectUsers.dart';

class TodosList {
  int id;
  int projectId;
  String title;
  String date;
  String description;
  int star;
  int important;
  String startDate;
  String endDate;
  int status;
  Null todoMessageList;
  List<ProjectUsers> users;
  List<OutUserList> outUsers;
  Null files;

  TodosList(
      {this.id,
        this.projectId,
        this.title,
        this.date,
        this.description,
        this.star,
        this.important,
        this.startDate,
        this.endDate,
        this.status,
        this.todoMessageList,
        this.users,
        this.outUsers,
        this.files});

  TodosList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['projectId'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
    star = json['star'];
    important = json['important'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    todoMessageList = json['todoMessageList'];
    if (json['users'] != null) {
      users = new List<ProjectUsers>();
      json['users'].forEach((v) {
        users.add(new ProjectUsers.fromJson(v));
      });
    }
    if (json['outUsers'] != null) {
      outUsers = new List<OutUserList>();
      json['outUsers'].forEach((v) {
        outUsers.add(new OutUserList.fromJson(v));
      });
    }
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectId'] = this.projectId;
    data['title'] = this.title;
    data['date'] = this.date;
    data['description'] = this.description;
    data['star'] = this.star;
    data['important'] = this.important;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['todoMessageList'] = this.todoMessageList;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    if (this.outUsers != null) {
      data['outUsers'] = this.outUsers.map((v) => v.toJson()).toList();
    }
    data['files'] = this.files;
    return data;
  }
}