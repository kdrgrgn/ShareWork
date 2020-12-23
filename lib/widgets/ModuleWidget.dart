import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/widgets/FolderManager.dart';

// ignore: must_be_immutable
class ModuleWidget extends StatefulWidget {
  String title;
  String path;
  int notification;
  Widget page;

  ModuleWidget({this.title, this.path, this.notification, this.page});

  @override
  _ModuleWidgetState createState() => _ModuleWidgetState();
}

class _ModuleWidgetState extends State<ModuleWidget> {
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
        child: Container(
          height: 75,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.title,

                    style: TextStyle(color: Colors.black, fontSize: 16,),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0.5, 0),
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          _controllerChange.baseUrl + widget.path,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    widget.notification == null
                        ? Container()
                        : Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: Get.theme.backgroundColor,
                              child: Text(
                                "${widget.notification}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
