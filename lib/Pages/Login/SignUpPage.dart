import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';

import 'package:mobi/Pages/Login/SignInPage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final ControllerDB c = Get.put(ControllerDB());
  String mail;
  String password;
  Color themeColor=Get.theme.accentColor;
  final _formKey = GlobalKey<FormState>();
  bool saveUser = false;
  TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);


  Widget _entryField({String title,bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value){
          if(value.isEmpty){
            return "Doldurunuz";
          }
          else{
            return null;
          }
        },
        onSaved: (value){
          if(isPassword){
            password=value;
          }
          else{
            mail=value;
          }
        },
        decoration: InputDecoration(
            labelText: title
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _submitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Sign Up",style: TextStyle(fontSize: 30),),
        InkWell(

          child:   CircleAvatar(
            backgroundColor: themeColor ,
            radius: 40  ,
            child: Icon(
              Icons.arrow_forward,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }



  Widget _createAccountLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () {
            Get.offAll(SignInPage());
          },
          child: Text(
            'Sign In',
            style: TextStyle(
                color: themeColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        Container()

      ],
    );
  }


  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _entryField(title:"Name"),
          _entryField(title:"Email id"),
          _entryField(title:"Password", isPassword: true),
        ],
      ),
    );
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
                  "assets/images/Login/1440x2560_5.jpg",
                  height: height,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .25),
                      Image.asset(
                        "assets/images/logo/sharework_logo.png",
                        width: 180,
                      ),
                      SizedBox(height: 20),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      _submitButton(),
                      SizedBox(height: 50),

                      _createAccountLabel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
