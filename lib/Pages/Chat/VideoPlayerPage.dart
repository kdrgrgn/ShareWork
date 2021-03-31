import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Chat/ChatMessage.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  MessageList message;
  String videoPath;

  VideoPlayerPage(this.message, this.videoPath);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _controller;
  ControllerChange _controllerChange = Get.put(ControllerChange());

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      _controllerChange.baseUrl + widget.message.uploadPath.substring(1),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.message.ownerUser.firstName +
              " " +
              widget.message.ownerUser.lastName),
          actions: [
            InkWell(
                onTap: () async {
                  await FlutterDownloader.enqueue(
                    url: _controllerChange.baseUrl +
                        widget.message.uploadPath.substring(1),
                    savedDir: widget.videoPath,
                  );

                  Get.showSnackbar(GetBar(duration: Duration(milliseconds: 400),
                    messageText: Text("Indirme Islemi Basarili",
                        style: TextStyle(color: Colors.white)),
                  ));
                },
                child: Icon(Icons.download_rounded)),
            SizedBox(width: 10,)
          ],
        ),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
