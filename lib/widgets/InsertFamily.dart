import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class InsertFamilyWidget extends StatefulWidget {
  @override
  _InsertFamilyWidgetState createState() => _InsertFamilyWidgetState();
}

class _InsertFamilyWidgetState extends State<InsertFamilyWidget> {
  File _image;
  String title;
  int age;
  bool isLoading=false;
  final _formkey = GlobalKey<FormState>();
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerFamily _controllerFamily = Get.put(ControllerFamily());
  final ControllerDB _controllerDB = Get.put(ControllerDB());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading?MyCircular():Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Create Family',
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading=true;
                        });

                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();
                          await _controllerFamily.createFamily(
                              headers: _controllerDB.headers(),
                              title: title,
                              file: _image);
                        }
                        setState(() {
                          isLoading=false;
                        });

                      },
                      child: Material(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.transparent,
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              //   color: Colors.transparent,
                              width: 50,
                              height: 50,
                              child: Image.network(
                                "https://share-work.com/newsIcons/ikon_foto.png",
                                fit: BoxFit.contain,
                              ),
                            )
                      /*Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 50,
                        height: 50,

                        child: Image.network("https://share-work.com/newsIcons/ikon_foto.png"),
                      )*/
                      ,
                    ),
                  ),
                  _image != null
                      ? Text("")
                      : Text(
                          "Resim Sec",
                          style: TextStyle(fontSize: 15),
                        ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  validator: (value) => value.isEmpty ? "Bos olamaz" : null,
                  onSaved: (value) {
                    title = value;
                  },
                  decoration: buildInputDecoration(
                    'Title',
                  ),
                ),
              ),

/*              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) => value.isEmpty ? "Bos olamaz" : null,
                onSaved: (value){
                  age=int.parse(value);
                },
                decoration: buildInputDecoration(
                  'Age',
                ),
              )*/
            ],
          ),
        ),
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

  _imgFromCamera() async {
    final picker = ImagePicker();

    PickedFile image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    final picker = ImagePicker();

    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image.path);
    });
  }

  InputDecoration buildInputDecoration(
    String hintText,
  ) {
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
      hintStyle: TextStyle(
        color: Color(0xFF666666),
      ),
      hintText: hintText,
    );
  }
}
