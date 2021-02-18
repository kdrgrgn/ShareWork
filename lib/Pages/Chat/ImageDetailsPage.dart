import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';

class ImagePage extends StatelessWidget {
  String imagePath;
  MessageList message;

  ImagePage(this.imagePath, this.message);
  ControllerChange _controllerChange = Get.put(ControllerChange());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(message.ownerUser.firstName +
            " " +
            message.ownerUser.lastName),
        actions: [
          InkWell(
              onTap: () async {

                await FlutterDownloader.enqueue(
                  url: _controllerChange.baseUrl +
                      message.uploadPath.substring(1),

                  savedDir: imagePath,
                );

                Get.showSnackbar(GetBar(duration: Duration(milliseconds: 400),messageText: Text("Indirme Islemi Basarili",style: TextStyle(color: Colors.white)),));
              },
              child:Icon(Icons.download_rounded),

          ),
          SizedBox(width: 10,)

        ],
      ),
      body: Center(child: Image.network(_controllerChange.baseUrl +
          message.uploadPath.substring(1),)),
    );
  }


}
