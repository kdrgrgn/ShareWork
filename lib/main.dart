import 'package:flutter/material.dart';

import 'landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        textTheme: TextTheme(
      bodyText2: TextStyle(
      color: Colors.grey[500],
        fontSize: 20,
        fontFamily: 'NeueHaasGrotesk',
        fontWeight: FontWeight.w100,

      ),
    ) ,
        primaryColor: Colors.white,

iconTheme: IconThemeData(
  color:Color.fromRGBO(246, 78, 96, 1),
),
        fontFamily: 'NeueHaasGrotesk',
       // hintColor:Colors.grey,
        backgroundColor: Color.fromRGBO(246, 78, 96, 1),//.fromRGBO(246, 78, 96, 1),
        accentColor:Color.fromRGBO(246, 78, 96, 1),
      ),
      home: LandingPage(),
    );
  }
}



