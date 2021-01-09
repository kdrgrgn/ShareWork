
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class AddGiftPage extends StatefulWidget {
  @override
  _AddGiftPageState createState() => _AddGiftPageState();
}

class _AddGiftPageState extends State<AddGiftPage> {
    String title;
    int point;
    File _image;
    bool isLoading=false;

    final _formkey = GlobalKey<FormState>();
    Color themeColor = Get.theme.accentColor;
    Color background = Get.theme.backgroundColor;
    final ControllerDB _controller = Get.put(ControllerDB());
    Family family;


    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      family = _controller.family.value;
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add Gift"),
        ),
        bottomNavigationBar: BuildBottomNavigationBar(),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        body: isLoading?MyCircular():SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Create Gift',
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading=true;
                            });

                           if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              await _controller.insertFamilyGift(
                                familyId:family.data.id,
                                  headers: _controller.headers(),
                                  title: title,
                                  point:point,
                                  file: _image);
                            }
                            setState(() {
                              isLoading=false;
                            });
                            Get.back();

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
                    height: 5,
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
                    height: 20,
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) => value.isEmpty ? "Bos olamaz" : null,
                      onSaved: (value) {
                        point = int.parse(value);
                      },
                      decoration: buildInputDecoration(
                        'Points',
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
        ),
      );
    }




  InputDecoration buildInputDecoration(String hintText,) {
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

}

