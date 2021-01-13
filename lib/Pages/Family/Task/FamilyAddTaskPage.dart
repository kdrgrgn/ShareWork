import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/RepeatTasks.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import '../../../widgets/BuildDaysWidget.dart';
import 'AddFavTask.dart';
import 'UserInfoPage.dart';

class FamilyAddTaskPage extends StatefulWidget {
  @override
  _FamilyAddTaskPageState createState() => _FamilyAddTaskPageState();
}

class _FamilyAddTaskPageState extends State<FamilyAddTaskPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  bool isOpen = false;
  List<bool> isWithPerson = [];

  FamilyTasks tasks;
  List<FamilyTaskData> taskData = [];
  Family family;
  final _formkey = GlobalKey<FormState>();
  DateTime _selectedDate;

  bool isLoading = true;
  ScrollController _taskController = ScrollController();
  List<bool> _selectedTaskState;
  List<FamilyTaskData> _selectedTask = [];
  List<bool> listTabState = [true, false, false];
  List<bool> onMove = [];

  RepeatTasks _repeatTask;

  double containerW = 0;
  double containerH = 0;
  List<bool> listCatState = [false, false, false, false];
  List<String> listCatWord = ["Temizlik", "Mutfak", "Bahce", "Genel"];

  List<String> listSelectCatWord = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _controllerChange.selectedDay.value;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controller.family.value;

      _repeatTask = await _controller.getFamilyPersonTaskListRepeat(
          familyId: family.data.id, headers: _controller.headers());

      tasks = await _controller.getAllFamilyTaskList(
          headers: _controller.headers());

      taskData = tasks.data;
      _selectedTaskState = List(taskData.length);
      for (int i = 0; i < _selectedTaskState.length; i++) {
        _selectedTaskState[i] = false;
        isWithPerson.add(false);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerChange>(builder: (c) {
      print("buraya girdi 2");

      if (c.selectedDay.value != _selectedDate) {
        _controller
            .getFamily(
                headers: _controller.headers(),
                date: buildStringDate(c.selectedDay.value))
            .then((value) {
          setState(() {
            family = value;
          });
        });
      }
      print("buraya girdi 3");

      return buildScaffold();
    });
  }

  Widget buildScaffold() {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BuildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      body: isLoading
          ? MyCircular()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20, top: 5),
                    child: filterButtons(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20, top: 5),
                    child: BuildWidgetDays(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: buildCirclePerson(),
                  ),
                  filtCatRow(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Container(
                        height: 300,
                        decoration: BoxDecoration(),
                        child: buildWidgetWorks()),
                  )
                ],
              ),
            ),
    );
  }

  Widget buildWidgetWorks() {
    return Stack(
      children: [
        GridView.builder(
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
              ignoring: isWithPerson[index],
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedTaskState[index] = !_selectedTaskState[index];
                    if (_selectedTaskState[index]) {
                      _selectedTask.add(taskData[index]);
                    } else {
                      _selectedTask.remove(taskData[index]);
                    }
                  });
                },
                child: Draggable(
                  maxSimultaneousDrags: taskData.length,
                  data: taskData[index].id.toString(),
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
                                border:
                                    Border.all(color: themeColor, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.network(
                                  url,
                                  fit: BoxFit.contain,
                                )),
                          ),
                          isWithPerson[index]
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 10,
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
                  feedback: buildFeedback(_selectedTask, url),
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 0),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: background.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        setState(() {
                          _taskController.animateTo(
                              _taskController.offset - 200,
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 500));
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: background.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        setState(() {
                          _taskController.animateTo(
                              _taskController.offset + 200,
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 500));
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget buildFeedback(List<FamilyTaskData> multiTask, String urlTask) {
    return multiTask.length == 0
        ? Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: themeColor, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(
                  urlTask,
                  fit: BoxFit.contain,
                )),
          )
        : Column(
            children: multiTask.map((e) {
              String url =
                  _controllerChange.urlTask + e.category + "/" + e.picture;

              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: themeColor, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                    )),
              );
            }).toList(),
          );
  }

  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 85,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: family.data.personList.length,
          scrollDirection: Axis.horizontal,
          controller: ScrollController(keepScrollOffset: true),
          itemBuilder: (context, index) {
            onMove.add(false);

            return Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: DragTarget(
                onMove: (c) {
                  setState(() {
                    onMove[index] = true;
                  });
                },
                onLeave: (b) {
                  setState(() {
                    onMove[index] = false;
                  });
                },
                onAccept: (value) async {
                  if (listTabState.indexOf(true) == 0) {
                    if (_selectedTask.length == 0) {
                      insertFamilyPersonTask(
                          personID: family.data.personList[index].id,
                          familyID: family.data.personList[index].familyId,
                          taskID: int.parse(value),
                          index: index);
                    } else {
                      multipeInsertFamilyPersonTask(
                          personID: family.data.personList[index].id,
                          familyID: family.data.personList[index].familyId,
                          taskID: _selectedTask,
                          index: index);
                    }
                  } else {
                    editFamilyPersonTaskPersonId(index, id: int.parse(value));
                  }
                  setState(() {
                    onMove[index] = false;
                  });
                },
                builder: (context, List<String> candidateData, rejectedData) {
                  return Container(
                    width: 75,
                    child: InkWell(
                      onTap: () {
                        Get.to(UserInfo(family.data.personList[index]));
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: onMove[index] ? 35 : 30,
                                  backgroundImage: Image.network(
                                          _controllerChange.urlUsers +
                                              family.data.personList[index].user
                                                  .profilePhoto)
                                      .image,
                                ),
                              ),
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          Get.theme.backgroundColor,
                                      child: Text(
                                        family.data.personList[index].taskCount
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            family.data.personList[index].user.firstName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget filtCatRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        containerH == 0
            ? Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        containerW = Get.width - 40;
                        containerH = 40;
                      });
                    },
                    child: Container(
                        width: 30,
                        height: 30,
                        child: Image.network(
                          "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_1.png",
                          fit: BoxFit.contain,
                        ))),
              )
            : Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: InkWell(
                  onTap: () {
                    setState(() {
                      containerW = 0;
                      containerH = 0;
                    });
                  },
                  child: Icon(Icons.close)),
            ),
        containerH != 0
            ? Container()
            : Expanded(
                flex: 7,
                child: Container(
                  height: 45,
                  width: Get.width - 50,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    controller: ScrollController(keepScrollOffset: true),
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[0] = !listCatState[0];
                              if (listCatState[0]) {
                                listSelectCatWord.add(listCatWord[0]);
                              } else {
                                listSelectCatWord.remove(listCatWord[0]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Temizlik"),
                              listCatState[0] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[1] = !listCatState[1];
                              if (listCatState[1]) {
                                listSelectCatWord.add(listCatWord[1]);
                              } else {
                                listSelectCatWord.remove(listCatWord[1]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Mutfak"),
                              listCatState[1] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[2] = !listCatState[2];
                              if (listCatState[2]) {
                                listSelectCatWord.add(listCatWord[2]);
                              } else {
                                listSelectCatWord.remove(listCatWord[2]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Bahce"),
                              listCatState[2] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[3] = !listCatState[3];

                              if (listCatState[3]) {
                                listSelectCatWord.add(listCatWord[3]);
                              } else {
                                listSelectCatWord.remove(listCatWord[3]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Genel"),
                              listCatState[3] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        AnimatedContainer(
          width: containerW,
          height: containerH,
          duration: Duration(milliseconds: 500),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      taskData = tasks.data;
                    });
                  } else {
                    setState(() {
                      taskData = [];

                      for (int i = 0; i < tasks.data.length; i++) {
                        if (tasks.data[i].title
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          taskData.add(tasks.data[i]);
                        }
                      }
                    });
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(Icons.filter_list_outlined),
                    labelText: "Search Task",),
              ),
            ),
          ),
        )
      ],
    );
  }

  /* List<Widget> personBuild() {
    List<Widget> person = [];

    for (PersonList e in family.data.personList) {
      int index = family.data.personList.indexOf(e);

      person.add(buildPadding(index));
    }

    return person;
  }

  Widget buildPadding(int index) {
    bool onMove=false;
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: DragTarget(
        onMove: (c){

          setState(() {
            onMove=true;
          });
        },

        onLeave: (b){
          setState(() {
            onMove=false;
          });
        },
        onAccept: (value) async {
          if(listTabState.indexOf(true)==0){
          if (_selectedTask.length == 0) {
            insertFamilyPersonTask(
                personID: family.data.personList[index].id,
                familyID: family.data.personList[index].familyId,
                taskID: int.parse(value),
                index: index);
          } else {
            multipeInsertFamilyPersonTask(
                personID: family.data.personList[index].id,
                familyID: family.data.personList[index].familyId,
                taskID: _selectedTask,
                index: index);
          }}
          else{


int result =await _controller.editFamilyPersonTaskDetails(
  headers: _controller.headers(),
  personId: taskData[taskData.indexWhere((element) => element.id==int.parse(value))].familyPersonTaskId,
  points: taskData[taskData.indexWhere((element) => element.id==int.parse(value))].points,
status: 1,
);
if (result == 200) {


  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content:
      Text("İşlem Başarılı  görev atandı!!!"),
      behavior: SnackBarBehavior.floating,
    ),
  );
} else {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text("Birseyler yanlış gitti"),
      behavior: SnackBarBehavior.floating,
    ),
  );
}


          }
        },
        builder: (context, List<String> candidateData, rejectedData) {
          return Container(
            width: 75,
            child: InkWell(
              onTap: () {
                Get.to(UserInfo(family.data.personList[index]));
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: onMove?Colors.blue:Colors.transparent,
                          radius: onMove?40:30,
                          backgroundImage: Image.network(
                                  _controllerChange.urlUsers +
                                      family.data.personList[index].user
                                          .profilePhoto)
                              .image,
                        ),
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Get.theme.backgroundColor,
                              child: Text(
                                family.data.personList[index].taskCount
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    family.data.personList[index].user.firstName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

*/
  insertFamilyPersonTask(
      {int personID, int familyID, int taskID, int index}) async {
    bool isAvailable = false;

    FamilyPerson _person = await _controller.getFamilyPersonWithId(
        headers: _controller.headers(),
        id: personID,
        date: buildStringDate(_controllerChange.selectedDay.value));
    for (int i = 0; i < _person.data.ownedFamilyTaskList.length; i++) {
      if (_person.data.ownedFamilyTaskList[i].id == taskID) {
        isAvailable = true;
      }
    }
    if (isAvailable) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Bu görev zaten mevcut !!!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      int result = await _controller.insertFamilyPersonTask(
          headers: _controller.headers(),
          personID: personID,
          familyID: familyID,
          taskID: taskID,
          date: buildStringDate(_controllerChange.selectedDay.value));
      if (result == 200) {
        setState(() {
          family.data.personList[index].taskCount++;
        });

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("İşlem Başarılı !!!"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
  }

  Future<void> multipeInsertFamilyPersonTask(
      {int personID,
      int familyID,
      List<FamilyTaskData> taskID,
      int index}) async {
    List<int> idList = [];
    List<int> filtListID = [];
    List<int> deleteId = [];

    FamilyPerson _person = await _controller.getFamilyPersonWithId(
        headers: _controller.headers(),
        id: personID,
        date: buildStringDate(_controllerChange.selectedDay.value));

    for (int j = 0; j < _person.data.ownedFamilyTaskList.length; j++) {
      idList.add(_person.data.ownedFamilyTaskList[j].id);
    }
    for (int i = 0; i < taskID.length; i++) {
      filtListID.add(taskID[i].id);
    }
    for (int j = 0; j < filtListID.length; j++) {
      if (idList.contains(filtListID[j])) {
        deleteId.add(filtListID[j]);
      }
    }

    for (int i = 0; i < deleteId.length; i++) {
      filtListID.remove(deleteId[i]);
    }

    if (filtListID.length == 0) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Görevler Zaten Mevcut !!!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      int result = await _controller.multipleInsertFamilyPersonTask(
          headers: _controller.headers(),
          personID: personID,
          familyID: familyID,
          taskID: filtListID,
          date: buildStringDate(_controllerChange.selectedDay.value));
      if (result == 200) {
        setState(() {
          family.data.personList[index].taskCount =
              family.data.personList[index].taskCount + filtListID.length;
        });

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content:
                Text("İşlem Başarılı ${filtListID.length} görev atandı!!!"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Birseyler yanlış gitti"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Widget buildFab() {
    return isOpen
        ? Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                heroTag: "buttonFav",
                onPressed: () {
                  setState(() {
                    isOpen = false;
                  });
                  Get.to(AddFavTask()).then((value) {
                    updateTasks();
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.list, size: 25.0),
              ),
              SizedBox(
                height: 5,
              ),
              FloatingActionButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                heroTag: "buttonPop",
                onPressed: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Tab(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          )
        : FloatingActionButton(
            heroTag: "buttonPush",
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            child: Tab(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
  }

  Widget filterButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      updateTasks(type: 0);
                      listTabState = [true, false, false];
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Daily"),
                      listTabState[0] == true
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      updateTasks(type: 1);

                      listTabState = [false, true, false];
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Weekly"),
                      listTabState[1] == true
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                elevation: 3,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      updateTasks(type: 2);

                      listTabState = [false, false, true];
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Monthly"),
                      listTabState[2] == true
                          ? Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateTasks({int type}) async {
    DateTime today = DateTime.now();

    RepeatTasks _result;

    setState(() {
      for (int i = 0; i < _selectedTaskState.length; i++) {
        _selectedTaskState[i] = false;
      }
      _selectedTask = [];
    });

    if (type == 0) {
      taskData = [];
      isWithPerson = [];

      setState(() {
        taskData = tasks.data;
        int i = 0;
        taskData.forEach((element) {
          isWithPerson.add(false);
          i++;
        });
      });
    } else if (type == null) {
      _repeatTask = await _controller.getFamilyPersonTaskListRepeat(
          familyId: family.data.id, headers: _controller.headers());
      type = listTabState.indexOf(true);

      DateTime firstDay;
      if (type == 1) {
        firstDay = today.subtract(new Duration(days: today.weekday - 1));
      } else {
        firstDay = DateTime(today.year, today.month, 1);
      }
      taskData = [];
      isWithPerson = [];
      for (RepeatTaskData value in _repeatTask.data) {
        print("for varr");
        if (value.familyTask.repeatType == type) {
          DateTime dateString = DateTime.parse(
              value.familyTask.dateString.split('.').reversed.join());

          if (firstDay.year == dateString.year &&
              firstDay.month == dateString.month &&
              firstDay.day == dateString.day) {
            setState(() {
              taskData.add(value.familyTask);
              if (value.familyPerson.id != 0) {
                isWithPerson.add(true);
              } else {
                isWithPerson.add(false);
              }
            });
          }
        }
      }
    } else {
      DateTime firstDay;
      if (type == 1) {
        firstDay = today.subtract(new Duration(days: today.weekday - 1));
      } else {
        firstDay = DateTime(today.year, today.month, 1);
      }
      taskData = [];
      isWithPerson = [];

      for (RepeatTaskData value in _repeatTask.data) {
        print("for varr");
        if (value.familyTask.repeatType == type) {
          DateTime dateString = DateTime.parse(
              value.familyTask.dateString.split('.').reversed.join());

          if (firstDay.year == dateString.year &&
              firstDay.month == dateString.month &&
              firstDay.day == dateString.day) {
            setState(() {
              taskData.add(value.familyTask);
              if (value.familyPerson.id != 0) {
                isWithPerson.add(true);
              } else {
                isWithPerson.add(false);
              }
            });
          }
        }
      }
    }
  }

  updateItem() {
    taskData = [];
    if (listSelectCatWord.length == 0) {
      setState(() {
        taskData = tasks.data;
      });
    } else {
      for (FamilyTaskData value in tasks.data) {
        if (listSelectCatWord.contains(value.category)) {
          setState(() {
            taskData.add(value);
          });
        }
      }
    }
  }

  Future<void> editFamilyPersonTaskPersonId(int index, {int id}) async {
    List<int> idList = [];
    List<int> idTask = [];
    List<int> idIndex = [];

    if (_selectedTask.length != 0) {
      _selectedTask.forEach((element) {
        idList.add(element.familyPersonTaskId);
        idTask.add(element.id);
      });
    } else {
      taskData.forEach((element) {
        if (element.id == id) {
          idList.add(element.familyPersonTaskId);
        }
      });
      idTask.add(id);
    }

    int result = await _controller.editFamilyPersonTaskPersonId(
      fptIds: idList,
      personId: family.data.personList[index].id,
      headers: _controller.headers(),
    );
    if (result == 200) {
      setState(() {
        _selectedTask = [];
        int i = 0;
        taskData.forEach((element) {
          _selectedTaskState[i] = false;
          i++;
        });
        family.data.personList[index].taskCount =
            idList.length + family.data.personList[index].taskCount;
      });
      int i = 0;
      taskData.forEach((element) {
        if (idTask.contains(element.id)) {
          idIndex.add(i);
        }
        i++;
      });
      setState(() {
        idIndex.forEach((element) {
          isWithPerson[element] = true;
        });
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("İşlem Başarılı  görev atandı!!!"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Birseyler yanlış gitti"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
