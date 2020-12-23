import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/FamilyTasks.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import '../../widgets/BuildDaysWidget.dart';

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
      family = await _controller.getFamily(headers: _controller.headers());
      _personList = family.data.personList;
      _familyPerson = await _controller.getFamilyPersonWithId(
          headers: _controller.headers(),
          id: _personList[personIndex].id,
          date: buildStringDate(DateTime.now()));
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerChange>(builder: (c) {
      if (c.selectedDay.value != _selectedDate) {
        _controller
            .getFamilyPersonWithId(
                headers: _controller.headers(),
                id: _personList[personIndex].id,
                date: buildStringDate(c.selectedDay.value))
            .then((value) {
          setState(() {
            _familyPerson = value;
          });
        });
      }

      return Scaffold(
        body: isLoading
            ? MyCircular()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, top: 5),
                      child: BuildWidgetDays(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: buildCirclePerson(),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.network(
                                _controllerChange.baseUrl +
                                    "/media/users/" +
                                    family.data.personList[personIndex].user
                                        .profilePhoto,
                                fit: BoxFit.contain,
                              )),
                        ),
                        Text(family
                                .data.personList[personIndex].user.firstName +
                            " " +
                            family.data.personList[personIndex].user.lastName)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 350,
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
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Tasks",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            buildWidgetWorks(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  Widget buildWidgetWorks() {
    return GridView.builder(
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

        return CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.network(
              url,
              fit: BoxFit.contain,
            ));
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 30, crossAxisSpacing: 30),
    );
  }

  Widget buildCirclePerson() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: family.data.personList.length,
        itemBuilder: (context, index) {
          return Align(
            widthFactor: 0.8,
            alignment: Alignment.centerLeft,
            child: Image.network(_controllerChange.baseUrl +
                "/media/users/" +
                family.data.personList[index].user.profilePhoto),
          );
        },
      ),
    );
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }
}
