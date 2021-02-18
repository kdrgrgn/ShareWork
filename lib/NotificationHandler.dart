import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'Controller/ControllerChat.dart';
import 'Controller/ControllerDB.dart';
import 'Pages/Chat/ChatRoom.dart';
import 'Pages/Chat/MySharedPreferencesForChat.dart';
import 'Pages/Login/rememberMeControl.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("arka planda gelen data = " + message.toString());

  NotificationHandler.updateChatList(
      message["notification"]["body"], message['data']['Id']);

  NotificationHandler.updateCount(message['data']['Id']);

  NotificationHandler.showNotification(message);

  return Future<void>.value();
  // Or do other work.
}

class NotificationHandler {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static final NotificationHandler _instance = NotificationHandler._();

  factory NotificationHandler() => _instance;

  NotificationHandler._();


  Future<void> init() async {

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        ControllerChat _controllerChat = Get.put(ControllerChat());
int chatid=_controllerChat.chatIdGet();
        if (chatid!=0 &&
            chatid.toString() == message['data']['Id']) {
          _controllerChat.messagesUpdate(message);
        } else {
          updateCount(message['data']['Id']);
          showNotification(message);
          updateChatList(
              message["notification"]["body"], message['data']['Id']);
        }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final ControllerDB c = Get.put(ControllerDB());

        List<String> temp= await RememberMeControl.instance.getRemember("login");
        if(temp!=null){
          await c.signIn(mail: temp[0], password: temp[1],rememberMe:false);
          onLorR(message);

        }


        // showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        onLorR(message);

        //  showNotification(message);
      },
    );
  }

  void onLorR(Map<String, dynamic> message) {
    NotificationHandler.updateChatList(
        message["notification"]["body"], message['data']['Id']);

    NotificationHandler.updateCount(message['data']['Id']);
    onSelectNotification(jsonEncode(message));
  }

  static void updateCount(String key) async {
    MySharedPreferencesForChat _countDB = MySharedPreferencesForChat.instance;
    List<String> a = await _countDB.getCount(key);
    if (a != null) {
      int old = int.parse(a.first);
      old++;
      _countDB.setCount(key, [old.toString()]);
    } else {
      _countDB.setCount(key, ["1"]);
    }
    NotificationHandler.updateTotalCount();

  }
  static void updateTotalCount() async {
    print("buraya girdi => updateTotalCount");
    String key='chat';

    MySharedPreferencesForChat _countDB = MySharedPreferencesForChat.instance;
    List<String> a = await _countDB.getCount(key);
    if (a != null) {
      int old = int.parse(a.first);
      old++;
      _countDB.setCount(key, [old.toString()]);
    } else {
      _countDB.setCount(key, ["1"]);
    }
  }

    static void updateChatList(String message, String id) async {
    ControllerChat _controllerChat = Get.put(ControllerChat());

    _controllerChat.chatListUpdate(int.parse(id), message);
  }

  static void showNotification(Map<String, dynamic> message) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1234', 'Yeni Mesaj', 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      // styleInformation: mesajStyle,
      /*   importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'*/
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        message["notification"]["title"] == null
            ? message["data"]["SenderUserName"]
            : message["notification"]["title"],
        message["notification"]["body"],
        platformChannelSpecifics,
        payload: jsonEncode(message));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

  Future onSelectNotification(String payload) async {
    Map<String, dynamic> gelenBildirim = await jsonDecode(payload);
    debugPrint("ife girdi girecek $payload ");

    if (payload != null) {
      ControllerChat _controllerChat = Get.put(ControllerChat());

      debugPrint("ife girdi tiklandiginda ${_controllerChat.getContext()} ");
      Navigator.of(_controllerChat.getContext(), rootNavigator: true)
          .pushReplacement(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => ChatRoom(
                    id: int.parse(gelenBildirim['data']['Id']),
                  )));
    }
  }
}
