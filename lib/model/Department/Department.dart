import 'DepartmentData.dart';
import 'PageSortSearch.dart';

class Department {
  int statusCode;
  Null exceptionInfo;
  PageSortSearch pageSortSearch;
  bool hasError;
  List<DepartmentData> data;

  Department(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Department.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'] != null
        ? new PageSortSearch.fromJson(json['pageSortSearch'])
        : null;
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<DepartmentData>();
      json['data'].forEach((v) {
        data.add(new DepartmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['exceptionInfo'] = this.exceptionInfo;
    if (this.pageSortSearch != null) {
      data['pageSortSearch'] = this.pageSortSearch.toJson();
    }
    data['hasError'] = this.hasError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}