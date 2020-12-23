import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Pages/SplashPage.dart';


List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("error code = " +
        e.code.toString() +
        "  Eror descp = " +
        e.description);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color themeColor = Color.fromRGBO(15, 85, 124, 1);

  Color yellowColor = Color.fromRGBO(213, 166, 46, 1); // sari renk

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: themeColor,
            fontSize: 16,
            fontFamily: 'NeueHaasGrotesk',
            fontWeight: FontWeight.w100,
          ),
        ),
        primaryColor: themeColor,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(
              color: themeColor,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 18,
                color: themeColor,
              ),
            )),

        iconTheme: IconThemeData(
          color: themeColor,
        ),
        fontFamily: 'NeueHaasGrotesk',
        // hintColor:Colors.grey,
        backgroundColor: yellowColor,
        //.fromRGBO(246, 78, 96, 1),
        accentColor: themeColor,
      ),
      home: SplashPages(),
    );
  }
}

