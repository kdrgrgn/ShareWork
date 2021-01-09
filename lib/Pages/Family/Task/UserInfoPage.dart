import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/TaskMessage.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class UserInfo extends StatefulWidget {
  PersonList _personList;

  UserInfo(this._personList);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controllerDB = Get.put(ControllerDB());
  final ControllerChange _controllerChange = Get.put(ControllerChange());
  TextStyle subStyle = TextStyle(color: Colors.grey, fontSize: 15);
  List<Widget> listTab = [
    Tab(icon: Text("Daily")),
    Tab(icon: Text("Weekly")),
    Tab(icon: Text("Monthly")),
  ];
  TabController _controller;
  List<FamilyTaskData> _taskDataW = [];
  List<FamilyTaskData> _taskDataD = [];
  List<FamilyTaskData> _taskDataM = [];

  FamilyPerson _familyPerson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: listTab.length, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _familyPerson = await _controllerDB.getFamilyPersonWithId(
          headers: _controllerDB.headers(),
          id: widget._personList.id,
          date: buildStringDate(DateTime.now()));
      editListRepeat(_familyPerson);

      setState(() {
        isLoading = false;
      });
    });
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BuildBottomNavigationBar(),
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
/*      appBar: AppBar(
        title: Text('User Info'),
      )*/
      body: isLoading
          ? MyCircular()
          : Stack(
              children: [
                Container(
                  width: Get.size.width,
                  height: Get.size.height,
                  color: Colors.blue[200],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: Get.size.width,
                    height: Get.size.height - 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Column(
                      children: [
                        //SizedBox(height: 20,),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: Image.network(
                                      "https://www.share-work.com/newsIcons/thumbnail_ikon_3_8.png",
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          width: 30,
                                          height: 30,
                                          child: Image.network(
                                              "https://share-work.com/newsIcons/thumbnail_ikon_score.png")),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          /*    width: 10,
                                  height: 10,*/
                                          decoration: BoxDecoration(
                                            color: background,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Text(
                                            "12",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: Get.width - 50,
                                child: Text(
                                  _familyPerson.data.user.firstName +
                                      " " +
                                      _familyPerson.data.user.lastName,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                child: TabBar(
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  controller: _controller,
                                  indicatorColor: background,
                                  labelColor: themeColor,
                                  tabs: listTab,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Container(
                            //  height: 270,
                            width: Get.width,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _controller,
                              children: [
                                cardBuilder(_taskDataD),
                                cardBuilder(_taskDataW),
                                cardBuilder(_taskDataM),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.75),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: Image.network(_controllerChange.urlUsers +
                            _familyPerson.data.user.profilePhoto)
                        .image,
                    radius: 60,
                  ),
                )
              ],
            ),
    );
  }

  /*
  *
  *
  * SwipeActionCell(
          key: ValueKey(taskData[index]),
          leadingActions: [
                  SwipeAction(
                content:Container(
                              width: 30,
                              height: 30,
                              child: Image.network(
                                  "https://share-work.com/newsIcons/thumbnail_ikon_score.png"),
                            )
                color: Colors.transparent,
                onTap: (handler) {}),

            SwipeAction(
                content:Container(
                              width: 30,
                              height: 30,
                              child: Image.network(
                                  "https://share-work.com/newsIcons/thumbnail_ikon_3_3.png"),
                            )
                color: Colors.transparent,
                onTap: (handler) {}),
          ],
          child: Container(
            padding: EdgeInsets.only(
                bottom: 10, top: 10, right: 5, left: 10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeColor, width: 0.5),
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: Image.network(url).image,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          _orderData[index].familyShopItem.name,
                          style: TextStyle(
                              fontSize: 17, color: Colors.black),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          _orderData[index].unit == 1
                              ? "Adet"
                              : "Kilogram",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        InkWell(
                            onTap: () {
                              editFamilyShopOrder(
                                  id: _orderData[index].id,
                                  count:
                                  _orderData[index].count + 1,
                                  unit: _orderData[index].unit);
                              setState(() {
                                _orderData[index].count++;
                              });
                            },
                            child: Icon(Icons.add)),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding:
                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: background,
                              borderRadius:
                              BorderRadius.circular(5)),
                          child: Text(
                            _orderData[index].count.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              editFamilyShopOrder(
                                  id: _orderData[index].id,
                                  count:
                                  _orderData[index].count - 1,
                                  unit: _orderData[index].unit);
                              setState(() {
                                _orderData[index].count--;
                              });
                            },
                            child: Icon(Icons.remove)),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
  *
  * */

  cardBuilder(List<FamilyTaskData> taskData) {
    return ListView.builder(
      itemCount: taskData.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      controller: ScrollController(keepScrollOffset: false),
      itemBuilder: (context, index) {
        String url = _controllerChange.urlTask +
            taskData[index].category +
            "/" +
            taskData[index].picture;
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15)),
            child: SwipeActionCell(
              backgroundColor: Colors.transparent,
              key: ValueKey(taskData[index]),
              leadingActions: [
                SwipeAction(
                    content: Container(
                      width: 30,
                      height: 30,
                      child: Image.network(
                          "https://share-work.com/newsIcons/thumbnail_ikon_score.png"),
                    ),
                    color: Colors.transparent,
                    onTap: (handler) {
                      missionCompleted(taskData[index].familyPersonTaskId);
                    }),
                SwipeAction(
                    content: Container(
                      width: 30,
                      height: 30,
                      child: Image.network(
                          "https://share-work.com/newsIcons/thumbnail_ikon_3_3.png"),
                    ),
                    color: Colors.transparent,
                    onTap: (handler) {
                      commentBottom(taskData[index].familyPersonTaskId);
                    }),
              ],
              child: Container(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, right: 5, left: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: themeColor, width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.transparent,
                            backgroundImage: Image.network(url).image,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskData[index].title,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              taskData[index].category,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(taskData[index].points.toString())
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void editListRepeat(FamilyPerson familyPerson) {
    for (FamilyTaskData data in familyPerson.data.ownedFamilyTaskList) {
      if (data.repeatType == 0) {
        _taskDataD.add(data);
      } else if (data.repeatType == 1) {
        _taskDataW.add(data);
      } else if (data.repeatType == 2) {
        _taskDataM.add(data);
      }
    }
  }

  commentBottom(int id) async {
    final _formSheet = GlobalKey<FormState>();

    String newMessage;

    TaskMessage messages = await _controllerDB.getFamilyPersonTaskMessageList(
        id: id, headers: _controllerDB.headers());
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
                    String url = _controllerChange.urlUsers +
                        messages.data[index].person.user.profilePhoto;

                    return Container(
                      padding: EdgeInsets.only(
                          bottom: 10, top: 10, right: 5, left: 10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.3))),
                      child: Column(
                        children: [
                          Text(
                            messages.data[index].createDate.replaceAll(RegExp('T'), ' '),
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

                          await _controllerDB.insertFamilyPersonTaskMessage(
                              id: id,
                              message: newMessage,
                              headers: _controllerDB.headers());

                          _controllerDB
                              .getFamilyPersonTaskMessageList(
                                  id: id, headers: _controllerDB.headers())
                              .then((value) {
                            setState(() {
                              messages = value;
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

  missionCompleted(int familyPersonTaskId) {
    final _formKeyDiolog = GlobalKey<FormState>();
    int points;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              RaisedButton(
                color: Colors.green,
                child: Text("Tamam"),
                onPressed: () async {
                  if (_formKeyDiolog.currentState.validate()) {
                    _formKeyDiolog.currentState.save();
                    await _controllerDB.editFamilyPersonTaskDetailsWithPersonId(
                        personId: _familyPerson.data.id,
                        points: points,
                        status: 1,
                        familyPersonTaskId: familyPersonTaskId,
                        headers: _controllerDB.headers());

                    Get.back();
                  }
                },
              ),
            ],
            title: Text("Lutfen puan giriniz"),
            content: Container(
                child: Form(
              key: _formKeyDiolog,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "eksik";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  points = int.parse(value);
                },
                decoration: InputDecoration(hintText: "Point"),
              ),
            )),
          );
        });
  }
}
