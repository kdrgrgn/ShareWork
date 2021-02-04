import 'package:mobi/model/User/UserData.dart';

import 'ChatMessage.dart';

class Chat {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  List<ChatData> data;

  Chat(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  Chat.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    if (json['data'] != null) {
      data = new List<ChatData>();
      json['data'].forEach((v) {
        data.add(new ChatData.fromJson(v));
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

class ChatData {
  int id;
  int unreadCounter;
  int isMuted;
  int isGroup;
  String groupPhoto;
  String title;
  String lastMessageDate;
  List<UserData> userList;
  List<MessageList> messageList;

  ChatData(
      {this.id,
        this.unreadCounter,
        this.isMuted,
        this.isGroup,
        this.groupPhoto,
        this.title,
        this.lastMessageDate,
        this.userList,
        this.messageList});

  ChatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unreadCounter = json['unreadCounter'];
    isMuted = json['isMuted'];
    isGroup = json['isGroup'];
    groupPhoto = json['groupPhoto'];
    title = json['title'];
    lastMessageDate = json['lastMessageDate'];
    if (json['userList'] != null) {
      userList = new List<UserData>();
      json['userList'].forEach((v) {
        userList.add(new UserData.fromJson(v));
      });
    }
    if (json['messageList'] != null) {
      messageList = new List<MessageList>();
      json['messageList'].forEach((v) {
        messageList.add(new MessageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unreadCounter'] = this.unreadCounter;
    data['isMuted'] = this.isMuted;
    data['isGroup'] = this.isGroup;
    data['groupPhoto'] = this.groupPhoto;
    data['title'] = this.title;
    data['lastMessageDate'] = this.lastMessageDate;
    if (this.userList != null) {
      data['userList'] = this.userList.map((v) => v.toJson()).toList();
    }
    if (this.messageList != null) {
      data['messageList'] = this.messageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


