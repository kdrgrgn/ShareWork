import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Animation/AnimationScreen.dart';
import 'package:mobi/widgets/GradientWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../landingPage.dart';

class SplashPages extends StatefulWidget {
  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  int initialPage = 0;
  CarouselController _carouselController = CarouselController();
  Color background = Get.theme.backgroundColor;
  VideoPlayerController _controller1;
  VideoPlayerController _controller2;
  VideoPlayerController _controller3;

  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MySharedPreferences.instance
          .getBooleanValue("isfirstRun")
          .then((value) => setState(() {
                isLoggedIn = value;
              }));

      /*     _controller1 = VideoPlayerController.asset(
        "assets/images/splashScreen/video1.pm4",
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });


      _controller2 = VideoPlayerController.asset(
        "assets/images/splashScreen/video1.pm4",
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });

      _controller3 = VideoPlayerController.asset(
        "assets/images/splashScreen/video1.pm4",
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      _controller1.play();
      _controller2.play();
      _controller3.play();
*/
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return isLoggedIn
        ? Material(
            child: Stack(
            children: [
              LandingPage(),
              IgnorePointer(
                  child: AnimationScreen(color: Theme.of(context).accentColor))
            ],
          ))
        : Material(
            child: Stack(children: <Widget>[
            CarouselSlider(
                items: [
                 /* SplashVideo("assets/images/splashScreen/video1.pm4"),
                  SplashVideo("assets/images/splashScreen/video1.pm4"),
                  SplashVideo("assets/images/splashScreen/video1.pm4"),*/
                  Container(),
                  Container(),
                  Container(),

                ],
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1,
                  initialPage: initialPage,
                  enableInfiniteScroll: false,
                  reverse: false,
                  onPageChanged: (i, r) {
                    setState(() {
                      initialPage = i;
                    });
                  },
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
         /*   initialPage == 0
                ? Container()
                : Align(
                    alignment: Alignment(-0.8, 0.9),
                    child: InkWell(
                        onTap: () {
                          _carouselController.previousPage();
                        },
                        child: CircleAvatar(
                            backgroundColor: background,
                            radius: 30,
                            child: Icon(
                              Icons.arrow_back,
                              size: 40,
                              color: Colors.white,
                            )))),*/
            initialPage == 2
                ? Align(
                    alignment: Alignment(0,0.9),
                    child: InkWell(
                      onTap: () {
                        Get.offAll(LandingPage());
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 80, right: 80),
                        decoration: BoxDecoration(
                          gradient: MyGradientWidget().linear(),

                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "Get started",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                :Container() /*Align(
                    alignment: Alignment(0.8, 0.9),
                    child: InkWell(
                        onTap: () {
                          _carouselController.nextPage();
                        },
                        child: CircleAvatar(
                            backgroundColor: background,
                            radius: 30,
                            child: Icon(
                              Icons.arrow_forward,
                              size: 40,
                              color: Colors.white,
                            ))),
                  )*/,
              Align(
                alignment: Alignment(0,0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0,1,2].map((url) {
                    int index = [0,1,2].indexOf(url);
                    return Container(
                      width: index == initialPage ? 15 : 10.0,
                      height: index == initialPage ? 15 : 10.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          initialPage == index ? background : Colors.grey),
                    );
                  }).toList(),
                ),
              ),
            IgnorePointer(
                child: AnimationScreen(color: Theme.of(context).accentColor)),

          ]));
  }
}

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
      MySharedPreferences._privateConstructor();

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    print("get bool = " + myPrefs.getBool(key).toString());
    if (myPrefs.getBool(key) == null) {
      myPrefs.setBool(key, true);
      return false;
    } else {
      print("get bool 22= " + myPrefs.getBool(key).toString());

      return myPrefs.getBool(key) ?? false;
    }
  }
}

class SplashVideo extends StatefulWidget {
  String path;

  SplashVideo(this.path);

  @override
  _SplashVideoState createState() => _SplashVideoState();
}

class _SplashVideoState extends State<SplashVideo> {
  VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();

      _controller = VideoPlayerController.network(
        "https://dm0qx8t0i9gc9.cloudfront.net/watermarks/video/B2b8RSzfgivu3v9nb/coming-soon-message-illuminated-with-light-projector-realistic-business-new-product-internet-promotion-splash-screen-with-moving-spotlight-available-in-4k-uhd-fullhd-and-hd-3d-video-animation-footage___09b9327d8778b57644e4d54a9db837a9__P360.mp4",
      )..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
      _controller.setLooping(true);

  /*    _controller.addListener(() {
        setState(() {});
      });

      print("girdi 1");
      await _controller.setLooping(true);
      print("girdi 2");

      _controller.initialize().then((_) =>  setState(() {
        print("girdi 3");
         _controller.play();
        print("girdi 4" );


        //  print("inittiiilaziee" + _controller.value.isInitialized.toString());

      }));

      print("girdi 3.5");

*/


  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? Container(
            width: Get.width,
            height: Get.height,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
/*        floatingActionButton: FloatingActionButton(
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
        )*/
      ),
    );
  }

}
