import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class BudgetPage extends StatefulWidget {
  int _payerPersonId;

  BudgetPage(this._payerPersonId);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  List<int> amount = [];
  String amountValue = "";
  String title;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  List<bool> _selecetedPersonState;
  List<PersonList> _selecetedPerson = [];

  Family family;
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;

  bool isLoading = true;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  List<PersonList> _personList;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controller.family.value;

      _personList = family.data.personList;
      _selecetedPersonState = List(_personList.length);

      for (int i = 0; i < _selecetedPersonState.length; i++) {
        _selecetedPersonState[i] = false;
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      bottomNavigationBar: BuildBottomNavigationBar(),
      appBar: AppBar(title: Text("New Budget")),
      body: isLoading
          ? MyCircular()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildCirclePerson(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0, left: 25),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  title="Harclik";
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Image.network(
                                      "https://share-work.com/newsIcons/thumbnail_ikon_shopping.png",
                                      width: 25,
                                      height: 25,
                                      //  fit: BoxFit.contain,
                                    )),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("Harclik",)
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  title="Alisveris";
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Image.network(
                                      "https://share-work.com/newsIcons/thumbnail_ikon_shopping.png",
                                      width: 25,
                                      height: 25,
                                      //  fit: BoxFit.contain,
                                    )),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("Alisveris",)
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  title="Yemek";
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Image.network(
                                      "https://share-work.com/newsIcons/thumbnail_ikon_shopping.png",
                                      width: 25,
                                      height: 25,
                                      //  fit: BoxFit.contain,
                                    )),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("Yemek",)
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  title="Gezi";
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(child: Image.network(
                                      "https://share-work.com/newsIcons/thumbnail_ikon_shopping.png",
                                      width: 25,
                                      height: 25,
                                      //  fit: BoxFit.contain,
                                    )),
                                  ),
                                  SizedBox(height: 5,),
                                  Text("Gezi",)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 10),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          onSaved: (value) {
                            if(value.isNotEmpty) {
                              title = value;
                            }
                          },
                          validator: (value) {
                            if (title.isEmpty) {
                              return "Bos birakilamaz";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: title??" Enter Title",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 40, bottom: 50),
                      child: InkWell(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(amountValue.length == 0
                                        ? "Enter Amaount"
                                        : amountValue),
                                    Text("€"),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 12,
                                thickness: 2,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          keyboardBottomSheet();
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  child: InkWell(
                    onTap: () {
                      insertBudget();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: background,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }


  insertBudget(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      List<Map<String, int>> personId = [];

      for (PersonList i in _selecetedPerson) {
        personId.add({"Id": i.id});
      }

      _controller.insertFamilyBudgetItem(
          headers: _controller.headers(),
          familyId: family.data.id,
          payerPerson: widget._payerPersonId,
          title: title,
          amount: int.parse(amountValue),
          personList: personId);

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("İşlem Başarılı!!!"),
          behavior: SnackBarBehavior.floating,
        ),
      );

      setState(() {
        _selecetedPerson = [];
        for (int i = 0;
        i < _selecetedPersonState.length;
        i++) {
          _selecetedPersonState[i] = false;
        }
        Get.back();
      });
    }
  }


  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _personList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (widget._payerPersonId != _personList[index].id) {
                  if (_selecetedPersonState[index]) {
                    setState(() {
                      _selecetedPersonState[index] = false;
                      _selecetedPerson.remove(_personList[index]);
                    });
                  } else {
                    setState(() {
                      _selecetedPersonState[index] = true;
                      _selecetedPerson.add(_personList[index]);
                    });
                  }
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: _selecetedPersonState[index] ? 40 : 30,
                    backgroundColor: Colors.white,
                    backgroundImage: Image.network(_controllerChange.urlUsers +
                            _personList[index].user.profilePhoto)
                        .image,
                  ),
                  _selecetedPersonState[index]
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.check_box,
                            color: Colors.green,
                            size: 20,
                          ),
                        )
                      : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  keyboardBottomSheet() {
    double size = 25;
    TextStyle _boardStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        enableDrag: false,
        barrierColor: Colors.transparent,
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
              color: Colors.cyan,
            ),
            child: Wrap(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 8, right: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              updateAmount(1);
                            },
                            child: CircleAvatar(
                                radius: size,
                                child: Text(
                                  "1",
                                  style: _boardStyle,
                                ),
                                backgroundColor: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(2);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "2",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(3);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "3",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              updateAmount(4);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "4",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(5);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "5",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(6);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "6",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              updateAmount(7);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "7",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(8);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "8",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(9);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "9",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: size,
                            backgroundColor: Colors.transparent,
                          ),
                          InkWell(
                            onTap: () {
                              updateAmount(0);
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Text(
                                "0",
                                style: _boardStyle,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              deleteAmount();
                            },
                            child: CircleAvatar(
                              radius: size,
                              child: Icon(
                                Icons.backspace_sharp,
                                color: themeColor,
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(onTap: (){
                      insertBudget();
                    },
                      child: Container(
                        decoration: BoxDecoration(
                          /*  borderRadius:
                                BorderRadius.vertical(bottom: Radius.circular(10)),*/
                            color: background),
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  updateAmount(int value) {
    amountValue = "";

    setState(() {
      amount.add(value);
      for (int i = 0; i < amount.length; i++) {
        amountValue = amountValue + amount[i].toString();
      }
    });
  }

  deleteAmount() {
    amountValue = "";

    setState(() {
      if (amount.length == 0) {
      } else {
        amount.removeLast();
        for (int i = 0; i < amount.length; i++) {
          amountValue = amountValue + amount[i].toString();
        }
      }
    });
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }
}
