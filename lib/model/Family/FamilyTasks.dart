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
  String description;
  String picture;
  String title;
  String category;
  int status;
  int familyPersonTaskId;

  FamilyTaskData(
      {this.id,
        this.createDate,
        this.description,
        this.picture,
        this.title,
        this.category,
        this.status,
        this.familyPersonTaskId});

  FamilyTaskData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    description = json['description'];
    picture = json['picture'];
    title = json['title'];
    category = json['category'];
    status = json['status'];
    familyPersonTaskId = json['familyPersonTaskId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['description'] = this.description;
    data['picture'] = this.picture;
    data['title'] = this.title;
    data['category'] = this.category;
    data['status'] = this.status;
    data['familyPersonTaskId'] = this.familyPersonTaskId;
    return data;
  }
}