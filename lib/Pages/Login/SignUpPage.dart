import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/widgets/GradientWidget.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ControllerDB c = Get.put(ControllerDB());
  String mail;
  String password;
  String title;
  String firstName;
  String lastName;
  Map<int, String> keyValue;

  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  ControllerChange _controllerChange = Get.put(ControllerChange());
  bool rememberMe = false;

  double selectedW = 150;
  double selectedH = 60;
  double unSelectedW = 150;
  double unselectedH = 50;

  final _formKey = GlobalKey<FormState>();
  bool isEasy = false;
  TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);

  Widget _entryField({String title, bool isPassword = false, int key}) {
    return Container(
      child: TextFormField(
        style: TextStyle(color: Colors.black, fontSize: 17),
        keyboardType: key==0?TextInputType.emailAddress:TextInputType.name,

        validator: (value) {
          if (value.isEmpty) {
            return "Doldurunuz";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          keyValue[key] = value;
          /* if (isPassword) {
            password = value;
          } else {
            mail = value;
          }*/
        },
        decoration: InputDecoration(
            labelText: title, labelStyle: TextStyle(color: themeColor)),
        obscureText: isPassword,
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        await signUp();
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 0, bottom: 0, left: 70, right: 70),
        decoration: BoxDecoration(
            gradient: MyGradientWidget().linear(),

            borderRadius: BorderRadius.circular(15)),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Login My Account",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            c.updateLoginState(true);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: background,
            size: 35,
          ),
        ),
      ],
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _entryField(title: "First Name", key: 2),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: _entryField(title: "Last Name", key: 3),
              ),
            ],
          ),
          isEasy ? Container() : _entryField(title: "title", key: 4),
          _entryField(title: "Email", key: 0),
          _entryField(title: "Password", isPassword: true, key: 1),
        ],
      ),
    );
  }

  Widget _userType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isEasy = false;
            });
          },
          child: AnimatedContainer(
            width: isEasy ? unSelectedW : selectedW,
            height: isEasy ? unselectedH : selectedH,
            duration: Duration(milliseconds: 400),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: themeColor),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 10,
                  backgroundImage: Image.network(_controllerChange.baseUrl +
                          "/newsIcons/thumbnail_ikon_7_4.png")
                      .image,
                ),
                Text("Business", style: TextStyle(fontSize: 15))
              ],
            ),
          ),
        ),
        // SizedBox(width: 50),
        InkWell(
          onTap: () {
            setState(() {
              isEasy = true;
            });
          },
          child: AnimatedContainer(
            width: isEasy ? selectedW : unSelectedW,
            height: isEasy ? selectedH : unselectedH,
            duration: Duration(milliseconds: 400),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: themeColor),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.transparent,
                  backgroundImage: Image.network(_controllerChange.baseUrl +
                          "/newsIcons/thumbnail_ikon_7_7.png")
                      .image,
                ),
                Text(
                  "Easy",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rememberMe() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (value) {
              setState(() {
                rememberMe = !rememberMe;
              });
            },
            value: rememberMe,
          ),
          Expanded(
            child: Text(
              'I Agree the terms and conditions',

              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keyValue = {
      0: mail,
      1: password,
      2: firstName,
      3: lastName,
      4: title,
    };
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/Login/login_screen-01.jpg",
              height: height,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  _createAccountLabel(),
                  SizedBox(height: 80),
                  Image.asset(
                    "assets/images/logo/sharework_logo.png",
                  ),
                  SizedBox(height: 20),
                  _userType(),
                  SizedBox(height: 20),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _rememberMe(),
                  SizedBox(height: 20),
                  _submitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("key value = " + keyValue.toString());

      if (isEasy) {
        await c.signUp(
            mail: keyValue[0],
            password: keyValue[1],
            firstName: keyValue[2],
            lastName: keyValue[3],
            rememberMe: rememberMe,
            regType: 0);
      } else {
        await c.signUp(
            mail: keyValue[0],
            password: keyValue[1],
            firstName: keyValue[2],
            lastName: keyValue[3],
            rememberMe: rememberMe,
            regType: 1,
            title: keyValue[4]);
      }
    }
  }
}
