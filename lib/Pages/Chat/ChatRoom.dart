import 'package:path/path.dart' as p;

import 'dart:io';
import 'dart:typed_data';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

import '../../NotificationHandler.dart';
import 'MySharedPreferencesForChat.dart';

class ChatRoom extends StatefulWidget {
  int id;

  ChatRoom({this.id});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Color themeColor = Get.theme.accentColor;

  final _formKey = GlobalKey<FormState>();
  String message = "";
  TextEditingController _textEditingController = TextEditingController();
  bool isRecording = false;
  ScrollController _scrollController;
  ControllerChat _controllerChat = Get.put(ControllerChat());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  bool isLoading = true;
  bool onDrag = false;
  ChatMessage _chat;
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController(
      //   initialScrollOffset: Get.height,
      keepScrollOffset: true,
    );
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /*   NotificationHandler()
          .init(context, id: widget.id, isPayload: widget.isPayload);*/
      _controllerChat.setContext(context);

      _chat = await _controllerChat.getChat(
          header: _controllerDB.headers(), id: widget.id);
      MySharedPreferencesForChat _countDB = MySharedPreferencesForChat.instance;
      await _countDB.deleteCount(widget.id.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: MyCircular())
        : GetBuilder<ControllerChat>(builder: (_c) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        _controllerChat.chatIdUpdate();

                        Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              BuildBottomNavigationBar(
                                page: 1,
                              ),
                        ));
                      },
                      child: Icon(
                        Icons.arrow_back,
                      )),
                  Builder(
                    builder: (context) =>
                        InkWell(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(_chat
                                  .data.groupPhoto.isEmpty
                                  ? "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?" +
                                  "auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"
                                  : _chat.data.groupPhoto),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
              Text(
                _chat.data.isGroup == 1
                    ? _chat.data.title
                    : _chat.data.userList.first.firstName,
                style: TextStyle(color: themeColor),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: themeColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: WillPopScope(
          onWillPop: () async {
            _controllerChat.chatIdUpdate();

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  BuildBottomNavigationBar(
                    page: 1,
                  ),
            ));
            return false;
          },
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: _c.messages.length,
                  itemBuilder: (ctx, i) =>
                      renderChatMessage(_c.messages[i]),
                ),
              ),
              Divider(),
              Container(
                child: renderTextBox(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget renderChatMessage(MessageList message) {
    bool isSentByMe = message.ownerUser.id == _controllerDB.user.value.data.id;
    return Column(
      children: <Widget>[
        ChatBubble(
          clipper: ChatBubbleClipper1(
              type: isSentByMe
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble),
          alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20),
          backGroundColor: isSentByMe ? themeColor : Colors.white,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
            ),
            child: message.isUpload == 1
                ? messageBox(message) //voicePlayer(message)
                : Text(
              message.message,
              style: TextStyle(
                  color: isSentByMe ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderTextBox() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Row(
        children: <Widget>[
          isRecording
              ? InkWell(
            onTap: () async {
              Recording rec = await AudioRecorder.stop();
              Directory(rec.path).deleteSync(recursive: true);

              setState(() {
                isRecording = false;
              });
            },
            child: Text(
              "Iptal",
              style: TextStyle(color: Colors.red),
            ),
          )
              : Container(),
          Flexible(
            child: Form(
              key: _formKey,
              child: Container(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: "Your Message Here",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.attach_file,
              color: Colors.black,
            ),
            onPressed: () async {
              String path = await FlutterDocumentPicker.openDocument();
              print("document = $path");
              File file = File(path);
              print("filee document = $file");

              await _controllerChat.uploadFile(
                  header: _controllerDB.headers(),
                  chatId: _chat.data.id,
                  userId: _controllerDB.user.value.data.id,
                  file: file);
            },
          ),
          message.isEmpty
              ? isRecording
              ? FloatingActionButton(
            mini: true,
            backgroundColor: themeColor,
            onPressed: () async {
              await sendVoice();
              setState(() {
                isRecording = false;
              });
            },
            child: Icon(
              Icons.send,
            ),
          )
              : FloatingActionButton(
            mini: true,
            backgroundColor: themeColor,
            onPressed: () async {
              bool hasPermissions =
              await AudioRecorder.hasPermissions;
              print("hasPermissions = $hasPermissions");
              // Get the state of the recorder
              Directory appDocDirectory = Directory.systemTemp;
              String path = appDocDirectory.path + '/yrsgd.mp3';
              print("path = $path");
              await AudioRecorder.start(path: path);

              AudioRecorder.isRecording.then((value) {
                setState(() {
                  isRecording = value;
                });
              });
            },
            child: Icon(
              Icons.mic,
            ),
          )
              : FloatingActionButton(
            mini: true,
            backgroundColor: themeColor,
            onPressed: () {
              _controllerChat.messageSendUpdate(
                  _controllerDB.user.value.data.id, message);

              _controllerChat.insertChatMessage(
                  header: _controllerDB.headers(),
                  id: _chat.data.id,
                  message: message);

              setState(() {
                _textEditingController.text = "";
                message = "";
              });
            },
            child: Icon(
              Icons.send,
            ),
          ),
        ],
      ),
    );
  }

  sendVoice() async {
    Recording recording = await AudioRecorder.stop();

    File file = File(recording.path);

    Uint8List byteData = file.readAsBytesSync();
    advancedPlayer.playBytes(byteData);

    await _controllerChat.uploadFile(
        header: _controllerDB.headers(),
        chatId: _chat.data.id,
        userId: _controllerDB.user.value.data.id,
        file: file);

    Directory(recording.path).deleteSync(recursive: true);

    /*    int result =
                  await audioPlayer.play(recording.path, isLocal: true);
*/
  }

  Widget voicePlayer(MessageList message) {
//  int _slider=await advancedPlayer.release();

    return Row(
      children: [
        InkWell(
          onTap: () async {
            print("path = " +
                _controllerChange.baseUrl +
                message.uploadPath.substring(1));
            int result = await advancedPlayer.play(
                _controllerChange.baseUrl + message.uploadPath.substring(1));

            print("result = $result");
          },
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
        )

/*        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(
                    disabledThumbRadius: 5,
                    enabledThumbRadius: 5,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.grey,
                ),
                child: Slider(
                  value: _slider.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _slider = value.toInt();
                    });
                  },
             */ /*     onChangeEnd: (value) {
                    if (audioManagerInstance.duration != null) {
                      Duration msec = Duration(
                          milliseconds:
                          (audioManagerInstance.duration.inMilliseconds *
                              value)
                              .round());
                      audioManagerInstance.seekTo(msec);
                    }
                  },*/ /*
                )),
          ),
        )*/
      ],
    );
  }

  Widget messageBox(MessageList message) {
    String extension = p.extension(message.message);
    switch (extension) {
      case '.m4a':
        return voicePlayer(message);

      case '.jpg':
        return imageMessage(message);
    }
  }

  Widget imageMessage(MessageList message) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ImagePage(
                  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?" +
                      "auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
        ));
      },
      child: Container(
        height: 300,
        child: Image.network(
            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?"
                "auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  String url;

  ImagePage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("senderUser"),),
      body:  Center(child: Image.network(url)),
    );
  }
}
