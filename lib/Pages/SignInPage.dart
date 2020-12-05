import 'package:flutter/material.dart';

import 'Dashboard.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Color themeColor;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                        "assets/images/logo/png logo/256h/Artboard 1.png",height: 180,
                    width: 180,),
                    Image.asset(
                        "assets/images/logo/png txt/256h/Artboard 1.png",height: 100,),
                  ],
                ),
                TextFormField(
                  cursorColor: themeColor,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide()),
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
                  obscureText: true,
                  cursorColor: themeColor,
                  decoration: InputDecoration(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("  Register  ", style: buttonStyle),
                      ),
                      color: themeColor,
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("  Oturum aç  ", style: buttonStyle),
                      ),
                      color: themeColor,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Dashboard()));
                      },
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
