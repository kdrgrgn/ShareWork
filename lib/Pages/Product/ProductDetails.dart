import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChat.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Chat/ChatRoom.dart';
import 'package:mobi/Pages/Product/ProfilePage.dart';
import 'package:mobi/model/Product/Product.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class ProductDetails extends StatefulWidget {
  ProductData product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ControllerChat _controllerChat = Get.put(ControllerChat());
  ControllerDB _controllerDB = Get.put(ControllerDB());

  List<Widget> itemsImage = [];
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsImage = [
      InkWell(
        onTap: () {
          Get.to(ImageView(itemsImage, 0));
        },
        child: Image.network(
          "https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
          fit: BoxFit.cover,
        ),
      ),
      InkWell(
        onTap: () {
          Get.to(ImageView(itemsImage, 1));
        },
        child: Image.network(
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
          fit: BoxFit.cover,
        ),
      ),
      InkWell(
        onTap: () {
          Get.to(ImageView(itemsImage, 2));
        },
        child: Image.network(
          "https://images.unsplash.com/photo-1560343090-f0409e92791a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZHVjdHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
          fit: BoxFit.cover,
          width: Get.width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?MyCircular():Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
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

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.network(
                            widget.product.user.profilePhoto??  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          ).image,
                        ),

                        //Icon(Icons.business_sharp),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProductProfile()));
                        },
                        title: Text(widget.product.user.firstName + " " + widget.product.user.lastName),
                        subtitle: Container(child: Column(
                          children: [
                            Row(
                              children: [
                                Text(widget.product.city.name),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.grey,),
                                Text("  (71)")
                              ],
                            ),
                          ],
                        )),
                        trailing: Text(widget.product.price.toString() +  " €"),
                      ),
                    ),
                  ),
          /*        SizedBox(
                    height: 10,
                  ),   Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Az kullanilmis ayyakabi ", style: TextStyle(fontSize: 20,color: Colors.black),),
                      ),
                    ],
                  ),*/
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
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text(
                              widget.product.description,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
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
                child: InkWell(
                  onTap: (){
                    setState(() {
                      isLoading = true;
                    });
                    _controllerChat.insertChat(
                        header: _controllerDB.headers(), id: widget.product.user.id).then((value) {
                      setState(() {
                        isLoading=false;
                      });

                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => ChatRoom(
                            id: value,
                          )));
                    });


                  },
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
