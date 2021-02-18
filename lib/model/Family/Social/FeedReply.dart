import 'package:mobi/model/Family/Social/Feed.dart';

import '../FamilyPerson.dart';

class Reply {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<ReplyData> data;

  Reply(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Reply.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<ReplyData>();
      json['data'].forEach((v) {
        data.add(new ReplyData.fromJson(v));
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

class ReplyData {
  int id;
  int likeCount;
  String feed;
  FeedData familyFeed;
  FamilyPersonData person;
  String createDate;

  ReplyData(
      {this.id,
        this.likeCount,
        this.feed,
        this.familyFeed,
        this.person,
        this.createDate});

  ReplyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    likeCount = json['likeCount'];
    feed = json['feed'];
    familyFeed = json['familyFeed'] != null
        ? new FeedData.fromJson(json['familyFeed'])
        : null;
    person =
    json['person'] != null ? new FamilyPersonData.fromJson(json['person']) : null;
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['likeCount'] = this.likeCount;
    data['feed'] = this.feed;
    if (this.familyFeed != null) {
      data['familyFeed'] = this.familyFeed.toJson();
    }
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    data['createDate'] = this.createDate;
    return data;
  }
}