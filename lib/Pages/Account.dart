import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/FamilyTabBar.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/User/User.dart';
import 'package:mobi/widgets/InsertFamily.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  final ControllerDB _controller = Get.put(ControllerDB());

  List<AccountModules> modules;

  bool isLoading = true;

  TextStyle subStyle = TextStyle(color: Colors.grey, fontSize: 15);
  User user;
  ControllerChange _controllerChange = Get.put(ControllerChange());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moduleBuilder();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      user = _controller.user.value;

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : GetBuilder<ControllerDB>(builder: (db) {
            return buildHomePage();
          });
  }

  buildHomePage() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      bottomNavigationBar: BuildBottomNavigationBar(),
      body: Stack(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.network(
                              "https://share-work.com/newsIcons/thumbnail_ikon_logout.png")),
                      Container(
                          width: 30,
                          height: 30,
                          child: Stack(
                            children: [
                              Image.network(
                                  "https://share-work.com/newsIcons/ikonlar_ek_6.png"),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  /*    width: 10,
                                  height: 10,*/
                                  decoration: BoxDecoration(
                                    color: background,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "12",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(user.data.firstName + " " + user.data.lastName),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'msg'.trArgs(['Easy localization', 'Dart'])//(args: ['Easy localization', 'Dart'])
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 600,
                      child: cardBuilder(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.80),
            child: CircleAvatar(
              backgroundImage: Image.network(
                user.data.profilePhoto,
                fit: BoxFit.fill,
              ).image,
              radius: 60,
            ),
          )
        ],
      ),
    );
  }

  cardBuilder() {
    return ListView.builder(
      itemCount: modules.length,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      //physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: ScrollController(keepScrollOffset: true),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.only(bottom: 5, top: 5, right: 5, left: 5),
            child: Column(
              children: [
                ListTile(
                  onTap: () async {},
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        Image.network(modules[index].picture).image,
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(modules[index].name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

  moduleBuilder() {
    modules = [
      AccountModules(
          picture:
              "https://share-work.com/newsIcons/thumbnail_ikon_settings.png",
          name: "Settings",
          route: 0),
      AccountModules(
          picture:
              "https://share-work.com/newsIcons/thumbnail_ikon_agreement.png",
          name: "Agreement",
          route: 2),
      AccountModules(
          picture:
              "https://share-work.com/newsIcons/thumbnail_ikon_security.png",
          name: "Security",
          route: 3),
      AccountModules(
          picture: "https://share-work.com/newsIcons/thumbnail_ikon_help.png",
          name: "Help",
          route: 4),
    ];
  }
}

class AccountModules {
  String picture;
  String name;
  int route;

  AccountModules({this.picture, this.name, this.route});
}
