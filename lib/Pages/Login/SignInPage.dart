import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Login/rememberMeControl.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ControllerDB c = Get.put(ControllerDB());

  String mail ;
  String password ;
  Color themeColor = Get.theme.accentColor;
  final _formKey = GlobalKey<FormState>();
  bool isMail = false;
  bool isPass = false;
  bool rememberMe = false;
  TextStyle buttonStyle = TextStyle(color: Colors.white, fontSize: 16);

  Widget _entryField({String title, bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: isPassword?TextInputType.visiblePassword:TextInputType.emailAddress,
        onTap: () {
          if (isPassword) {
            setState(() {
              isPass = true;
              isMail = false;
            });
          } else {
            setState(() {
              isMail = true;
              isPass = false;
            });
          }
        },
        style: TextStyle(color: Colors.black, fontSize: 17),
        validator: (value) {
          if (value.isEmpty) {
            return "Doldurunuz";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          if (isPassword) {
            password = value;
          } else {
            mail = value;
          }
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

       await signIn();
      },
      child: Material(
        color: themeColor,
        borderRadius: BorderRadius.circular(25),
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

  Widget _registerButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: (){
          c.updateLoginState(false);
        },
        child: Material(
          color: Colors.transparent,

          borderRadius: BorderRadius.circular(25),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Create a new account",
                  style: TextStyle(fontSize: 20, color:themeColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await c.signIn(mail: mail, password: password,rememberMe:rememberMe);
    }
  }

  Future signInRememberMe(List<String> signInfo) async {

    await c.signIn(mail: signInfo[0], password: signInfo[1],rememberMe:false);

  }

  Widget _createAccountLabel() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Text(
              'Forgot Password ? ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
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

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.grey[50],
        child: Column(
          children: <Widget>[
            Container(
                decoration: isMail
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(),
                child: _entryField(title: "Email")),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: isPass
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : BoxDecoration(),
                child: _entryField(title: "Password", isPassword: true)),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) async {

 List<String> temp= await RememberMeControl.instance.getRemember("login");
 if(temp!=null){
   signInRememberMe(temp);

 }

});


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
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    "assets/images/logo/sharework_logo.png",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _emailPasswordWidget(),
                  SizedBox(
                    height: 25,
                  ),

                  _rememberMe(),
                  SizedBox(
                    height: 30,
                  ),
                  _submitButton(),
                  SizedBox(
                    height: 20,
                  ),
                  _createAccountLabel(),

                  SizedBox(
                    height: 50,
                  ),
                  _registerButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
