import '../FamilyPerson.dart';

class Feed {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<FeedData> data;

  Feed(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Feed.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<FeedData>();
      json['data'].forEach((v) {
        data.add(new FeedData.fromJson(v));
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

class FeedData {
  int id;
  int familyId;
  FamilyPersonData person;
  int commentCount;
  int likeCount;
  String createDate;
  String feed;
  List<LikeList> likeList;

  FeedData(
      {this.id,
        this.familyId,
        this.person,
        this.commentCount,
        this.likeList,
        this.likeCount,
        this.createDate,
        this.feed});

  FeedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyId = json['familyId'];
    person =
    json['person'] != null ? new FamilyPersonData.fromJson(json['person']) : null;
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
    if (json['likeList'] != null) {
      likeList = new List<LikeList>();
      json['likeList'].forEach((v) {
        likeList.add(new LikeList.fromJson(v));
      });
    }

    createDate = json['createDate'];
    feed = json['feed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['familyId'] = this.familyId;
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    data['commentCount'] = this.commentCount;
    data['likeList'] = this.likeList;
    data['likeCount'] = this.likeCount;
    data['createDate'] = this.createDate;
    data['feed'] = this.feed;
    return data;
  }
}


class Like {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  LikeList likeList;

  Like(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.likeList});

  Like.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    likeList = json['data'];

    }
  }




class LikeList {
  int id;
  int feedId;
  int personId;
  String firstName;
  String lastName;

  LikeList(
      {this.id, this.feedId, this.personId, this.firstName, this.lastName});

  LikeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedId = json['feedId'];
    personId = json['personId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }
}

