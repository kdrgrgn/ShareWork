import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/Task/MonthlyBuild.dart';
import 'package:mobi/Pages/Family/Task/WeeklyBuild.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/RepeatTasks.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import 'package:mobi/widgets/buildFamilyBottomNavigationBar.dart';

class AddFavTask extends StatefulWidget {
  @override
  _AddFavTaskState createState() => _AddFavTaskState();
}

class _AddFavTaskState extends State<AddFavTask>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controllerDB = Get.put(ControllerDB());
  FamilyTasks tasks;
  List<FamilyTaskData> taskData = [];
  Family family;
  bool isLoading = true;
  RepeatTasks _repeatTask;

  List<Widget> listTab = [
    Tab(icon: Text("Weekly")),
    Tab(icon: Text("Monthly")),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: listTab.length, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      tasks = await _controllerDB.getAllFamilyTaskList(
          headers: _controllerDB.headers());
      taskData = tasks.data;
      family = _controllerDB.family.value;


      _repeatTask = await _controllerDB.getFamilyPersonTaskListRepeat(familyId: family.data.id,
          headers: _controllerDB.headers());



      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  bottomNavigationBar: BuildBottomNavigationBar(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          indicatorColor: background,
          labelColor: themeColor,
          tabs: listTab,
        ),
        title: Text('Tabs Demo'),
      ),
      body:  isLoading
          ? MyCircular()
          : TabBarView(
        controller: _controller,
        children: [
          WeeklyBuild(
            taskData: taskData,
            family: family,

            repeatTaskData: _repeatTask,
          ),    MonthlyBuild(
            taskData: taskData,
            family: family,

            repeatTaskData: _repeatTask,
          ),
        ],
      ),
    );
  }


}
