import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Animation/AnimationScreen.dart';

import '../landingPage.dart';

class SplashPages extends StatefulWidget {
  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  int initialPage = 0;
  CarouselController _carouselController = CarouselController();
  Color background = Get.theme.backgroundColor;
  @override
  Widget build(BuildContext context) {
   double height= MediaQuery.of(context).size.height;
    return Material(

        child: Stack(
            children: <Widget>[
      AbsorbPointer(
        child: CarouselSlider(
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
      ),
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
              alignment: Alignment(0, 0.9),
              child: InkWell(
                onTap: () {
                  Get.offAll(LandingPage());
                },
                child: Container(
                  padding: EdgeInsets.all(10),
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
