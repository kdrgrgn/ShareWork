import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FolderManager extends StatefulWidget {
  @override
  _FolderManagerState createState() => _FolderManagerState();
}

class _FolderManagerState extends State<FolderManager> {
  Color themeColor;
bool isLoading=true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    themeColor=Theme.of(context).accentColor;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: themeColor,
                size: 30,
        ),
        actions: [
          Icon(Icons.add,),
          Icon(Icons.search,),
        ],
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
         child: Icon(Icons.add,size: 30.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [

          SpeedDialChild(
            child: Icon(Icons.create_new_folder),
            backgroundColor: Colors.blue,
            label: 'Add Folder',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.photo_camera_sharp),
            backgroundColor: Colors.red,
            label: 'Take Photo',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
      body:Column(
children: [
  Container(
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.3))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Oldest",style: TextStyle(color: Colors.black),),
        Row(
          children: [

            Icon(Icons.list,color: themeColor,),
            SizedBox(width: 10,),
            Icon(Icons.grid_view,color: themeColor,),
          ],
        ),
      ],
    ),
  ),

Expanded(
  child:   WebView(
    initialUrl: "https://pub.dev/packages/webview_flutter",

    javascriptMode: JavascriptMode.unrestricted,

    onWebResourceError: (err){
      print("error =  "+ err.description);
    },
    onWebViewCreated: (w){
      setState(() {
        isLoading=false;

      },
      );
    },
  ),
),
/*  ListView(
    shrinkWrap: true,
    children: [

    ],
  )*/

],
      ) ,
    );
  }
}
