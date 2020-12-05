import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi/Pages/OfficePage.dart';
import 'package:mobi/widgets/FolderManager.dart';

// ignore: must_be_immutable
class MyPlugin extends StatefulWidget {
  String title;
  String path;
  int notification;

  MyPlugin({this.title, this.path, this.notification});

  @override
  _MyPluginState createState() => _MyPluginState();
}

class _MyPluginState extends State<MyPlugin> {
  Color themeColor;

  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;
    return InkWell(
      onTap: (){
        Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context)=>FolderManager()));
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.title,
                    /*  style: TextStyle(
                        fontFamily: 'NeueHaasGrotesk',
                        color: Colors.grey[600],
                        fontSize: 18),*/
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      widget.path,
                      fit: BoxFit.contain,
                    ),
                    widget.notification == null
                        ? Container()
                        : Column(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: themeColor,
                                child: Text(
                                  "${widget.notification}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
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
