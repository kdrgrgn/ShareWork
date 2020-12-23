import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Animation/ScaleRoute.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/model/Project/Project.dart';
import 'package:mobi/model/Project/ProjectList.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import 'ProjectPage.dart';

class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  Color themeColor = Get.theme.accentColor;

  List<Widget> itemsData = [];

  bool closeTopContainer = false;
  double topContainer = 0;
  ScrollController scrollController = ScrollController();
  ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());

  Project _projects;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _projects = await _controller.getProjectList(
          headers: _controller.headers(),
          userID: _controller.user.value.data.id);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : _projects.data.projectList.length == 0
            ? Center(child: Text("Şu an proje yok"))
            : ListView.builder(
                controller: scrollController,
                itemCount: _projects.data.projectList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  ProjectList post = _projects.data.projectList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          ScaleRoute(
                              page: ProjectPage(
                            project: _projects,
                            projectList: post,
                          )));
                    },
                    child: Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  blurRadius: 10.0),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        post.title,
                                        style: const TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(Icons.edit)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Tasks",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
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
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 30,
                                child: Image.network(
                                  _controllerChange.baseUrl +
                                      "/media/users/" +
                                      post.usersList[0].profilePhoto,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                });
  }
}
