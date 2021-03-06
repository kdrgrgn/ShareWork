import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfficeDetailsPage extends StatefulWidget {
  @override
  _OfficeDetailsPageState createState() => _OfficeDetailsPageState();
}

class _OfficeDetailsPageState extends State<OfficeDetailsPage>    with SingleTickerProviderStateMixin {
  List<Widget> itemsImage = [];


  List<Widget> listTab = [
    Tab(icon: Text("Description")),
    Tab(icon: Text("Info")),
  ];

/*  List<String> productUrl = [
    "http://sindevo.com/blix/preview/images/main.png",
    "http://sindevo.com/blix/preview/images/green.png",
    "http://sindevo.com/blix/preview/images/red.png",

  ];*/

  int currentTab = 0;
  TabController _controller;
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: listTab.length, vsync: this);

    itemsImage = [
      InkWell(
        onTap: () {
          Get.to(ImageView(itemsImage, 0));
        },
        child: Image.network(
          "http://sindevo.com/blix/preview/images/main.png",
          fit: BoxFit.cover,
        ),
      ),
      InkWell(
        onTap: () {
          Get.to(ImageView(itemsImage, 1));
        },
        child: Image.network(
          "http://sindevo.com/blix/preview/images/green.png",
          fit: BoxFit.cover,
        ),
      ),
      InkWell(
        onTap: () {
          Get.to(ImageView(itemsImage, 2));
        },
        child: Image.network(
          "http://sindevo.com/blix/preview/images/red.png",
          fit: BoxFit.cover,
          width: Get.width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pin Software"),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: Get.height,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width,
                      child: CarouselSlider(
                          items: itemsImage,
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.4,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            pauseAutoPlayOnTouch: true,
                            autoPlayInterval: Duration(seconds: 5),
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ),
                /*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isInfo = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isInfo
                                        ? Colors.white
                                        : Colors.grey[300],
                                    border: Border.all()),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Info"),
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isInfo = false;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color:
                                      !isInfo ? Colors.white : Colors.grey[200],
                                ),
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Description"),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  Container(
                    height: 60,
                    child: TabBar(
                      onTap: (index) {
                        currentTab = index;
                      },
                      labelStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      controller: _controller,
                      indicatorColor: background,
                      labelColor: themeColor,
                      tabs: listTab,
                    ),
                  ),
                  Container(
                      height: 400,
                    width: Get.width,
                    child: TabBarView(
                      dragStartBehavior: DragStartBehavior.start,
                      physics: NeverScrollableScrollPhysics(),
                      controller: _controller,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
                                " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea"
                                " commodo consequat. "
                                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore"
                                " eu fugiat nulla pariatur. "
                                "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui"
                                " officia deserunt mollit anim id est laborum.",
                            style: TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                        cardBuilder(),

                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
/*                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.accentColor, width: 6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isInfo
                            ? cardBuilder()
                            : Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
                                " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea"
                                " commodo consequat. "
                                "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore"
                                " eu fugiat nulla pariatur. "
                                "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui"
                                " officia deserunt mollit anim id est laborum.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                      ),
                    ),
                  )*/
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, top: 10),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Get.theme.backgroundColor,
                //  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Contact Now",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cardBuilder() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: TextStyle(color: Colors.black),
                ),
                Text("info@pin.com"),
              ],
            ),
          ),        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Country",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Turkiye"),
              ],
            ),
          ),        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "City",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Istanbul"),
              ],
            ),
          ),        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "District",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Kadikoy"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone",
                  style: TextStyle(color: Colors.black),
                ),
                Text("0216223681"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Location",
                  style: TextStyle(color: Colors.black),
                ),
                Text("Turkiye"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  List<Widget> items;
  int initialPage;

  ImageView(this.items, this.initialPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
      ),
      body: CarouselSlider(
          items: items,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: initialPage,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
