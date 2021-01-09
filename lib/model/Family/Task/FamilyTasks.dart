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

  FamilyTaskData(
      {this.id,
        this.createDate,
        this.date,
        this.dateString,
        this.description,
        this.picture,
        this.title,
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
    dateString = json['dateString'];
    description = json['description'];
    picture = json['picture'];
    title = json['title'];
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
    data['points'] = this.points;
    data['familyPersonTaskId'] = this.familyPersonTaskId;
    data['repeatId'] = this.repeatId;
    data['repeatType'] = this.repeatType;
    return data;
  }
}