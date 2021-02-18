import 'package:mobi/model/User/UserData.dart';

class ChatMessage {
  int statusCode;
  Null exceptionInfo;
  Null pageSortSearch;
  bool hasError;
  ChatMessageData data;

  ChatMessage(
      {this.statusCode,
        this.exceptionInfo,
        this.pageSortSearch,
        this.hasError,
        this.data});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    exceptionInfo = json['exceptionInfo'];
    pageSortSearch = json['pageSortSearch'];
    hasError = json['hasError'];
    data = json['data'] != null ? new ChatMessageData.fromJson(json['data']) : null;
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
}

class ChatMessageData {
  int id;
  int unreadCounter;
  int isMuted;
  int isGroup;
  String groupPhoto;
  String title;
  String lastMessageDate;
  List<UserData> userList;
  List<MessageList> messageList;

  ChatMessageData(
      {this.id,
        this.unreadCounter,
        this.isMuted,
        this.isGroup,
        this.groupPhoto,
        this.title,
        this.lastMessageDate,
        this.userList,
        this.messageList});

  ChatMessageData.fromJson(Map<String, dynamic> json) {
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


class MessageList {
  int id;
  int chatId;
  int isUpload;
  String uploadPath;
  String message;
  String mediaLength;
  UserData ownerUser;
  String createDate;

  MessageList(
      {this.id,
        this.chatId,
        this.isUpload,
        this.uploadPath,
        this.mediaLength,
        this.message,
        this.ownerUser,
        this.createDate});

  MessageList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chatId'];
    isUpload = json['isUpload'];
    mediaLength = json['mediaLength'];
    uploadPath = json['uploadPath'];
    message = json['message'];
    ownerUser = json['ownerUser'] != null
        ? new UserData.fromJson(json['ownerUser'])
        : null;
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    data['isUpload'] = this.isUpload;
    data['mediaLength'] = this.mediaLength;
    data['uploadPath'] = this.uploadPath;
    data['message'] = this.message;
    if (this.ownerUser != null) {
      data['ownerUser'] = this.ownerUser.toJson();
    }
    data['createDate'] = this.createDate;
    return data;
  }
}
