import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class AddUserPage extends StatefulWidget {
//  Family family;

// AddUserPage(this.family);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String firstName;
  String lastName;
  String email;
  int age;
  String phone;
  final _formkey = GlobalKey<FormState>();
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controller = Get.put(ControllerDB());
  Family family;
  bool isLoading=false;

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
        title: Text("Add Person"),
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
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        if (_formkey.currentState.validate()) {
                          _formkey.currentState.save();

                          setState(() {
                            isLoading=true;
                          });
                          await _controller.addPerson(
                              headers: _controller.headers(),
                              email: email,
                              phone: phone,
                              firstName: firstName,
                              lastName: lastName,
                              familyId: family.data.id,
                              age: age);

                          setState(() {
                            isLoading=false;
                          });

                          Get.back();
                        }
                      },
                      child: Material(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  TextFormField(
                    validator: (value) =>
                    value.isEmpty ? "Bos olamaz" : null,
                    onSaved: (value) {
                      firstName = value;
                    },
                    decoration: buildInputDecoration(
                      'First Name',
                    ),
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    validator: (value) =>
                    value.isEmpty ? "Bos olamaz" : null,
                    onSaved: (value) {
                      lastName = value;
                    },
                    decoration: buildInputDecoration(
                      'Last Name',
                    ),
                  ),

                  SizedBox(height: 30,),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value.isEmpty ? "Bos olamaz" : null,
                    onSaved: (value) {
                      email = value;
                    },
                    decoration: buildInputDecoration(
                      'Mail',
                    ),
                  ),
                  SizedBox(height: 30,),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              value.isEmpty ? "Bos olamaz" : null,
                          onSaved: (value) {
                            phone = value;
                          },
                          decoration: buildInputDecoration(
                            'Phone',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? "Bos olamaz" : null,
                          onSaved: (value) {
                            age = int.parse(value);
                          },
                          decoration: buildInputDecoration(
                            'Age',
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
