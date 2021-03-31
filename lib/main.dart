import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:mobi/NotificationHandler.dart';
import 'Pages/SplashPage.dart';


List<CameraDescription> cameras = [];
/*final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();*/

Future<void> main() async {

  AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            ledColor: Colors.white
        ),

        NotificationChannel(
            icon: 'resource://drawable/app_icon',
            channelKey: "custom_sound",
            channelName: "Custom sound notifications",
            channelDescription: "Notifications with custom sound",
            playSound: true,
            soundSource: 'resource://raw/audio',
            ledColor: Colors.red,
            channelShowBadge: true,
            vibrationPattern: highVibrationPattern,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Public,
          locked: true,

        ),

      ]
  );



  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);

 /* WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(onCalling);
*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  // Set the background messaging handler early on, as a named top-level function


  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.




  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );




  NotificationSettings settings = await  FirebaseMessaging.instance.requestPermission(
    alert: false,
    announcement: false,
    badge: false,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: false,
  );


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
  Color themeColor = Color.fromRGBO(199, 79, 79, 1);

  Color yellowColor = Color.fromRGBO(255, 157, 84, 1); // sari renk

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

