import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/Budget/BudgetListPage.dart';
import 'package:mobi/Pages/Family/FamilyTabBar.dart';
import 'package:mobi/model/Family/Budget/Budget.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class BudgetPage extends StatefulWidget {
  BudgetData budgetData;

  BudgetPage({this.budgetData});

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
  List<bool> categoryState = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> category = [
    "Harclik",
    "Alisveris",
    "Yemek",
    "Gezi",
    "Kasa",
    "Fatura",
    "Benzin",
    "Kira",
  ];
  List<String> categoryUrl = [
    "assets/newsIcons/thumbnail_ikon_money.png",
    "assets/newsIcons/thumbnail_ikon_shopping.png",
    "assets/newsIcons/thumbnail_ikon_food.png",
    "assets/newsIcons/thumbnail_ikon_journey.png",
    "assets/newsIcons/thumbnail_ikon_kasa.png",
    "assets/newsIcons/thumbnail_ikon_bill.png",
    "assets/newsIcons/thumbnail_ikon_fuel.png",
    "assets/newsIcons/thumbnail_ikon_rent.png",
  ];
  BudgetData _budgetData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controller.family.value;

      _personList = family.data.personList;
      _selecetedPersonState = List(_personList.length);
      int i = 0;

      if (widget.budgetData != null) {
        _budgetData = await _controller.getFamilyBudgetItem(
            headers: _controller.headers(), id: widget.budgetData.id);
        print("budgettt = " + _budgetData.toString());

        amountValue = _budgetData.amount.toString();
        title = _budgetData.title;

        _personList.forEach((person) {
          if (_budgetData == null) {
            _selecetedPersonState[i] = false;
          } else {
            if (_budgetData.personList == null) {
              _selecetedPersonState[i] = false;
            } else {
              bool temp = false;
              _budgetData.personList.forEach((element) {
                if (element.id == person.id) {
                  temp = true;
                  _selecetedPerson.add(element);
                }
              });
              _selecetedPersonState[i] = temp;
            }
          }
          i++;
        });
      } else {
        int i = 0;
        _selecetedPersonState.forEach((person) {
          _selecetedPersonState[i] = false;
          i++;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("gett bool = " + Get.isBottomSheetOpen.toString());
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
   //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      //bottomNavigationBar: BuildBottomNavigationBar(),
      appBar: AppBar(title: Text("New Budget")),
      body: isLoading
          ? MyCircular()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildCirclePerson(),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0, left: 25),
                      child: Container(
                        width: double.infinity,
                        height: 75,
                        child: budgetTitle(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 10),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          onSaved: (value) {
                            if (value.isNotEmpty) {
                              title = value;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: title ?? " Enter Title",
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
                          Get.bottomSheet(
                            keyboardBottomSheet(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0))),
                            isScrollControlled: true,
                            enableDrag: false,
                            barrierColor: Colors.transparent,
                            useRootNavigator: false,
                          );
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

  insertBudget() {
    _formKey.currentState.save();

    List<Map<String, int>> personId = [];

    for (PersonList i in _selecetedPerson) {
      personId.add({"Id": i.id});
    }
    print("title = " + title);

    if (widget.budgetData == null) {
      int id;
      family.data.personList.forEach((element) {
        if (element.user.id == _controller.user.value.data.id) {
          id = element.id;
        }
      });

      _controller.insertFamilyBudgetItem(
          headers: _controller.headers(),
          familyId: family.data.id,
          payerPerson: id,
          title: title,
          amount: int.parse(amountValue),
          personList: personId);
    } else {
      _controller.editFamilyBudgetItem(
          headers: _controller.headers(),
          budgetItemId: _budgetData.id,
          payerPerson: _budgetData.payerPerson.id,
          title: title,
          amount: int.parse(amountValue),
          personList: personId);
    }
    setState(() {
      _selecetedPerson = [];
      for (int i = 0; i < _selecetedPersonState.length; i++) {
        _selecetedPersonState[i] = false;
      }
if(Get.isBottomSheetOpen){
  print("accikkk haa");
  Get.back(closeOverlays: false);

}

      Get.back(closeOverlays: false);
    });
  }

  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 85,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _personList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Container(
                width: 60,
                child: InkWell(
                  onTap: () {
                    if (widget.budgetData != null) {
                      if (widget.budgetData.payerPerson.id !=
                          _personList[index].id) {
                        if (_selecetedPersonState[index]) {
                          setState(() {
                            _selecetedPersonState[index] = false;
                            _selecetedPerson.removeWhere((element) =>
                                element.id == _personList[index].id);
                            print("selecetedPErson length = " +
                                _selecetedPerson.length.toString());
                          });
                        } else {
                          setState(() {
                            _selecetedPersonState[index] = true;
                            _selecetedPerson.add(_personList[index]);
                          });
                        }
                      }
                    } else if (_controller.user.value.data.id !=
                        _personList[index].id) {
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
                      Wrap(
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: _selecetedPersonState[index] ? 30 : 25,
                              backgroundColor: Colors.white,
                              backgroundImage: Image.network(
                                      _controllerChange.urlUsers +
                                          _personList[index].user.profilePhoto)
                                  .image,
                            ),
                          ),
                          Center(
                              child: Text(
                            _personList[index].user.firstName,
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                      _selecetedPersonState[index]
                          ? Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 10,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
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

/*    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        enableDrag: false,
        barrierColor: Colors.transparent,
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) {*/
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
        color: themeColor,
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
              InkWell(
                onTap: () {
                  insertBudget();
                },
                child: Container(
                  decoration: BoxDecoration(
                      /*  borderRadius:
                                BorderRadius.vertical(bottom: Radius.circular(10)),*/
                      color: background),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
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

  budgetTitle() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: categoryState.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  int i = 0;
                  categoryState.forEach((element) {
                    categoryState[i] = false;
                    i++;
                  });
                  categoryState[index] = true;
                  title = category[index];
                });
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Image.asset(
                          categoryUrl[index],
                          width: 25,
                          height: 25,
                          //  fit: BoxFit.contain,
                        )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        category[index],
                      )
                    ],
                  ),
                  !categoryState[index]
                      ? Container()
                      : Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 10,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        });
  }
}
