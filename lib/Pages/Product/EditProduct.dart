import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  List<Widget> itemsImage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsImage = [
      Stack(
        children: [
          InkWell(
            onTap: () {
              Get.to(ImageView(itemsImage, 0));
            },
            child: Image.network(
              "https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  color: Colors.white,
                  child: Icon(Icons.remove_circle_outline)))
        ],
      ),
      Stack(
        children: [
          InkWell(
            onTap: () {
              Get.to(ImageView(itemsImage, 1));
            },
            child: Image.network(
              "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  color: Colors.white,
                  child: Icon(Icons.remove_circle_outline)))
        ],
      ),
      Stack(
        children: [
          InkWell(
            onTap: () {
              Get.to(ImageView(itemsImage, 2));
            },
            child: Image.network(
              "https://images.unsplash.com/photo-1560343090-f0409e92791a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  color: Colors.white,
                  child: Icon(Icons.remove_circle_outline)))
        ],
      ),
      InkWell(
        onTap: () {},
        child: Center(
            child: Icon(
          Icons.add_circle_outline_rounded,
          size: 32,
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
title: Text("Edit your product"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
                            height: 260,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                         // color: Colors.grey[200],
                          /*  decoration: BoxDecoration(
                        border:
                        Border.all(color: Get.theme.accentColor, width: 6),
                      ),*/
                          child: Column(
                            children: [
                              TextFormField(   //   decoration: InputDecoration(border: OutlineInputBorder()),
                                  style: TextStyle(color: Colors.grey),initialValue: "1000 €"),
                              SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                     // color: Colors.grey[200],
                      /*  decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.accentColor, width: 6),
                      ),*/
                      child: Column(
                        children: [
                          TextFormField(
                  //    decoration: InputDecoration(border: OutlineInputBorder()),
                              style: TextStyle(color: Colors.grey),
                              initialValue: "Az kullanilmis Ayakkabi"),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  )
                  /*      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Az kullanilmis ayyakabi ",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),

                    ],
                  ),*/
                  ,
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      /*  decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.accentColor, width: 6),
                      ),*/
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              maxLines: 10,
                              maxLength: 500,
                              initialValue:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
                                  " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                  "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea"
                                  " commodo consequat. "
                                  "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore"
                                  " eu fugiat nulla pariatur. "
                                  "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui"
                                  " officia deserunt mollit anim id est laborum.",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                    "Edit Now",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          )
        ],
      ) /*Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
                            height: 325,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.4,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            pauseAutoPlayOnTouch: true,
                            autoPlayInterval: Duration(seconds: 5),
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: "1000",
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "€",
                              ))
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: "Az kullanilmis ayakkabi",
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      */ /*  decoration: BoxDecoration(
                        border:
                            Border.all(color: Get.theme.accentColor, width: 6),
                      ),*/ /*
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              maxLines: 10,
                              maxLength: 500,
                              initialValue:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
                                  " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                  "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea"
                                  " commodo consequat. "
                                  "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore"
                                  " eu fugiat nulla pariatur. "
                                  "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui"
                                  " officia deserunt mollit anim id est laborum.",

                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                    "Edit Now",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          )
        ],
      )*/
      ,
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
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          )),
    );
  }
}
