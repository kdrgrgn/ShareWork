import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Pages/Family/FamilyHomePage.dart';
import 'package:mobi/Pages/Product/ProductPage.dart';
import 'package:mobi/Pages/Project/ProjectList.dart';
import 'package:mobi/Pages/ServicePage/ServicePage.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/widgets/DrawerMenuWidget.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'PluginListPage.dart';
import 'PluginPage.dart';

class Dashboard extends StatefulWidget {
  int page;

  Dashboard({this.page});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  bool isOpen = false;
  Color themeColor=Get.theme.accentColor;
  Color backGround = Get.theme.backgroundColor;
  List<Widget> item;
  List<Widget> title = [];
  int initialPage;
  int familyCount;
  int productCount;
  int servicesCount;
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


      drawerStyle = TextStyle(color: themeColor, fontSize: 15);
      await titleBuilder();

      setState(() {
        isloading = false;
      });
    });
  }

  void buildPlugin() {
    List<Plugins> plugins = _controller.user.value.data.plugins;
item=[];
    //item.add(HomePage());
/*    item = [
      HomePage(),
    ];*/

    for (int i = 0; i < plugins.length; i++) {
      if (plugins[i].pluginId == 7) {
        item.add(FamilyHomePage());
        _controllerChange.updateFamily(i );
        setState(() {
          familyCount = i ;
        });
      } else if (plugins[i].pluginId == 6) {
        item.add(ProjectListPage());

      }
      else if(plugins[i].pluginId ==9){
        item.add(ProductPage());
        setState(() {
          productCount = i ;

        });
      }    else if(plugins[i].pluginId ==9){
        item.add(ProductPage());
        setState(() {
          productCount = i ;

        });
      } else if(plugins[i].pluginId ==10){
        item.add(ServicePage());
        setState(() {
          servicesCount = i ;
        });

      }
      else {
        item.add(PluginPage(plugin: plugins[i]));
      }
    }

  }

  Future<void> titleBuilder() async {
    List<Plugins> plugins = _controller.user.value.data.plugins;
title=[];
    setState(() {
/*      title = [
        Builder(
          builder: (context) => InkWell(
            child: Container(
              height: 170,
              width: 200,
              child: Image.asset(
                "assets/images/logo/sharework_logo.png",
                fit: BoxFit.contain,
                // height: 15,
                // width: 34,
              ),
            ),
          ),
        ),
      ];*/
      for (int i = 0; i < plugins.length; i++) {

        title.add(
          Container(
            height: 30,
            width: 30,
            child: Image.network(
              _controllerChange.baseUrl + plugins[i].iconUrl,
              fit: BoxFit.contain,
              // height: 15,
              // width: 34,
            ),
          ),
        );
      }
      isloadingAppBar = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return isloading
        ? MyCircular()
        : GetBuilder(

      builder: (ControllerDB plugins) {
        if(item.length!=plugins.user.value.data.plugins.length){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            buildPlugin();
            titleBuilder();
          });


        }


        return Scaffold(

          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          appBar: initialPage == familyCount || initialPage==productCount || initialPage==servicesCount
              ? null
              : AppBar(
                  automaticallyImplyLeading: false,

                  centerTitle: false,
                  // backgroundColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Image.asset(
                            "assets/newsIcons/thumbnail_ikonlar_ek_4.png",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: isloadingAppBar ? Container() : title[initialPage],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                                "assets/newsIcons/thumbnail_ikon_7_5.png"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                                "assets/newsIcons/ikonlar_ek_6.png"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          drawer: isloading
              ? MyCircular()
              :DrawerMenu(_controller),
          body: Stack(children: [
                  CarouselSlider(
                      items: item,
                      options: CarouselOptions(
                        height: initialPage == familyCount
                            ? MediaQuery.of(context).size.height
                            : MediaQuery.of(context).size.height,
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
                    alignment: Alignment(0, initialPage == familyCount ? 0.9 : 0.9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: item.map((url) {
                        int index = item.indexOf(url);
                        return Container(
                          width: index == initialPage ? 15 : 10.0,
                          height: index == initialPage ? 15 : 10.0,
                          margin:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  initialPage == index ? backGround : Colors.grey),
                        );
                      }).toList(),
                    ),
                  ),
                ]),

          floatingActionButton: buildFabPlugin(),
        );
      }
    );
  }


  FloatingActionButton buildFabPlugin() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(PluginListPage());
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
}
