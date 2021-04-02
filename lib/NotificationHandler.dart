import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Pages/Chat/CallsPage.dart';
import 'dart:convert';

import 'Controller/ControllerChat.dart';
import 'Controller/ControllerDB.dart';
import 'Pages/Chat/ChatRoom.dart';
import 'Pages/Chat/MySharedPreferencesForChat.dart';

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


    AwesomeNotifications().actionStream.listen(
            (receivedNotification){
print(receivedNotification.buttonKeyInput);
print(receivedNotification.buttonKeyPressed);
              if(receivedNotification.buttonKeyPressed=="response") {
                ControllerChat _controllerChat = Get.put(ControllerChat());
                ControllerDB _controllerDB = Get.put(ControllerDB());


                _controllerChat.insertChatMessage(
                    header: _controllerDB.headers(),
                    id: int.parse(receivedNotification.payload['Id']),
                    message: receivedNotification.buttonKeyInput);

              }
              else if(receivedNotification.buttonKeyPressed=="callU"){

              }
              else {
                onSelectNotification(jsonEncode(receivedNotification.payload));
              }

        }
    );

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

/*      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null */ /*&& android != null*/ /*) {
onLorR(message);
        showNotification(message.data,message.notification);
*/ /*        flutterLocalNotificationsPlugin.show(
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
            ));*/ /*
      }*/
    });

    /* FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage onTapMessage) {
      print('A new onMessageOpenedApp event was published! = ');

      onSelectNotification(onTapMessage);
    });
*/
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
    AwesomeNotifications().createNotification(
      actionButtons:messageData['type']=='call'?[

        NotificationActionButton(label: "Yanıtla",buttonType: ActionButtonType.Default,key: "callS" ),
        NotificationActionButton(label: "Reddet",buttonType: ActionButtonType.DisabledAction ,key: "callU"),

      ]: [

        NotificationActionButton(label: "Yanıtla",buttonType: ActionButtonType.InputField,key: "response" ),
      ],
        content: NotificationContent(

            id: 0,
            channelKey:  messageData['type']=='call'?'custom_sound':'basic_channel',

            title: messageNot.title == null
                ? messageData["SenderUserName"]
                : messageNot.title,
            body: messageNot.body,
        payload: messageData));





  }
/*
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {}*/

  Future onSelectNotification(String payload) async {
    Map<String, dynamic> gelenBildirim = jsonDecode(payload);
    debugPrint("ife girdi girecek $payload ");

    if (payload != null) {
      ControllerChat _controllerChat = Get.put(ControllerChat());

      if (gelenBildirim['type'] == "call") {
        print("idd chattt = " + gelenBildirim.toString());
        Navigator.of(_controllerChat.getContext(), rootNavigator: true)
            .pushReplacement(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => CallsPage(
                      channelName: gelenBildirim['id'].toString(),
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
}
