import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/widgets/FolderManager.dart';

// ignore: must_be_immutable
class PluginDrawer extends StatefulWidget {
  String title;
  String path;
  int notification;
  Widget page;

  PluginDrawer({this.title, this.path, this.notification, this.page});

  @override
  _PluginDrawerState createState() => _PluginDrawerState();
}

class _PluginDrawerState extends State<PluginDrawer> {
  Color themeColor;

  ControllerChange _controllerChange = ControllerChange();

  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;
    return InkWell(
      onTap: () {
        Get.to(widget.page ?? FolderManager());
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  color:themeColor.withOpacity(0.05),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 30,
                        child: Image.network(
                          _controllerChange.baseUrl + widget.path,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
/*
                    widget.notification == null
                        ? Container()
                        : Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Get.theme.backgroundColor,
                        child: Text(
                          "${widget.notification}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
*/
                  ],
                ),
              ),
            ),
            SizedBox(width: 2,),

            Expanded(
              flex: 3,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(20),
                  color:themeColor.withOpacity(0.05),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,

                        style: TextStyle(color: Colors.black, fontSize: 16,),
                      ),

                      widget.notification == null
                          ? Container()
                          : CircleAvatar(
                        radius: 10,
                        backgroundColor: Get.theme.backgroundColor,
                        child: Text(
                          "${widget.notification}",
                          style: TextStyle(color: Colors.white),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
