import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:mobi/model/Chat/Chat.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';
import 'package:path/path.dart';

import 'ServiceUrl.dart';
import 'ServiseBase/ChatServiceBase.dart';
import 'package:http/http.dart' as http;

class DbChat implements ChatServiceBase {
  final ServiceUrl _serviceUrl = ServiceUrl();

  @override
  Future<ChatMessage> getChat({Map<String, String> header, int id}) async {
    var response =
        await http.get(_serviceUrl.getChat + "?id=$id", headers: header);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    log("getChat=  " + response.body);

    return ChatMessage.fromJson(responseData);
  }

  @override
  Future<Chat> getChatListWithoutMessages({Map<String, String> header}) async {
    var response =
        await http.get(_serviceUrl.getChatListWithoutMessages, headers: header);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return Chat.fromJson(responseData);
  }

  @override
  Future<int> insertGroupChat(
      {Map<String, String> header, String title, List<int> ids}) async {
    var response =
        await http.post(_serviceUrl.insertGroupChat, headers: header,
        body: jsonEncode(
            {
              "selectedUserIds": ids,
              "newChatTitle": title
            }
        ));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return responseData['data']['id'];
  }

  @override
  Future<void> insertChatMessage(
      {Map<String, String> header, int id, String message}) async {
    print("mesaje gondereme postu" + jsonEncode(
        {
          "chatId": id,
          "message": message
        }
    ));
    var response =
        await http.post(_serviceUrl.insertChatMessage, headers: header,
        body: jsonEncode(
          {
            "chatId": id,
            "message": message
          }
        ));


  }

  @override
  Future<int> insertChat({Map<String, String> header, int id}) async {
    print("idd = $id");
    var response =

        await http.get(_serviceUrl.insertChat + "?userId=$id", headers: header);
    log("insertChat=  " + response.body);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return responseData['data']['id'];
  }

  @override
  Future<int> uploadFile({Map<String, String> header, int chatId, int userId, File file}) async {

    List<int> imageBytes = file.readAsBytesSync();
       String fileName = basename(file.path).toString();
          String content = base64Encode(imageBytes);

 /*         log("upload file post islemi = " + jsonEncode({
            "files": [
              {
                "fileName": fileName,
                "directory": "",
                "fileContent": "",
                "imageByteArray":imageBytes
              }
            ],
            "chatUploadUserId": userId,
            "chatUploadChatId": chatId
          }));*/

   // "imageByteArray":imageBytes
    var response = await http.post(
      _serviceUrl.chatFileUpload,
      body: jsonEncode({
        "files": [
          {
            "fileName": fileName,
            "directory": "",
            "fileContent": content,


          }
        ],
        "chatUploadUserId": userId,
        "chatUploadChatId": chatId
      }),
      headers: header,
    );

    log("uploadFile = " + response.body);
  }
}
