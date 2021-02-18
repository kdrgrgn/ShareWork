import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/RepeatTasks.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class MonthlyBuild extends StatefulWidget {
  List<FamilyTaskData> taskData = [];
  Family family;

  RepeatTasks repeatTaskData;

  MonthlyBuild({this.taskData, this.family, this.repeatTaskData});

  @override
  _MonthlyBuildState createState() => _MonthlyBuildState();
}

class _MonthlyBuildState extends State<MonthlyBuild> {
  ScrollController _taskController = ScrollController();

  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  ControllerFamily _controllerFamily = Get.put(ControllerFamily());

  List<FamilyTaskData> taskData = [];
  Family family;
  bool isLoading = true;
  List<bool> _selectedTaskState;
  List<FamilyTaskData> _selectedTask = [];
  RepeatTasks _repeatTask;
  List<RepeatTaskData> _repeatTaskData = [];
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  DateTime firstDay;

  DateTime today;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = DateTime.now();
    firstDay = DateTime(today.year, today.month, 1);
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      _repeatTask = widget.repeatTaskData;
      family = widget.family;
      taskData = widget.taskData;

      _selectedTaskState = List(taskData.length);
      for (int i = 0; i < _selectedTaskState.length; i++) {
        _selectedTaskState[i] = false;
      }

      for (RepeatTaskData value in widget.repeatTaskData.data) {
        print("taskk dataaa = " + value.familyTask.title);
        if (value.familyTask.repeatType == 2) {
          DateTime dateString = DateTime.parse(
              value.familyTask.dateString.split('.').reversed.join());

          if (firstDay.year == dateString.year &&
              firstDay.month == dateString.month &&
              firstDay.day == dateString.day) {

            setState(() {
              _repeatTaskData.add(value);
            });
          }
        }
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
      body: SingleChildScrollView(
        child: isLoading
            ? MyCircular()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: buildFavTask(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                        height: 360,
                        decoration: BoxDecoration(),
                        child: buildWidgetWorks()),
                  )
                ],
              ),
      ),
    );
  }

  Widget buildWidgetWorks() {
    List<int> _repeatIdList = [];

    for (RepeatTaskData i in _repeatTaskData) {
      _repeatIdList.add(i.id);
    }

    return Stack(
      children: [
        GridView.builder(
          itemCount: taskData.length,
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: _taskController,
          itemBuilder: (context, index) {
            String url = _controllerChange.urlTask +
                taskData[index].category +
                "/" +
                taskData[index].picture;

            return IgnorePointer(
              ignoring: _repeatIdList.contains(taskData[index].id),
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
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: _selectedTaskState[index]
                                ? Colors.grey[300]
                                : Colors.white,
                            border: Border.all(color: themeColor, width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              url,
                              fit: BoxFit.contain,
                            )),
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
              crossAxisCount: 4, mainAxisSpacing: 30, crossAxisSpacing: 20),
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
              String url = _controllerChange.baseUrl +
                  "/media/familyTask/" +
                  e.category +
                  "/" +
                  e.picture;

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

  Widget buildFavTask() {
    return _repeatTaskData.length == 0
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: DragTarget(onAccept: (value) {
              if (_selectedTask.length == 0) {
                FamilyTaskData task;
                for (FamilyTaskData data in taskData) {
                  if (data.id == int.parse(value)) {
                    task = data;
                  }
                }

                multipeInsertFamilyPersonTask(
                  familyID: family.data.id,
                  task: task,
                  index: int.parse(value),
                );
              } else {
                multipeInsertFamilyPersonTask(
                  familyID: family.data.id,
                  taskID: _selectedTask,
                );
              }
            }, builder: (context, List<String> candidateData, rejectedData) {
              return Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Aylık Görev ekleyin",
                  style: TextStyle(fontSize: 15),
                )),
              );
            }),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: DragTarget(
                onAccept: (value) {
                  if (_selectedTask.length == 0) {
                    FamilyTaskData task;
                    for (FamilyTaskData data in taskData) {
                      if (data.id == int.parse(value)) {
                        task = data;
                      }
                    }

                    multipeInsertFamilyPersonTask(
                      familyID: family.data.id,
                      task: task,
                      index: int.parse(value),
                    );
                  } else {
                    multipeInsertFamilyPersonTask(
                      familyID: family.data.id,
                      taskID: _selectedTask,
                    );
                  }
                },
                builder:
                    (context, List<String> candidateData, rejectedData) {
                      return Container(
                        width: double.infinity,
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: _repeatTaskData.length,
                          itemBuilder: (context, index) {
                            String url = _controllerChange.urlTask +
                                _repeatTaskData[index].familyTask.category +
                                "/" +
                                _repeatTaskData[index].familyTask.picture;

                            return Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child:
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  //    color: Colors.grey[300],
                                    border: Border.all(
                                        color: themeColor, width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.contain,
                                    )),

                              ),
                            );
                          },
                        ),
                      );
                    }
            ),
          );
  }

  Future<void> multipeInsertFamilyPersonTask(
      {int familyID,
      List<FamilyTaskData> taskID,
      int index,
      FamilyTaskData task}) async {
    List<int> filtListID = [];

    if (taskID == null) {
      filtListID.add(index);
      _selectedTask.add(task);
    } else {
      for (int i = 0; i < taskID.length; i++) {
        filtListID.add(taskID[i].id);
      }
    }

    int result = await _controllerFamily.multipleInsertFamilyPersonTask(
        headers: _controllerDB.headers(),
        familyID: familyID,
        taskID: filtListID,
        repeatType: 2,
        date: buildStringDate(firstDay));
    if (result == 200) {
      setState(() {
        updateMonthly();
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("İşlem Başarılı ${filtListID.length} görev atandı!!!"),
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

    setState(() {
      _selectedTask = [];
      for (int i = 0; i < _selectedTaskState.length; i++) {
        _selectedTaskState[i] = false;
      }
    });
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
  }

  updateMonthly() async {
    setState(() {
      for (int i = 0; i < _selectedTaskState.length; i++) {
        _selectedTaskState[i] = false;
      }
      _selectedTask = [];
    });


    _repeatTask = await _controllerFamily.getFamilyPersonTaskListRepeat(
        familyId: family.data.id, headers: _controllerDB.headers());

    _repeatTaskData = [];

    for (RepeatTaskData value in _repeatTask.data) {
      if (value.familyTask.repeatType == 2) {
        DateTime dateString = DateTime.parse(
            value.familyTask.dateString.split('.').reversed.join());

        if (firstDay.year == dateString.year &&
            firstDay.month == dateString.month &&
            firstDay.day == dateString.day) {
          setState(() {
            _repeatTaskData.add(value);
          });
        }
      }
    }
  }
}
