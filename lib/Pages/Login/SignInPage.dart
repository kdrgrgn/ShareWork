import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';

import 'SignUpPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final ControllerDB c = Get.put(ControllerDB());

  String mail="o1@o1.com";
  String password="123";
  Color themeColor=Get.theme.accentColor;
  final _formKey = GlobalKey<FormState>();
  bool saveUser = false;
  TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);


  Widget _entryField({String title,bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: isPassword?password:mail,
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
        Text("Sign In",style: TextStyle(fontSize: 30),),
InkWell(
  onTap: () async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await c.signIn(mail: mail, password: password);
    }
  },
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: (){
              Get.offAll(SignUpPage());

            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: themeColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: Text('Forgot Password ?',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }


  Widget _emailPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 40,right: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _entryField(title:"Email id"),
            _entryField(title:"Password", isPassword: true),
          ],
        ),
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
                      Image.asset(
                        "assets/images/logo/sharework_logo.png",
                        width: 180,
                      ),
                  SizedBox(height: 20),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                      _submitButton(),


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






/*{
  final ControllerDB c = Get.put(ControllerDB());
  String mail;
  String password;
  Color themeColor;
  final _formKey = GlobalKey<FormState>();
  bool saveUser = false;
  TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
SizedBox(height: 100,),
              Image.asset(
              "assets/images/logo/sharework_logo.png",
              height: 180,
              width: 180,
            ),

                TextFormField(
                  initialValue: "o1@o1.com",
                  validator: (value){
                    if(value.isEmpty){
                      return "Doldurunuz";
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    mail = value;
                  },
                  cursorColor: themeColor,
                  decoration: InputDecoration(
                      labelText: "Mail",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      suffixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: themeColor,
                        size: 40,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Doldurunuz";
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                  initialValue: "123",
                  obscureText: true,
                  cursorColor: themeColor,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      suffixIcon: Icon(
                        Icons.lock_outlined,
                        color: themeColor,
                        size: 40,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (value) {
                        setState(() {
                          saveUser = value;
                        });
                      },
                      value: saveUser,
                    ),
                    Text(
                      "Save User & password",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text("Register", style: buttonStyle),
                        ),
                        color: themeColor,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text("Oturum aç", style: buttonStyle),
                        ),
                        color: themeColor,
                        onPressed: () async {
                          if(_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await c.signIn(mail: mail, password: password);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(child: Text("Passwort vergesen?"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/