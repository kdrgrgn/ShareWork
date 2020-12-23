import 'ProjectList.dart';

class Data {
  List<ProjectList> projectList;
  int totalPage;
  int totalCount;

  Data({this.projectList, this.totalPage, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['projectList'] != null) {
      projectList = new List<ProjectList>();
      json['projectList'].forEach((v) {
        projectList.add(new ProjectList.fromJson(v));
      });
    }
    totalPage = json['totalPage'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projectList != null) {
      data['projectList'] = this.projectList.map((v) => v.toJson()).toList();
    }
    data['totalPage'] = this.totalPage;
    data['totalCount'] = this.totalCount;
    return data;
  }
}
