import 'package:mobi/model/Family/Family.dart';

class Invite {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<InviteData> data;

  Invite(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Invite.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<InviteData>();
      json['data'].forEach((v) {
        data.add(new InviteData.fromJson(v));
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

class InviteData {
  int id;
  FamilyData senderFamily;
  FamilyData receiverFamily;
  int status;

  InviteData({this.id, this.senderFamily, this.receiverFamily, this.status});

  InviteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderFamily = json['senderFamily'] != null
        ? new FamilyData.fromJson(json['senderFamily'])
        : null;
    receiverFamily = json['receiverFamily'] != null
        ? new FamilyData.fromJson(json['receiverFamily'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.senderFamily != null) {
      data['senderFamily'] = this.senderFamily.toJson();
    }
    if (this.receiverFamily != null) {
      data['receiverFamily'] = this.receiverFamily.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}