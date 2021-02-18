import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi/Pages/Chat/VideoPlayerPage.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import 'package:path_provider/path_provider.dart';
import 'ImageDetailsPage.dart';
import 'MySharedPreferencesForChat.dart';

class ChatRoom extends StatefulWidget {
  int id;

  ChatRoom({this.id});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  //Audio player and recording param
  AudioPlayer advancedPlayer;
  bool isRecording = false;
  bool isPlaying = false;
  Duration _duration = new Duration();
  Duration _position = new Duration();

  //download param
  bool fileLoading = false;
  String _downloadPath;
  String _imagePath;
  String _videoPath;

//click message ID
  int messageID;

  //Color
  Color themeColor = Get.theme.accentColor;
  Color backgroundColor = Get.theme.backgroundColor;

  String message = "";

  //Controllerss
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController;
  ControllerChat _controllerChat = Get.put(ControllerChat());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());

  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  ChatMessage _chat;

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
    /*\   if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }*/
    advancedPlayer = new AudioPlayer();
    //   audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    initPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //path
      _downloadPath = await _objectPath('Download');
      _imagePath = await _objectPath('Images');
      _videoPath = await _objectPath('Video');
      //create dir
      await saveDir(_downloadPath);
      await saveDir(_imagePath);
      await saveDir(_videoPath);

      _controllerChat.setContext(context);

      _chat = await _controllerChat.getChat(
          header: _controllerDB.headers(), id: widget.id);
      MySharedPreferencesForChat _countDB = MySharedPreferencesForChat.instance;
      List<String> a = await _countDB.getCount("chat");
      List<String> b=   await _countDB.getCount(widget.id.toString());

      if (a != null&&b!=null) {
        int olda = int.parse(a.first);
        int oldb = int.parse(b.first);

        olda=olda-oldb;
        if(olda>0) {
          _countDB.setCount("chat", [olda.toString()]);
        }else{
          await _countDB.deleteCount("chat");

        }
      }
      await _countDB.deleteCount(widget.id.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<String> _objectPath(String dir) async =>
      (await _findDownloadPath()) + Platform.pathSeparator + dir;

  Future saveDir(String path) async {
    final savedDir = Directory(path);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _findDownloadPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
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
                                builder: (context) => BuildBottomNavigationBar(
                                  page: 1,
                                ),
                              ));
                            },
                            child: Icon(
                              Icons.arrow_back,
                            )),
                        Builder(
                          builder: (context) => InkWell(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    _chat.data.isGroup == 1
                                        ? _controllerChange.urlUsers +
                                            "DefaultGroupThumbnail.png"
                                        :_controllerChange.urlUsers + _chat.data.userList.first.profilePhoto),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _chat.data.isGroup == 1
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _chat.data.title,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                height: 15,
                                width: Get.width-180,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: _chat.data.userList.map((e) {
                                    return Text(
                                      e.firstName + " " + e.lastName + ", ",
                                      style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          )
                        : Text(
                            _chat.data.userList.first.firstName +
                                " " +
                                _chat.data.userList.first.lastName,
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
                    builder: (context) => BuildBottomNavigationBar(
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
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: message.isUpload == 1
                ? messageBox(message, isSentByMe) //voicePlayer(message)
                : Column(
                    children: [
                      Text(
                          message.ownerUser.firstName +
                              " " +
                              message.ownerUser.lastName,
                          style: TextStyle(
                              color: isSentByMe ? Colors.white : themeColor,
                              fontSize: 12)),
                      Text(
                        message.message,
                        style: TextStyle(
                            color: isSentByMe ? Colors.white : Colors.black),
                      ),
                    ],
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
          Flexible(
            child: Form(
              key: _formKey,
              child: Container(
                child: TextField(
                  minLines: 1,
                  maxLines: 4,
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
          if (isRecording) InkWell(
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
                ) else Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();

                        PickedFile image = await picker.getImage(
                            source: ImageSource.camera, imageQuality: 50);

                        MessageList _result = await _controllerChat.uploadFile(
                            header: _controllerDB.headers(),
                            chatId: _chat.data.id,
                            userId: _controllerDB.user.value.data.id,
                            file: File(image.path));

                        _controllerChat.messageSendFile(_result);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                            FilePickerResult result = await FilePicker.platform.pickFiles();

                        if(result != null) {
                          File file = File(result.files.single.path);
                          MessageList _result = await _controllerChat.uploadFile(
                              header: _controllerDB.headers(),
                              chatId: _chat.data.id,
                              userId: _controllerDB.user.value.data.id,
                              file: file);

                          _controllerChat.messageSendFile(_result);
                        }

                      },
                    ),
                  ],
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
                        String path = appDocDirectory.path + '/new';
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
                        _controllerDB.user.value.data, message);

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
    String mediaLength = recording.duration.toString().substring(2, 7);
    MessageList _result = await _controllerChat.uploadFile(
        header: _controllerDB.headers(),
        mediaLength: mediaLength,
        chatId: _chat.data.id,
        userId: _controllerDB.user.value.data.id,
        file: file);

    _controllerChat.messageSendFile(_result);

    Directory(recording.path).deleteSync(recursive: true);

    /*
     int result =await audioPlayer.play(recording.path, isLocal: true);

     f*/
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();

    advancedPlayer.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    advancedPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    advancedPlayer.onPlayerStateChanged.listen((event) {
      if (event.index != 1) {
        setState(() {
          int a;
          isPlaying = false;
          messageID = a;
          _position = Duration();
        });
      }
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  Widget voicePlayer(MessageList message, bool isSentByMe) {
    return Row(
      children: [
        Column(
          children: [
            Text(message.ownerUser.firstName + " " + message.ownerUser.lastName,
                style: TextStyle(
                    color: isSentByMe ? Colors.white : themeColor,
                    fontSize: 12)),
            SizedBox(
              height: 3,
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: Image.network(_controllerChange.urlUsers +message.ownerUser.profilePhoto)
                  .image,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              message.mediaLength ?? "",
              style: TextStyle(
                  color: isSentByMe ? Colors.white : themeColor, fontSize: 12),
            )
          ],
        ),
        InkWell(
          onTap: () async {
            if (!isPlaying) {
              setState(() {
                messageID = message.id;
                isPlaying = true;
              });
              await advancedPlayer.play(
                  _controllerChange.baseUrl + message.uploadPath.substring(1));
            } else {
              setState(() {
                isPlaying = false;
              });
              await advancedPlayer.stop();
            }
          },
          child: Icon(
            isPlaying && message.id == messageID
                ? Icons.pause
                : Icons.play_arrow,
            color: isSentByMe ? Colors.white : themeColor,
            size: 32,
          ),
        ),
        Slider(
            value: message.id == messageID
                ? _position.inMicroseconds.toDouble()
                : 0.0,
            min: 0.0,
            max: _duration.inMicroseconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                seekToSecond(value.toInt());
                value = value;
              });
            }),
      ],
    );
  }

  Widget imageMessage(MessageList message, bool isSentByMe) {
    return Column(
      children: [
        Text(message.ownerUser.firstName + " " + message.ownerUser.lastName,
            style: TextStyle(
                color: isSentByMe ? Colors.white : themeColor, fontSize: 12)),
        InkWell(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ImagePage(_imagePath, message),
            ));
          },
          child: Container(
            height: 300,
            child: Image.network(
              _controllerChange.baseUrl + message.uploadPath.substring(1),
            ),
          ),
        ),
      ],
    );
  }

  Widget fileDownload(MessageList message, bool isSentByMe) {
    return Column(
      children: [
        Row(
          children: [
            Text(message.ownerUser.firstName + " " + message.ownerUser.lastName,
                style: TextStyle(
                    color: isSentByMe ? Colors.white : themeColor,
                    fontSize: 12)),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  if (File(_downloadPath +
                          Platform.pathSeparator +
                          message.message)
                      .existsSync()) {
                    OpenFile.open(_downloadPath +
                        Platform.pathSeparator +
                        message.message);
                  } else {
                    Get.showSnackbar(GetBar(
                      duration: Duration(milliseconds: 400),
                      messageText: Text(
                        "Once Dosyayi indiriniz",
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
                  }
                },
                child: Text(message.message,
                    style: TextStyle(
                        color: isSentByMe ? Colors.white : themeColor)),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () async {
                    if (!File(_downloadPath +
                            Platform.pathSeparator +
                            message.message)
                        .existsSync()) {
                      await FlutterDownloader.enqueue(
                        url: _controllerChange.baseUrl +
                            message.uploadPath.substring(1),
                        savedDir: _downloadPath,
                      );
                      Get.showSnackbar(GetBar(
                        duration: Duration(milliseconds: 400),
                        messageText: Text(
                          "Dosya Indirildi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    } else {
                      Get.showSnackbar(GetBar(
                        duration: Duration(milliseconds: 400),
                        messageText: Text(
                          "Zaten Indirildi",
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    }
                  },
                  child: Icon(
                    File(_downloadPath +
                                Platform.pathSeparator +
                                message.message)
                            .existsSync()
                        ? Icons.download_done_outlined
                        : Icons.arrow_circle_down,
                    color: isSentByMe ? Colors.white : themeColor,
                    size: 32,
                  )),
            )
          ],
        ),
      ],
    );

    // return Text
  }

/*
  imageWithBlur(MessageList message) {
    return InkWell(
      onTap: () {
        setState(() {
          messageID = message.id;
          fileLoading = true;
        });
        FlutterDownloader.enqueue(
          url: _controllerChange.baseUrl + message.uploadPath.substring(1),

          savedDir: _imagePath,
        ).then((value) {
          setState(() {
            int a;
            messageID = a;
            fileLoading = false;
          });
        });
      },
      child: Container(
        height: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              _controllerChange.baseUrl + message.uploadPath.substring(1),
            ),
            ClipRRect(
              // Clip it cleanly.
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  alignment: Alignment.center,
                  child: Align(
                    child: fileLoading && messageID == message.id
                        ? MyCircular()
                        : Icon(
                      Icons.arrow_circle_down,
                      color: themeColor,
                      size: 55,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
*/

  Widget videoMessage(MessageList message, bool isSentByMe) {
    return Column(
      children: [
        Text(message.ownerUser.firstName + " " + message.ownerUser.lastName,
            style: TextStyle(
                color: isSentByMe ? Colors.white : themeColor, fontSize: 12)),
        InkWell(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoPlayerPage(message, _videoPath),
            ));
          },
          child: Container(
            height: 300,
            child: Center(
                child: Icon(
              Icons.play_circle_fill_rounded,
              size: 40,
              color: isSentByMe ? Colors.white : themeColor,
            )),
          ),
        ),
      ],
    );
  }

  Widget messageBox(MessageList message, bool isSentByMe) {
    String extension = p.extension(message.uploadPath);

    switch (extension) {
      case '.m4a':
        return voicePlayer(message, isSentByMe);
        break;

      case '.jpg':
        return imageMessage(message, isSentByMe);
        break;

      case '.jpeg':
        return imageMessage(message, isSentByMe);
        break;

      case '.png':
        return imageMessage(message, isSentByMe);
        break;

      case '.mp4':
        return videoMessage(message, isSentByMe);
        break;

      default:
        return fileDownload(message, isSentByMe);
        break;
    }
  }
}
