import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/landingPage.dart';

import 'package:mobi/model/User/UserData.dart';
import 'package:mobi/widgets/GradientWidget.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controller = Get.put(ControllerDB());

  List<AccountModules> modules;

  bool isLoading = true;
  File _image;

  TextStyle subStyle = TextStyle(color: Colors.grey, fontSize: 15);
  UserData user;
  ControllerChange _controllerChange = Get.put(ControllerChange());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      moduleBuilder();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        user = _controller.user.value.data;
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : GetBuilder<ControllerDB>(builder: (db) {
            return buildHomePage();
          });
  }

  buildHomePage() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
   //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Tab(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
  //    bottomNavigationBar: BuildBottomNavigationBar(),
      body: Stack(
        children: [
          Container(
            width: Get.size.width,
            height: Get.size.height,
            decoration: BoxDecoration(
                gradient: MyGradientWidget().linear(start: Alignment.centerLeft,end: Alignment.centerRight)
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              width: Get.size.width,
              height: Get.size.height - 180,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.logOut();
                          Get.offAll(LandingPage());
                        },
                        child: Container(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                                "assets/newsIcons/thumbnail_ikon_logout.png")),
                      ),
                      Container(
                          width: 30,
                          height: 30,
                          child: Stack(
                            children: [
                              Image.asset(
                                  "assets/newsIcons/ikonlar_ek_6.png"),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  /*    width: 10,
                                  height: 10,*/
                                  decoration: BoxDecoration(
                                    color: background,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "12",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(user.firstName + " " + user.lastName),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 600,
                      child: cardBuilder(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.80),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: Image.network(
                user.profilePhoto,
                fit: BoxFit.fill,
              ).image,
              radius: 60,
            ),
          )
        ],
      ),
    );
  }

  cardBuilder() {
    return ListView.builder(
      itemCount: modules.length,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      //physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: ScrollController(keepScrollOffset: true),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.only(bottom: 5, top: 5, right: 5, left: 5),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    bottomChangeProfile();
                  },
                  leading: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      modules[index].picture,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(modules[index].name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

  moduleBuilder() {
    modules = [
      AccountModules(
        picture: "assets/newsIcons/thumbnail_ikon_settings.png",
        name: "Change Profile",
      ),
      AccountModules(
        picture: "assets/newsIcons/thumbnail_ikon_settings.png",
        name: "Settings",
      ),
      AccountModules(
        picture:
            "assets/newsIcons/thumbnail_ikon_agreement.png",
        name: "Agreement",
      ),
      AccountModules(
        picture: "assets/newsIcons/thumbnail_ikon_help.png",
        name: "Help",
      ),
    ];
  }

  bottomChangeProfile() {
    String firstName;
    String lastName;
    String passWord;

    final _formKeySheet = GlobalKey<FormState>();
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Form(
              key: _formKeySheet,
              child: Container(
                height: 500,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            _showPicker(context, setState);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: _image == null
                                  ? Image.network(
                                      user.profilePhoto,
                                      fit: BoxFit.fill,
                                    ).image
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    ).image,
                              radius: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              if (_image != null) {
                               String url=await _controller.changeProfilePhoto(
                                    file: _image,
                                    header: _controller.headers());
                               setState((){
                                 user.profilePhoto=_controllerChange.urlUsers+url;

                               });
Get.back(closeOverlays: true);
                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(color: themeColor),
                              child: Center(
                                child: Text(
                                  "Save Photo",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onSaved: (value) {
                          firstName = value;
                          setState(() {
                            user.firstName = value;
                          });
                        },
                        initialValue: user.firstName,
                        decoration: buildInputDecoration(isPass: false),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onSaved: (value) {
                          lastName = value;
                          setState(() {
                            user.lastName = value;
                          });
                        },
                        initialValue: user.lastName,
                        decoration: buildInputDecoration(isPass: false),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onSaved: (value) {
                          passWord = value;
                        },
                        obscureText: true,
                        decoration: buildInputDecoration(isPass: true),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            _formKeySheet.currentState.save();

                            await _controller.updateUserInfo(
                                firstName: firstName,
                                lastName: lastName,
                                pass: passWord,
                                headers: _controller.headers(),
                                email: user.email);

                            Get.back(closeOverlays: true);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: Get.width - 20,
                            decoration: BoxDecoration(color: themeColor),
                            child: Center(
                              child: Text(
                                "SAVE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  InputDecoration buildInputDecoration({bool isPass}) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Color(0xFFF2F3F5),
        hintText: isPass ? "Password" : "");
  }

  void _showPicker(context,StateSetter setState) {
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
                    _imgFromCamera(setState);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery(setState);
                      Navigator.of(context).pop();
                    }),
              ],
            )),
          );
        });
  }

  _imgFromCamera(StateSetter setState) async {
    final picker = ImagePicker();

    PickedFile image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery(StateSetter setState) async {
    final picker = ImagePicker();

    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }
}

class AccountModules {
  String picture;
  String name;

  AccountModules({
    this.picture,
    this.name,
  });
}
