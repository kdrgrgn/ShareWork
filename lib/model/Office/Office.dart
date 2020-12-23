import 'package:mobi/model/Office/OfficeData.dart';

class Office {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  OfficeData data;

  Office(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Office.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    data = json['data'] != null ? new OfficeData.fromJson(json['data']) : null;
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
    return 'Office{statusCode: $statusCode, exceptionInfo: $exceptionInfo, pageSortSearch: $pageSortSearch, hasError: $hasError, data: $data}';
  }
}