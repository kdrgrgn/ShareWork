import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Animation/AnimationScreen.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../landingPage.dart';

class SplashPages extends StatefulWidget {







  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {





  int initialPage = 0;
  CarouselController _carouselController = CarouselController();
  Color background = Get.theme.backgroundColor;

  bool isLoggedIn = false;
bool isLoading =true;


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
      setState(() {
        isLoading=false;
      });

    });
  }



  @override
  Widget build(BuildContext context) {
   double height= MediaQuery.of(context).size.height;
    return isLoggedIn?Material(child: Stack(
      children: [
        LandingPage(),
        IgnorePointer(
            child: AnimationScreen(color: Theme.of(context).accentColor))
      ],
    )): Material(

        child: Stack(
            children: <Widget>[
      CarouselSlider(
          items: [
            Image.asset(
              "assets/images/splashScreen/sharework_1440x2560_1.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/splashScreen/sharework_1440X2560_2.jpg",
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/images/splashScreen/sharework_1440X2560_3.jpg",
              fit: BoxFit.cover,
            ),
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
      initialPage == 0
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
                      )))),
      initialPage == 2
          ? Align(
              alignment: Alignment(0.8, 0.885),
              child: InkWell(
                onTap: () {
                  Get.offAll(LandingPage());
                },
                child: Container(
                  padding: EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Get started",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )
          : Align(
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
            ),
      IgnorePointer(
          child: AnimationScreen(color: Theme.of(context).accentColor))
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
    if(myPrefs.getBool(key)==null){

      myPrefs.setBool(key, true);
      return false;
    }
    else{
      print("get bool 22= " + myPrefs.getBool(key).toString());

      return myPrefs.getBool(key) ?? false;

    }

  }
}
