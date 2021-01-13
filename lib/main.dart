import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
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
  EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/Translations', // <-- change patch to your
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()

  );
}

class MyApp extends StatelessWidget {
  Color themeColor = Color.fromRGBO(15, 85, 124, 1);

  Color yellowColor = Color.fromRGBO(213, 166, 46, 1); // sari renk

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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

