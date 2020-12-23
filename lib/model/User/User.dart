import 'UserData.dart';

class User {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  UserData data;

  User(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  User.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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
    return 'User{statusCode: $statusCode, exceptionInfo: $exceptionInfo, pageSortSearch: $pageSortSearch, hasError: $hasError, data: $data}';
  }
}
