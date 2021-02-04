import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
              widget.page ?? FolderManager()));
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50 ,
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

                  ],
                ),
              ),
              SizedBox(width: 2,),

              Container(
                width: MediaQuery.of(context).size.width-100,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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

            ],
          ),
        ),
      ),
    );
  }
}
