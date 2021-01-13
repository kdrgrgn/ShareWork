import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/CalendarPage.dart';
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
  List<bool> isFav = [];
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
        onPressed: () {
          userAddTaskBottom();
        },
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
                                  InkWell(
                                    onTap: () {
                                      Get.to(CalendarPage());
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.network(
                                          "https://www.share-work.com/newsIcons/thumbnail_ikon_7_5.png"),
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
                                            _familyPerson.data.point.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
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
                                height: 60,
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
                              dragStartBehavior: DragStartBehavior.start,
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

  cardBuilder(List<FamilyTaskData> taskData) {
    taskData.forEach((element) {
      isFav.add(false);
    });

    return ListView.builder(
      itemCount: taskData.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      controller: ScrollController(
        keepScrollOffset: true,
      ),
      itemBuilder: (context, index) {

        print("stattusss $index = " + taskData[index].status.toString());
        print("id $index  = " + taskData[index].familyPersonTaskId.toString() + taskData[index].title);


        String url = _controllerChange.urlTask +
            taskData[index].category +
            "/" +
            taskData[index].picture;

        taskData[index].likePersonList.forEach((element) {
          if (element.id == _familyPerson.data.id) {
            isFav[index] = true;
          }
        });

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
                SwipeAction(
                    content: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 32,
                    ),
                    color: Colors.transparent,
                    onTap: (handler) {}),
              ],
              child: Container(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          width: 50,
                        ),
                        Row(
                          children: [
                            Text(taskData[index].points.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 20,
                              height: 30,
                              child: Image.network(
                                  "https://share-work.com/newsIcons/thumbnail_ikon_3_3.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            isFav[index]
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : InkWell(
                                    onTap: () async {
                                      await insertFamilyPersonTaskLike(
                                          taskData[index].familyPersonTaskId);
                                      setState(() {
                                        isFav[index] = true;
                                      });
                                    },
                                    child: Icon(Icons.favorite_outline)),
                          ],
                        )
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
                            messages.data[index].createDate
                                .replaceAll(RegExp('T'), ' '),
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

  Future<void> userAddTaskBottom() async {
    FamilyTasks tasks;
    List<FamilyTaskData> taskData = [];
    tasks = await _controllerDB.getAllFamilyTaskList(
        headers: _controllerDB.headers());

    taskData = tasks.data;
    ScrollController _taskController = ScrollController();
    List<bool> _selectedTaskState;
    List<FamilyTaskData> _selectedTask = [];

    List<int> ids = [];
    _taskDataD.forEach((element) {
      print(element.id);
      ids.add(element.id);
    });

    _selectedTaskState = List(taskData.length);
    for (int i = 0; i < _selectedTaskState.length; i++) {
      _selectedTaskState[i] = false;
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Wrap(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        multipeInsertFamilyPersonTask(tasks: _selectedTask);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Task Gonder",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    child: GridView.builder(
                      itemCount: taskData.length,
                      padding: const EdgeInsets.all(15),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      controller: _taskController,
                      itemBuilder: (context, index) {
                        String url = _controllerChange.urlTask +
                            taskData[index].category +
                            "/" +
                            taskData[index].picture;

                        return IgnorePointer(
                          ignoring: ids.contains(taskData[index].id),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedTaskState[index] =
                                    !_selectedTaskState[index];
                                if (_selectedTaskState[index]) {
                                  _selectedTask.add(taskData[index]);
                                } else {
                                  _selectedTask.remove(taskData[index]);
                                }
                              });
                            },
                            child: Wrap(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: _selectedTaskState[index]
                                              ? Colors.grey[300]
                                              : Colors.white,
                                          border: Border.all(
                                              color: themeColor, width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Image.network(
                                            url,
                                            fit: BoxFit.contain,
                                          )),
                                    ),
                                    ids.contains(taskData[index].id)
                                        ? Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.green),
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                                Text(
                                  taskData[index].title,
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.5,
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<void> multipeInsertFamilyPersonTask(
      {List<FamilyTaskData> tasks}) async {
    List<int> idList = [];

    tasks.forEach((element) {
      idList.add(element.id);
    });

    int result = await _controllerDB.multipleInsertFamilyPersonTask(
        headers: _controllerDB.headers(),
        personID: _familyPerson.data.id,
        familyID: _familyPerson.data.familyId,
        taskID: idList,
        date: buildStringDate(DateTime.now()));
    if (result == 200) {
      setState(() {
        tasks.forEach((element) {
          _taskDataD.add(element);
        });
        Get.back();
      });
    }
  }

  Future<void> insertFamilyPersonTaskLike(int familyPersonTaskId) async {
    await _controllerDB.insertFamilyPersonTaskLike(
        headers: _controllerDB.headers(),
        familyPersonTaskId: familyPersonTaskId);
  }
}
