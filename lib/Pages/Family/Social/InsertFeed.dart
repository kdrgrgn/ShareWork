import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor/html_editor.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class InsertFeed extends StatefulWidget {
  @override
  _InsertFeedState createState() => _InsertFeedState();
}

class _InsertFeedState extends State<InsertFeed> {
  String result ;
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  ControllerFamily _controllerFamily = Get.put(ControllerFamily());
  ControllerDB _controllerDB = Get.put(ControllerDB());
bool isLoading=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final txt = await keyEditor.currentState.getText();
        setState(() {
            isLoading=true;
result=txt;
          });
          log("Txt = $txt");

int personId;
          _controllerFamily.family.value.data.personList.forEach((element) {
            if(element.user.id==_controllerDB.user.value.data.id){
              personId=element.id;
            }
          });


          _controllerFamily.insertFamilyFeed(_controllerDB.headers(),
              familyId: _controllerFamily.family.value.data.id,
              personId: personId,
          feed: txt).then((value){
            Navigator.of(context).pop();
            setState(() {
              isLoading=false;
            });
          });


        },
        child: Tab(
          icon: Icon(
            Icons.send,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("New Feed"),
      ),
      body: isLoading?MyCircular():HtmlEditor(
        hint: "Your text here...",
        key: keyEditor,
        height: Get.height - 250,
        decoration: BoxDecoration(color: Colors.white),
      ),
    );

  }
}
