import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Services/Chat/DBChat.dart';
import 'package:mobi/Services/Chat/ChatServiceBase.dart';
import 'package:mobi/model/Chat/Chat.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';
import 'package:mobi/model/User/UserData.dart';

class ControllerChat extends GetxController implements ChatServiceBase {
  DbChat _chatService = DbChat();

  RxList<MessageList> messages = [null].obs;
  RxList<ChatData> chatData = [null].obs;
  Rx<BuildContext> context = null.obs;
  RxInt chatID = 0.obs;

  @override
  Future<ChatMessage> getChat({Map<String, String> header, int id}) async {
    ChatMessage _chat = await _chatService.getChat(header: header, id: id);
    messages = _chat.data.messageList.reversed.toList().obs;
    update();
    chatID = id.obs;
    update();
    return _chat;
  }

  @override
  Future<Chat> getChatListWithoutMessages({Map<String, String> header}) async {
    Chat chat = await _chatService.getChatListWithoutMessages(header: header);
    chatData = chat.data.obs;
    update();

    return chat;
  }

  @override
  Future<int> insertGroupChat(
      {Map<String, String> header, String title, List<int> ids}) async {
    return await _chatService.insertGroupChat(
        header: header, title: title, ids: ids);
  }

  @override
  Future<void> insertChatMessage(
      {Map<String, String> header, int id, String message}) async {
    return await _chatService.insertChatMessage(
        header: header, id: id, message: message);
  }

  @override
  Future<int> insertChat({Map<String, String> header, int id}) async {
    return await _chatService.insertChat(header: header, id: id);
  }

  messagesUpdate(Map<String, dynamic> message) {
    if (message['data']['MediaPath'].isEmpty) {
      messages.insert(
          0,
          MessageList(
              message: message['notification']['body'],
              id:  int.parse(message['data']['MessageId']),
              isUpload: 0,

              ownerUser: UserData(
                  id: int.parse(message['data']['SenderUserId']),
                  firstName: message['data']['SenderUserName'],
                  lastName: " ",

              profilePhoto: message['data']['Image'])));
    } else {
      messages.insert(
          0,
          MessageList(
              message: message['notification']['body'],
              id:  int.parse(message['data']['MessageId']),
              uploadPath: message['data']['MediaPath'],
              isUpload: 1,
              mediaLength: message['data']['MediaLength'],
              ownerUser: UserData(
                  id: int.parse(message['data']['SenderUserId']),
                  firstName: message['data']['SenderUserName'],
                  lastName: " ", profilePhoto: message['data']['Image'])));
    }
    update();
  }

  messageSendUpdate(UserData userData, String message) {
    messages.insert(
        0,
        MessageList(
            message: message,
            ownerUser: UserData(
                id: userData.id,
                profilePhoto: userData.profilePhoto,
                firstName: userData.firstName,
                lastName: userData.lastName)));
    update();
  }

  chatListUpdate(int id, String message) {
    bool isContain = false;
    isContain = true;
    DateTime now = DateTime.now();
    String time = now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString();
    for (int i = 0; i < chatData.length; i++) {
      if (chatData[i].id == id) {
        chatData[i].messageList.first.message = message;
        chatData[i].lastMessageDate = "11111111111" + time;
        update();
      }
    }
    if (isContain == false) {
      chatData.insert(
          0,
          ChatData(
              id: id,
              messageList: [MessageList(message: message)],
              lastMessageDate: time));
      update();
    }
  }

  @override
  Future<MessageList> uploadFile(
      {Map<String, String> header,
      int chatId,
      String mediaLength,
      int userId,
      File file}) async {
    return await _chatService.uploadFile(
        header: header,
        chatId: chatId,
        userId: userId,
        file: file,
        mediaLength: mediaLength);
  }

  int chatIdGet() {
    return chatID.value;
  }

  chatIdUpdate() {
    chatID = 0.obs;
    update();
  }

  void setContext(BuildContext myContext) {
    context = myContext.obs;
    update();
  }

  BuildContext getContext() {
    return context.value;
  }

  void messageSendFile(MessageList result) {
    messages.insert(0, result);
    update();
  }
}
