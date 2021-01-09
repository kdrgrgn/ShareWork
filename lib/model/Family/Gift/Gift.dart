class Gift {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<GiftData> data;

  Gift(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Gift.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<GiftData>();
      json['data'].forEach((v) {
        data.add(new GiftData.fromJson(v));
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

class GiftData {
  int id;
  int point;
  int isActive;
  String picture;
  String title;
  int familyId;
  String createDate;

  GiftData(
      {this.id,
        this.point,
        this.isActive,
        this.picture,
        this.title,
        this.familyId,
        this.createDate});

  GiftData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    point = json['point'];
    isActive = json['isActive'];
    picture = json['picture'];
    title = json['title'];
    familyId = json['familyId'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['point'] = this.point;
    data['isActive'] = this.isActive;
    data['picture'] = this.picture;
    data['title'] = this.title;
    data['familyId'] = this.familyId;
    data['createDate'] = this.createDate;
    return data;
  }
}