import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'Pages/SplashPage.dart';


List<CameraDescription> cameras = [];

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("error code = " +
        e.code.toString() +
        "  Eror descp = " +
        e.description);
  }
  runApp(
 MyApp()

  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Color themeColor = Color.fromRGBO(15, 85, 124, 1);

  Color yellowColor = Color.fromRGBO(213, 166, 46, 1); // sari renk

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
  /*    supportedLocales:  [Locale('en', 'US'), Locale('tr', 'TR')],
      locale: Locale('en', 'US'),
      translations: Messages(), // your translations
      fallbackLocale: Locale('en', 'US'), // specify the fallback locale in case an invalid locale is selected
*/
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: themeColor,
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
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
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,

                fontSize: 20,
                color: themeColor,
              ),
            )),

        iconTheme: IconThemeData(
          color: themeColor,
        ),
        fontFamily: 'Montserrat',
        // hintColor:Colors.grey,
        backgroundColor: yellowColor,
        //.fromRGBO(246, 78, 96, 1),
        accentColor: themeColor,
      ),
      home: SplashPages(),
    );
  }
}

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello World %s dsasdas %s',
    },
    'tr_TR': {
      'hello': 'Hallo Welt %s  dsasdas %s',
    }
  };
}

