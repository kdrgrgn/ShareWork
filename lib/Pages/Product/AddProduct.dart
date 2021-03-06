import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Camera/CameraPage.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:permission_handler/permission_handler.dart';

enum OptionType { service, city, country, district }

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> categoryUrl = [
    "assets/newsIcons/thumbnail_ikon_money.png",
    "assets/newsIcons/thumbnail_ikon_shopping.png",
    "assets/newsIcons/thumbnail_ikon_food.png",
    "assets/newsIcons/thumbnail_ikon_journey.png",
    "assets/newsIcons/thumbnail_ikon_kasa.png",
    "assets/newsIcons/thumbnail_ikon_bill.png",
    "assets/newsIcons/thumbnail_ikon_fuel.png",
    "assets/newsIcons/thumbnail_ikon_rent.png",
  ];
  List<Widget> itemsImage = [];


  List<String> category = [
    "Harclik",
    "Alisveris",
    "Yemek",
    "Gezi",
    "Kasa",
    "Fatura",
    "Benzin",
    "Kira",
  ];
  List<Color> categoryColor = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.cyanAccent,
    Colors.deepPurpleAccent,
    Colors.brown,
  ];

  ControllerDB _controllerDB = Get.put(ControllerDB());
  Color background = Get.theme.backgroundColor;

  bool isLoading = true;

  List<CscData> _cityList = [];
  List<CscData> _countryList = [];
  List<CscData> _districtList = [];
  String nameCountry = "";
  String nameDistrict = "";
  String nameCity = "";
  List<File> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      itemsImage.add(
        InkWell(
          onTap: () {
            _showPicker(context);
          },
          child: Container(
            child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline_rounded,
                      size: 32,
                    ),

                    Text("Add Image")
                  ],
                )),
          ),
        ),
      );


      _controllerDB.getCountryList(_controllerDB.headers()).then((value) {
        _countryList = value.data;
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
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
                          autoPlay: false,
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          pauseAutoPlayOnTouch: true,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        )),
                  ),
                )
/*                images.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25),
                        child: InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(),
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(),
                                Text("Add Image"),
                                Icon(Icons.image),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Container(
                            height: 100,
                            width: Get.width - 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                controller:
                                    ScrollController(keepScrollOffset: false),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Container(
                                        width: 50,
                                        height: 100,
                                        child: Image.file(
                                          images[index],
                                          fit: BoxFit.cover,
                                        )),
                                  ); //categoryItem(index);
                                }),
                          ),
                          InkWell(
                              onTap: () => _showPicker(context),
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                size: 32,
                              ))
                        ],
                      )*/,
                Divider(),
                Card(
                  child: ListTile(
                    onTap: () => showCategory(),
                    title: Text("Select Category"),
                    leading: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: categoryColor[0],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Image.asset(
                              categoryUrl[0],
                              color: Colors.white,
                              width: 30,
                              height: 30,
                              //  fit: BoxFit.contain,
                            )),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_drop_down_sharp),
                  ),
                ),
                Divider(),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    color: Colors.grey[200],
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Product Title",
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    color: Colors.grey[200],
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Fiyat", border: OutlineInputBorder()),
                    ),
                  ),
                ),


                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: InkWell(
                    onTap: () {
                      selectOption(OptionType.country, context, _countryList);
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(nameCountry.isEmpty
                                ? "ulke Seciniz"
                                : nameCountry,style: TextStyle(color: Colors.grey),),
                            Icon(Icons.keyboard_arrow_down,color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: InkWell(
                    onTap: () {
                      if (_cityList.length != 0) {
                        selectOption(OptionType.city, context, _cityList);
                      }
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                                nameCity.isEmpty ? "sehir  Seciniz" : nameCity,style: TextStyle(color: Colors.grey),),
                            Icon(Icons.keyboard_arrow_down,color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: InkWell(
                    onTap: () {
                      if (_districtList.length != 0) {
                        selectOption(
                            OptionType.district, context, _districtList);
                      }
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(nameDistrict.isEmpty
                                ? "Ilce Seciniz"
                                : nameDistrict,style: TextStyle(color: Colors.grey),),
                            Icon(Icons.keyboard_arrow_down,color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),


                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Urunden bahsedin"),
                      minLines: 14,
                      maxLines: 20,
                      maxLength: 500),
                )
              ],
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
                    " Deploy Now",
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

  Widget categoryItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: categoryColor[index],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Center(
                    child: Image.asset(
                  categoryUrl[index],
                  color: Colors.white,
                  height: 40,
                  //  fit: BoxFit.contain,
                )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category[index],
            )
          ],
        ),
      ),
    );
  }

  void selectOption(
      OptionType service, BuildContext context, List<CscData> data) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
            return Container(
              height: Get.height - 150,
              width: Get.width,
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide())),
                      child: ListTile(
                        onTap: () {
                          switch (service) {
                            case OptionType.city:
                              setState(() {
                                _districtList = [];
                              });
                              break;
                            case OptionType.district:
                              setState(() {

                              });
                              break;

                            case OptionType.country:
                              setState(() {
                                _cityList = [];

                              });
                              break;

                            case OptionType.service:
                              setState(() {

                              });
                              break;
                          }
                          if (service == OptionType.country) {
                            _controllerDB
                                .getCityList(
                                    _controllerDB.headers(), data[index].id)
                                .then((value) {
                              setState(() {
                                _cityList = value.data;
                              });
                            });
                          } else if (service == OptionType.city) {
                            _controllerDB
                                .getDistrictList(
                                    _controllerDB.headers(), data[index].id)
                                .then((value) {
                              setState(() {
                                _districtList = value.data;
                              });
                            });
                          }
                          Navigator.pop(context);
                        },
                        title: Text(data[index].name),
                        trailing: Icon(/*data[index].id == idFind(service)
                            ? Icons.radio_button_on
                            :*/ Icons.radio_button_off),
                      ),
                    );
                  }),
            );
          });

  }

/*
  int idFind(OptionType type, ControllerOffice office) {
    switch (type) {
      case OptionType.city:
        return office.idCity.value;
        break;
      case OptionType.country:
        return office.idCountry.value;
        break;
      case OptionType.district:
        return office.idDistrict.value;
        break;
      case OptionType.service:
        return office.idService.value;
        break;
    }
  }
*/

  void showCategory() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: categoryUrl.length,
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemBuilder: (context, index) {
                  return categoryItem(index);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3),
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    /* final picker = ImagePicker();

    PickedFile image =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      images.add(File(image.path));
    });*/

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CameraPage()))
        .then((value) {
      setState(() {
        images.addAll(value);
        value.forEach((element) {
          itemsImage.add(
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

  _imgFromGallery() async {
    Permission.camera.request();
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      setState(() {
        images.addAll(result.paths.map((path) => File(path)).toList());

        result.paths.forEach((element) {
          itemsImage.add(
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
}
