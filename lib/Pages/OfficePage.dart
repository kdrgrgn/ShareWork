import 'package:flutter/material.dart';

class OfficePage extends StatefulWidget {
  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  Color themeColor;

  @override
  Widget build(BuildContext context) {
    themeColor=Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(title: Text("Ofis",style: TextStyle(color: themeColor),),
      textTheme: TextTheme(
bodyText2: TextStyle(color: Colors.red)
      ),
      iconTheme: IconThemeData(
        color: themeColor
      ),),
      body: Container(
        child: Text("asfsdfsdf"),
      ),
    );
  }
}
