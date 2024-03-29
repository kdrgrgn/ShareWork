import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobi/model/Chat/Chat.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';

abstract class ChatServiceBase{


  Future<ChatMessage> getChat({@required Map<String, String> header,@required int id});


  Future<Chat> getChatListWithoutMessages({@required Map<String, String> header});

  Future<int> insertChat({@required Map<String, String> header, int id});

  Future<MessageList> uploadFile({@required Map<String, String> header, int chatId,int userId,File file,String mediaLength});

  Future<void> insertChatMessage({@required Map<String, String> header,int id,String message});


  Future<int> insertGroupChat({@required Map<String, String> header,@required String title,@required List<int> ids});


}