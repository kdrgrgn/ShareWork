
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/Pages/Family/AddUserPage.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/TaskMessage.dart';
import 'package:mobi/widgets/InsertFamily.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import '../../../widgets/BuildDaysWidget.dart';

class FamilyViewPage extends StatefulWidget {
  @override
  _FamilyViewPageState createState() => _FamilyViewPageState();
}

class _FamilyViewPageState extends State<FamilyViewPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());

  Family family;
  List<PersonList> _personList;

  FamilyPerson _familyPerson;
  DateTime _selectedDate;
  int personIndex = 0;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _controllerChange.selectedDay.value;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = await _controller.getFamily(
          headers: _controller.headers(),
          date: buildStringDate(_controllerChange.selectedDay.value));
      if (family.data.personList != null) {
        _personList = family.data.personList;
        _familyPerson = await _controller.getFamilyPersonWithId(
            headers: _controller.headers(),
            id: _personList[personIndex].id,
            date: buildStringDate(DateTime.now()));
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerDB>(builder: (controllerDB) {
      if (controllerDB.family.value != family) {
        _controller
            .getFamilyPersonWithId(
                headers: _controller.headers(),
                id: controllerDB.family.value.data.personList[personIndex].id,
                date: buildStringDate(DateTime.now()))
            .then((value) {
          setState(() {
            isLoading = true;
          });
          setState(() {
            family = controllerDB.family.value;
            _personList = controllerDB.family.value.data.personList;
            _familyPerson = value;
          });

          setState(() {
            isLoading = false;
          });
        });
      }

      return controllerDB.family.value.data.personList == null
          ? InsertFamilyWidget()
          : GetBuilder<ControllerChange>(builder: (c) {
              if (c.selectedDay.value != _selectedDate) {
                _controller
                    .getFamily(
                        headers: _controller.headers(),
                        date: buildStringDate(c.selectedDay.value))
                    .then((value) {
                  setState(() {
                    family = value;
                    _personList = family.data.personList;
                  });
                });

                _controller
                    .getFamilyPersonWithId(
                        headers: _controller.headers(),
                        id: _personList[personIndex].id,
                        date: buildStringDate(c.selectedDay.value))
                    .then((value) {
                  setState(() {
                    _familyPerson = value;
                    _selectedDate = c.selectedDay.value;
                  });
                });
              }

              return isLoading ? MyCircular() : buildScaffold();
            });
    });
  }

  Widget buildScaffold() {
/*if(_controller.family.value.data.personList != null && family.data.personList==null)
    _controller
        .getFamilyPersonWithId(
        headers: _controller.headers(),
        id: _controller.family.value.data.personList[personIndex].id,
        date: buildStringDate(DateTime.now()))
        .then((value) {
      setState(() {
        family = _controller.family.value;
        _personList = _controller.family.value.data.personList;
        _familyPerson = value;
      });
    });*/

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _familyPerson == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      backgroundImage: Image.network(
                        _controllerChange.baseUrl +
                            "/media/users/" +
                            family
                                .data.personList[personIndex].user.profilePhoto,
                        fit: BoxFit.contain,
                      ).image,
                    ),
                  ),
            _familyPerson == null
                ? Container()
                : Expanded(
                    child: Text(
                      family.data.personList[personIndex].user.firstName +
                          " " +
                          family.data.personList[personIndex].user.lastName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            Row(children: [
              InkWell(
                onTap: () {
                  Get.to(CommunicationPage(
                      bottomNavBar: BuildBottomNavigationBar()));
                },
                child: Container(
                    width: 30,
                    height: 30,
                    child: Image.network(
                      "https://www.share-work.com/newsIcons/thumbnail_ikon_7_8.png",
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: 30,
                  height: 30,
                  child: Image.network(
                      "https://share-work.com/newsIcons/ikonlar_ek_6.png")),
            ])
          ],
        ),
      ),
      body: isLoading
          ? MyCircular()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20, top: 5),
                    child: BuildWidgetDays(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: buildCirclePerson(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              child: Image.network(
                                  "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_8.png")),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: Text("Be productive today"))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                        height: 360,
                        decoration: BoxDecoration(),
                        child: buildWidgetWorks()),
                  ),
                  /*   SizedBox(
                        height: 100,
                      )*/
                ],
              ),
            ),
    );
  }

  Widget buildWidgetWorks() {
    return _familyPerson.data.ownedFamilyTaskList.length == 0
        ? Column(
            children: [
              Image.asset(
                "assets/images/family/wink.jpg",
                fit: BoxFit.fitWidth,
                height: 220,
              ),
              SizedBox(
                height: 10,
              ),
              Text("you have nothing to do today")
            ],
          )
        : GridView.builder(
            itemCount: _familyPerson.data.ownedFamilyTaskList.length,
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            controller: ScrollController(keepScrollOffset: false),
            itemBuilder: (context, index) {
              FamilyTaskData _familyTask =
                  _familyPerson.data.ownedFamilyTaskList[index];

              String url = _controllerChange.baseUrl +
                  "/media/familyTask/" +
                  _familyTask.category +
                  "/" +
                  _familyTask.picture;

              return Container(
                child: Wrap(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            ratingBottom(_familyTask.familyPersonTaskId);
                          },
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: themeColor, width: 0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                url,
                                fit: BoxFit.contain,
                              )),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: _familyTask.status == 1
                              ? Icon(Icons.check_box,
                                  color: Colors.green, size: 18)
                              : Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child:
                              Icon(Icons.delete, color: Colors.red, size: 20),
                        )
                      ],
                    ),
                    Text(
                      _familyTask.title,
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 30, crossAxisSpacing: 20),
          );
  }

  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 60,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: ScrollController(keepScrollOffset: true),
          children: personBuild(),
        ),
      ),
    );
  }

  List<Widget> personBuild() {
    List<Widget> person;

    person = [
      InkWell(
        onTap: () {
          Get.to(AddUserPage());
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      )
    ];

    for (PersonList e in family.data.personList) {
      int index = family.data.personList.indexOf(e);

      person.add(InkWell(
        onTap: () async {
          FamilyPerson result = await _controller.getFamilyPersonWithId(
              headers: _controller.headers(),
              id: e.id,
              date: buildStringDate(_controllerChange.selectedDay.value));

          setState(() {
            _familyPerson = result;
            personIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Stack(
            children: [
              CircleAvatar(
                radius: personIndex == index ? 35 : 30,
                backgroundColor: Colors.white,
                backgroundImage: Image.network(_controllerChange.baseUrl +
                        "/media/users/" +
                        e.user.profilePhoto)
                    .image,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Get.theme.backgroundColor,
                  child: Text(
                    e.taskCount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }

    return person;
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

  ratingBottom(int id) async {
    final _formSheet = GlobalKey<FormState>();

    String newMessage;

    TaskMessage messages = await _controller.getFamilyPersonTaskMessageList(
        id: id, headers: _controller.headers());
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
                child: Wrap(children: [
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: messages.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String url = _controllerChange.baseUrl +
                        "/media/users/" +
                        messages.data[index].person.user.profilePhoto;

                    return Container(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, right: 5, left: 10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.3))),
                      child: Column(
                        children: [
                          Text(
                            messages.data[index].createDate,
                            style: TextStyle(color: background, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: Image.network(url).image,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    messages.data[index].person.user.firstName +
                                        " " +
                                        messages
                                            .data[index].person.user.lastName,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(messages.data[index].message,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom, left: 10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: Form(
                        key: _formSheet,
                        child: TextFormField(
                          onSaved: (value) {
                            newMessage = value;
                          },
                          validator: (value) =>
                              value.isEmpty ? "Bos olamaz" : null,
                          maxLines: 3,
                          decoration:
                              InputDecoration(hintText: "Any Question ?"),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: themeColor,
                      onPressed: () async {
                        if (_formSheet.currentState.validate()) {
                          _formSheet.currentState.save();

                              await _controller.insertFamilyPersonTaskMessage(
                                  id: id,
                                  message: newMessage,
                                  headers: _controller.headers());

                           _controller.getFamilyPersonTaskMessageList(
                              id: id, headers: _controller.headers()).then((value) {
                            setState((){
                              messages=value;
                            });
                          });


                        }
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ]));
          });
        });
  }
}
