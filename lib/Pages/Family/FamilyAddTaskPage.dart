import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyTasks.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import '../../widgets/BuildDaysWidget.dart';

class FamilyAddTaskPage extends StatefulWidget {
  @override
  _FamilyAddTaskPageState createState() => _FamilyAddTaskPageState();
}

class _FamilyAddTaskPageState extends State<FamilyAddTaskPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());


  FamilyTasks tasks;
  Family family;

  DateTime today;
  DateTime afterDate;
  DateTime beforeDate;
  bool isLoading = true;
  ScrollController _taskController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = DateTime.now();
    beforeDate = DateTime(today.year, today.month - 6, today.day);
    afterDate = DateTime(today.year, today.month + 6, today.day);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      tasks = await _controller.getAllFamilyTaskList(
          headers: _controller.headers());
      family = await _controller.getFamily(headers: _controller.headers());
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: isLoading?Container():Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                  _controllerChange.baseUrl +
                      "/media/users/" +
                      family.data.picture,
                  fit: BoxFit.contain,
                )),
            SizedBox(width: 5,),
            Text( family.data.title),
          ],
        ),
      ),
      body: isLoading
          ? MyCircular()
          : Column(
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Container(
                      height: 350,
                      decoration: BoxDecoration(),
                      child: buildWidgetWorks()),
                )
              ],
            ),
    );
  }

  Widget buildWidgetWorks() {
    return Stack(
      children: [
        GridView.builder(
          itemCount: tasks.data.length,
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: _taskController,
          itemBuilder: (context, index) {
            String url = _controllerChange.baseUrl +
                "/media/familyTask/" +
                tasks.data[index].category +
                "/" +
                tasks.data[index].picture;

            return Draggable(
              data: tasks.data[index].id,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                    url,
                    fit: BoxFit.contain,
                  )),
              feedback: CircleAvatar(
                  backgroundColor: Colors.white, child: Image.network(url)),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 30, crossAxisSpacing: 30),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 35,
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
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,

                        size: 35,
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

  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: family.data.personList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Image.network(_controllerChange.baseUrl +
                    "/media/users/" +
                    family.data.personList[index].user.profilePhoto),
              ),
            );
          },
        ),
      ),
    );
  }
}
