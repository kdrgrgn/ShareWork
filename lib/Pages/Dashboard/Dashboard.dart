import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Pages/Family/FamilyViewPage.dart';
import 'package:mobi/Pages/Project/ProjectList.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/widgets/ModuleWidget.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import 'package:mobi/widgets/buildFamilyBottomNavigationBar.dart';

import '../Family/FamilyAddTaskPage.dart';
import 'PluginPage.dart';
import 'HomePage.dart';

class Dashboard extends StatefulWidget {
  int page;

  Dashboard({this.page});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Color themeColor;
  Color backGround = Get.theme.backgroundColor;
  List<Widget> item;
  List<Widget> title;
  int initialPage;
  int familyCount;
  int projectCount;
  TextStyle drawerStyle;
  bool isloading = true;
  bool isloadingAppBar = true;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        initialPage = widget.page ?? 0;
      });

      buildPlugin();

      themeColor = Theme.of(context).accentColor;

      drawerStyle = TextStyle(color: themeColor, fontSize: 15);

      await titleBuilder();
      setState(() {
        isloading = false;
      });
    });
  }

  void buildPlugin() {
    List<Plugins> plugins = _controller.user.value.data.plugins;
    item = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: HomePage(),
      ),
    ];
    for (int i = 0; i < plugins.length; i++) {
      if (plugins[i].pluginId == 7) {
        item.add(FamilyViewPage());
        _controllerChange.updateFamily(i + 1);
        setState(() {
          familyCount = i + 1;
        });
      } else if (plugins[i].pluginId == 6) {
        item.add(ProjectListPage());
        setState(() {
          projectCount = i + 1;
        });
      } else {
        item.add(PluginPage(plugin: plugins[i]));
      }
    }
  }

  Future<void> titleBuilder() async {
    List<Plugins> plugins = _controller.user.value.data.plugins;

    setState(() {
      title = [
        Builder(
          builder: (context) => InkWell(
            child: Container(
              height: 120,
              width: 120,
              child: Image.asset(
                "assets/images/logo/sharework_logo.png",
                fit: BoxFit.contain,
                // height: 15,
                // width: 34,
              ),
            ),
          ),
        ),
      ];
      for (int i = 0; i < plugins.length; i++) {
        title.add(
          Text(
            plugins[i].pluginName,
            style: TextStyle(color: themeColor),
          ),
        );
      }
      isloadingAppBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
      key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: initialPage != familyCount
            ?
                FloatingActionButton(
                  onPressed: () {},
                  child: Tab(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )

            : FloatingActionButton(
              onPressed: () {
                Get.to(FamilyAddTaskPage());
              },
              child: Tab(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
        appBar: initialPage == familyCount
            ? AppBar(
                // backgroundColor: Colors.white,
                automaticallyImplyLeading: false,

                centerTitle: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Family"),
                    Row(children: [
                      Container(
                        width: 35,
                          height: 35,
                          child: Image.network(
                              "https://www.share-work.com/newsIcons/thumbnail_ikon_7_5.png")),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 35,
                          height: 35,
                          child: Image.network(
                              "https://share-work.com/newsIcons/ikonlar_ek_6.png")),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 35,
                          height: 35,
                          child: Image.network(
                            "https://www.share-work.com/newsIcons/thumbnail_ikon_7_8.png",
                          ))
                    ])
                  ],
                ),
              )
            : AppBar(
          automaticallyImplyLeading: false,

          centerTitle: false,
                // backgroundColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Image.network(
                          "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_4.png",
                        ),
                      ),
                    )              ,
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: isloadingAppBar ? Container() : title[initialPage],
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      child: Image.network(
                          "https://share-work.com/newsIcons/ikonlar_ek_6.png"),
                    )
                  ],
                ),
              ),
        drawer: isloading
            ? MyCircular()
            : Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Drawer(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.network(
                                      _controller.user.value.data.profilePhoto),
                                  radius: 30,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _controller.user.value.data.firstName +
                                        " " +
                                        _controller.user.value.data.lastName,
                                    style: drawerStyle,
                                  ),
                                  Text(
                                    _controller.user.value.data.email,
                                    style: drawerStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Add-on",
                                style: drawerStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(keepScrollOffset: false),
                          itemCount: _controller.user.value.data.plugins.length,
                          itemBuilder: (context, index) {
                            Plugins _plugin =
                                _controller.user.value.data.plugins[index];
                            return ModuleWidget(
                                title: _plugin.pluginName,
                                path: _plugin.pluginName);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: themeColor,
                          ),
                          Text(
                            "Çıkıs",
                            style: drawerStyle,
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ),
        body: isloading
            ? MyCircular()
            : Stack(children: [
                CarouselSlider(
                    items: item,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height - 180,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: initialPage,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      onPageChanged: (current, reason) {
                        _controllerChange.updateInitialPage(current);
                        setState(() {
                          initialPage = current;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    )),
                Align(
                  alignment: Alignment(0, 0.7 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: item.map((url) {
                      int index = item.indexOf(url);
                      return Container(
                        width: index == initialPage ? 15 : 10.0,
                        height: index == initialPage ? 15 : 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: initialPage == index
                                ? backGround
                                : Colors.grey),
                      );
                    }).toList(),
                  ),
                ),
              ]),
        bottomNavigationBar: _controllerChange.familyIsActive.value &&
                _controllerChange.familyCount.value ==
                    _controllerChange.initialPage.value
            ? BuilFamilyBottomNavigationBar()
            : BuildBottomNavigationBar());
  }
}
