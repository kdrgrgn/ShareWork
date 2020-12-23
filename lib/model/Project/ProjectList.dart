import 'OutUserList.dart';
import 'ProjectUsers.dart';
import 'ToDoList.dart';

class ProjectList {
  int id;
  int userId;
  String title;
  String description;
  bool status;
  List<TodosList> todosList;
  List<ProjectUsers> usersList;
  List<OutUserList> outUserList;
  Null files;

  ProjectList(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.status,
        this.todosList,
        this.usersList,
        this.outUserList,
        this.files});

  ProjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    if (json['todosList'] != null) {
      todosList = new List<TodosList>();
      json['todosList'].forEach((v) {
        todosList.add(new TodosList.fromJson(v));
      });
    }
    if (json['usersList'] != null) {
      usersList = new List<ProjectUsers>();
      json['usersList'].forEach((v) {
        usersList.add(new ProjectUsers.fromJson(v));
      });
    }
    if (json['outUserList'] != null) {
      outUserList = new List<OutUserList>();
      json['outUserList'].forEach((v) {
        outUserList.add(new OutUserList.fromJson(v));
      });
    }
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.todosList != null) {
      data['todosList'] = this.todosList.map((v) => v.toJson()).toList();
    }
    if (this.usersList != null) {
      data['usersList'] = this.usersList.map((v) => v.toJson()).toList();
    }
    if (this.outUserList != null) {
      data['outUserList'] = this.outUserList.map((v) => v.toJson()).toList();
    }
    data['files'] = this.files;
    return data;
  }
}