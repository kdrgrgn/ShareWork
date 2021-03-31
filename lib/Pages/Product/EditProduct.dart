import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerProduct.dart';
import 'package:mobi/Pages/Camera/CameraPage.dart';
import 'package:mobi/model/Product/Product.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProduct extends StatefulWidget {
  ProductData product;

  EditProduct(this.product);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  List<Widget> itemsImage = [];
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerProduct _controllerProduct = Get.put(ControllerProduct());
  String description;
  String title;
  int price;
  List<File> images = [];
  List<File> newImages = [];


  @override
  void initState() {
    title = widget.product.title;
    price = widget.product.price;
    description = widget.product.description;

    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
          onTap: () {
            _showPicker(context);

          },
          child: Center(
              child: Icon(
                Icons.add_circle_outline_rounded,
                size: 32,
              )),
        ),
      ];
    });

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
                              TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      price = int.parse(value);
                                    });
                                  },
                                  style: TextStyle(color: Colors.grey),
                                  initialValue:
                                      widget.product.price.toString()),
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
                              onChanged: (value) {
                                setState(() {
                                  title = value;
                                });
                              },
                              style: TextStyle(color: Colors.grey),
                              initialValue: widget.product.title),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  description = value;
                                });
                              },
                              maxLines: 10,
                              maxLength: 500,
                              initialValue: widget.product.description,
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
            child: InkWell(
              onTap: () {
                widget.product.title = title;
                widget.product.price = price;
                widget.product.description = description;
                _controllerProduct.insertOrUpdateProduct(
                    _controllerDB.headers(), widget.product,newImages);
              },
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
            ),
          )
        ],
      ),
    );
  }


  void _showPicker(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Vazgec",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  }),
            ],
            title: Text("Resim kaynagini seciniz"),
            content: Container(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                  ],
                )),
          );
        });
  }
  _imgFromGallery() async {
    Permission.camera.request();
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      setState(() {
        images.addAll(result.paths.map((path) => File(path)).toList());
newImages.addAll(result.paths.map((path) => File(path)).toList());
        result.paths.forEach((element) {
          itemsImage.insert(itemsImage.length-1,
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: Image.file(File(element),
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                  ),
                  Align(
                      alignment: Alignment(0.5,-1),
                      child: Container(
                          color: Colors.white,
                          child: Icon(Icons.remove_circle_outline)))
                ],
              )
          );
        });


      });
    }
  }
  _imgFromCamera() async {


    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CameraPage()))
        .then((value) {
      setState(() {
        images.addAll(value);
        newImages.addAll(value);
        value.forEach((element) {
          itemsImage.insert(itemsImage.length-1,
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: Image.file(element,
                      fit: BoxFit.cover,
                      height: 190,
                    ),
                  ),
                  Align(
                      alignment: Alignment(0.5,-1),
                      child: Container(
                          color: Colors.white,
                          child: Icon(Icons.remove_circle_outline)))
                ],
              )
          );
        });

      });
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
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
          )),
    );
  }


}
