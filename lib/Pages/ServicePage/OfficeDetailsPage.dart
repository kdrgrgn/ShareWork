import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/model/Services/Services.dart';
import 'package:mobi/widgets/ButtonGradient.dart';
import 'package:mobi/widgets/CircleGradient.dart';
import 'package:mobi/widgets/GradientWidget.dart';

class OfficeDetailsPage extends StatefulWidget {
  ServiceData data;

  OfficeDetailsPage(this.data);

  @override
  _OfficeDetailsPageState createState() => _OfficeDetailsPageState();
}

class _OfficeDetailsPageState extends State<OfficeDetailsPage>
    with SingleTickerProviderStateMixin {
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
      body: Column(
        children: [
          Flexible(
            child: Container(
              height: Get.height,
              decoration: BoxDecoration(
                  gradient: MyGradientWidget().linear(
                      end: Alignment.topCenter,
                      start: Alignment(0, -0.2),
                      startColor: Colors.white)),
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(onTap:(){
                            Navigator.pop(context);
                          },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(onTap:(){
                            Navigator.pop(context);
                          },child: Icon(Icons.more_horiz,color: Colors.white,)),
                        ),
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: 200,
                      width: Get.width-100,
                      child: Image.network(
                        "https://i.pinimg.com/originals/3f/3d/d9/3f3dd9219f7bb1c9617cf4f154b70383.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),



                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                             widget.data.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                        Icon(Icons.star,color: Colors.yellow,),
                          Text("   4.9",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ),  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:12.0),
                          child: Text(
                            // widget.data.city.name
                                 "Istanbul  ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                ),
                          ),
                        ),
                        Icon(Icons.location_on_sharp,color: Colors.grey,)
                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
 Padding(
   padding: const EdgeInsets.all(12.0),
   child: Container(
     child: Text(
       "Lorem ipsum dolor sit amet, consectetur adipiscing elit,"
           " sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
           "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea"
           " commodo consequat. "
           "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore"
           " eu fugiat nulla pariatur. "
           "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui"
           " officia deserunt mollit anim id est laborum.",
       //widget.data.description,
       style: TextStyle(
           color: Colors.grey,
         ),
     ),
   ),
 ),

                    SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        child: CarouselSlider(
                            items: itemsImage,
                            options: CarouselOptions(
                              height: 220,
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
                    )
                  ],
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, top: 10,right: 30,left: 30),
            child: InkWell(
              onTap: (){
                infoContact();
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: MyGradientWidget().linear(),
                  color: Get.theme.backgroundColor,
                    borderRadius: BorderRadius.circular(20)
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
            ),
          )
        ],
      ),
    );
  }

  Widget cardBuilder() {
    return Container(
      child: Text("infoooo"),
    );
    /*Padding(
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
                Text( widget.data.country.name??"ulke"),
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
                Text( widget.data.city.name??"ulke"),
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
                Text( widget.data.district.name??"ulke"
                ),
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
                Text( widget.data.country.name??"ulke"),
              ],
            ),
          ),
        ],
      ),
    );*/
  }

  infoContact() {
    showModalBottomSheet(   shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context, builder: (context){
      return Container(
        height: 350,
        child: Column(children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleGradientContainer(Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.mail_outline,color: Colors.white,size: 32,),
                )),
              ),
  Expanded(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20,20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: themeColor.withOpacity(0.2)

        ),
        child: Center(child: Text("info@pinSoftware.com")),
      ),
    ),
  ),

            ],
          )      ,    Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleGradientContainer(Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.phone,color: Colors.white,size: 32,),
                )),
              ),
  Expanded(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 20,20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: themeColor.withOpacity(0.2)

        ),
        child: Center(child: Text("0 555 555 55 55")),
      ),
    ),
  ),

            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: Get.width,
              child: ButtonGradient(Padding(
                padding: EdgeInsets.fromLTRB(0, 20,0, 20),
                child: Center(child: Text("Sohbet Başlatın",style: TextStyle(color: Colors.white),)),
              )),
            ),
          )

        ],),
      );
        });

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
