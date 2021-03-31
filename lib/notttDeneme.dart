import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Chat/CallsPage.dart';
import 'dart:convert';

import 'Controller/ControllerChat.dart';
import 'Controller/ControllerDB.dart';
import 'Pages/Chat/ChatRoom.dart';
import 'Pages/Chat/MySharedPreferencesForChat.dart';
/*
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(RemoteMessage newMessage) async {
  Map<String, dynamic> message = newMessage.data;

  print("arka planda gelen remoteee = " + newMessage.toString());

  print("arka planda gelen data = " + message.toString());

  NotificationHandler.updateChatList(
      newMessage.notification.body, int.parse(message['Id']));

  NotificationHandler.updateCount(message['Id']);

  NotificationHandler.showNotification(message, newMessage.notification);

  return Future<void>.value();
  // Or do other work.
}

class NotificationHandler {
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging;

  static final NotificationHandler _instance = NotificationHandler._();

  factory NotificationHandler() => _instance;

  NotificationHandler._();

  Future<void> init() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // Eski mesaj alma olayi burada

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ControllerChat _controllerChat = Get.put(ControllerChat());
      int chatid = _controllerChat.chatIdGet();
      if (message.data['type'] == "call") {
        showNotification(message.data, message.notification);
      } else {
        if (chatid != 0 && chatid.toString() == message.data['Id']) {
          _controllerChat.messagesUpdate(message.data, message.notification);
        } else {
          updateCount(message.data['Id'].toString());
          showNotification(message.data, message.notification);
          //  print("my idddd  firstt= " +message.data['Id'].toString());

          updateChatList(
              message.notification.body, int.parse(message.data['Id']));
        }
      }

*//*      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null *//* *//*&& android != null*//* *//*) {
onLorR(message);
        showNotification(message.data,message.notification);
*//* *//*        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));*//* *//*
      }*//*
    });

    *//* FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage onTapMessage) {
      print('A new onMessageOpenedApp event was published! = ');

      onSelectNotification(onTapMessage);
    });
*//*
  }

  void onLorR(RemoteMessage newMessage) {
    var message = newMessage.data;
    if (message['type'] == "call") {
      onSelectNotification(jsonEncode(newMessage.data));
    } else {
      NotificationHandler.updateChatList(
          newMessage.notification.body, int.parse(message['Id']));

      NotificationHandler.updateCount(message['Id'].toString());
      onSelectNotification(jsonEncode(newMessage.data));
    }
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
    String key = 'chat';

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

  static void updateChatList(String message, int id) async {
    ControllerChat _controllerChat = Get.put(ControllerChat());
    print("my idddd = $id");
    _controllerChat.chatListUpdate(id, message);
  }

  static void showNotification(
      Map<String, dynamic> messageData,
      RemoteNotification messageNot,
      ) async {
    print(" callim  = " + messageData['type']);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      '1234', 'Yeni Mesaj', 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      sound: messageData['type']=='call'?RawResourceAndroidNotificationSound('audio'):null,
      playSound: true,
      enableVibration: true,




      // styleInformation: mesajStyle,
      *//*   importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'*//*
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        messageNot.title == null
            ? messageData["SenderUserName"]
            : messageNot.title,
        messageNot.body,
        platformChannelSpecifics,
        payload: jsonEncode(messageData));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}

  Future onSelectNotification(String payload) async {
    Map<String, dynamic> gelenBildirim = jsonDecode(payload);
    debugPrint("ife girdi girecek $payload ");

    if (payload != null) {
      ControllerChat _controllerChat = Get.put(ControllerChat());

      if (gelenBildirim['type'] == "call") {
        Navigator.of(_controllerChat.getContext(), rootNavigator: true)
            .pushReplacement(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => CallsPage(
              channelName: gelenBildirim['Id'],
              role: gelenBildirim['isVideo'] == 1
                  ? ClientRole.Broadcaster
                  : ClientRole.Audience,
            )));
      } else {
        debugPrint("ife girdi tiklandiginda ${_controllerChat.getContext()} ");
        Navigator.of(_controllerChat.getContext(), rootNavigator: true)
            .pushReplacement(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ChatRoom(
              id: int.parse(gelenBildirim['Id']),
            )));
      }
    }
  }
}*/

/*    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        ControllerChat _controllerChat = Get.put(ControllerChat());
int chatid=_controllerChat.chatIdGet();
if(message['data']['type']=="call"){
  showNotification(message);
}else{

        if (chatid!=0 &&
            chatid.toString() == message['data']['Id']) {
          _controllerChat.messagesUpdate(message);
        } else {

          updateCount(message['data']['Id']);
          showNotification(message);
          updateChatList(
              message["notification"]["body"], message['data']['Id']);
        }

    }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        if(message['data']['type']=="call"){
          onLorR(message);
        }else{

        print("onLaunch: $message");
        final ControllerDB c = Get.put(ControllerDB());

        List<String> temp= await RememberMeControl.instance.getRemember("login");
        if(temp!=null){
          await c.signIn(mail: temp[0], password: temp[1],rememberMe:false);
          onLorR(message);

        }
        }

        // showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {

          onLorR(message);

        //  showNotification(message);
      },
    );*/
