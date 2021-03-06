import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());
  final _formKey = GlobalKey<FormState>();
  String description;

  @override
  Widget build(BuildContext context) {
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      floatingActionButton: !keyboardIsOpen
          ? null
          : Stack(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        _formKey.currentState.save();
                        if (description.isEmpty) {
                          Get.showSnackbar(GetBar(
                            message: "Bos deger olamaz",
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          _controllerOffice.description = description.obs;
                          _controllerOffice.update();

                          _controllerOffice.initialPage =
                              _controllerOffice.initialPage++;
                          _controllerOffice.update();
                          /*_controllerDB.updateUser();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => LandingPage()));*/

                        }
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        onPressed: () {
                          _controllerOffice.initialPage--;
                          _controllerOffice.update();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Kendinizden Bahsedin"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    initialValue: _controllerOffice.description.value.isEmpty
                        ? ""
                        : _controllerOffice.description.value,
                    onSaved: (value) {
                      description = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Kendninizden bahsedin"),
                    minLines: 14,
                    maxLines: 20,
                    maxLength: 500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
