import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Project/Project.dart';
import 'package:mobi/model/Project/ProjectList.dart';
import 'package:mobi/model/Project/ToDoList.dart';


class ProjectPage extends StatefulWidget {
  ProjectList projectList;
  Project project;

  ProjectPage({this.projectList,this.project});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  double formWidth = 0;
  double formHeight = 0;
  ControllerChange _controllerChange = Get.put(ControllerChange());
  ControllerDB _controller = Get.put(ControllerDB());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Project Page")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.projectList.title,
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.edit),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tasks",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "File",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        child: Image.network(
                            _controllerChange.baseUrl +
                                "/media/users/"+widget.projectList.usersList[0].profilePhoto,
                            fit: BoxFit.contain,
                            headers: _controller.headers()),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        width: formWidth,
                        height: formHeight,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.blue[100]),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              formWidth = 200;
                              formHeight = 40;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.add,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(value: false, onChanged: (newValue) {}),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                ),
                Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.mail_outline_rounded,
                        size: 30,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.filter_list,
                          size: 30,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.settings_rounded,
                          size: 30,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.teal[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "NEW TODO",
                          style: TextStyle(fontSize: 22, color: Colors.teal),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              itemCount: widget.projectList.todosList.length,
              itemBuilder: (context, index) {
                TodosList _todo=widget.projectList.todosList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Get.theme.backgroundColor.withOpacity(0.5),

                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Checkbox(value: false, onChanged: (newValue) {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(Icons.star),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(Icons.bookmark_outline_outlined),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(_todo.title),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                )
                              ],
                            )

                          ],
                        ),
                        SizedBox(
                        height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              child: Image.network(
                                  _controllerChange.baseUrl +
                                      "/media/users/107_4e744480-ed7b-4e9b-8ae6-7a5f03ff0341.png",
                                  fit: BoxFit.contain,
                                  headers: _controller.headers()),
                            ),

                            AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: formWidth,
                              height: formHeight,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(color: Colors.blue[100]),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    formWidth = 160;
                                    formHeight = 40;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 15,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(_todo.startDate),
                              ],
                            ),
                            Column(
                              children: [
                                Text(_todo.endDate),

                              ],
                            )
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        )




                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
