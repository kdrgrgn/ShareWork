import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/FamilyTabBar.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/InsertFamily.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import 'AddUserPage.dart';
import 'Task/UserInfoPage.dart';

class FamilyHomePage extends StatefulWidget {
  @override
  _FamilyHomePageState createState() => _FamilyHomePageState();
}

class _FamilyHomePageState extends State<FamilyHomePage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
   ControllerFamily _controllerFamily = Get.put(ControllerFamily());
   ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  List<FamilyModules> modules;

  bool isLoading = true;

  TextStyle subStyle = TextStyle(color: Colors.grey, fontSize: 15);
  Family family;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moduleBuilder();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = await _controllerFamily.getFamily(
          headers: _controllerDB.headers(),
          date: buildStringDate(DateTime.now()));

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : GetBuilder<ControllerFamily>(builder: (db) {
            if (family.data.personList == null) {
              if (db.family.value != family) {
                db
                    .getFamily(
                        headers: _controllerDB.headers(),
                        date: buildStringDate(DateTime.now()))
                    .then((value) {
                  setState(() {
                    family = value;
                  });
                });
              }
            }

            return family.data.personList == null
                ? InsertFamilyWidget()
                : buildHomePage();
          });
  }

  buildHomePage() {
    return Scaffold(
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
                      Icon(Icons.share),
                      Container(
                          width: 30,
                          height: 30,
                          child: Stack(
                            children: [
                              Image.asset(
                                  "assets/newsIcons/ikonlar_ek_6.png"),
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
                  Text(family.data.title),
                  SizedBox(
                    height: 20,
                  ),
                  buildCirclePerson(),
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
                _controllerChange.urlFamilyPicture + family.data.picture,
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
    return GridView.builder(
      itemCount: modules.length,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      //physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: ScrollController(keepScrollOffset: true),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FamilyTabBar(
                      tabIndex: modules[index].route,
                    )));
          },
          child: Container(
            width: 20,
            height: 30,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(modules[index].picture)),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      modules[index].name,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
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
      FamilyModules(
          picture:
              "assets/newsIcons/thumbnail_ikonlar_ek_8.png",
          name: "Task",
          route: 0),
      FamilyModules(
          picture:
              "assets/newsIcons/thumbnail_ikonlar_ek_5.png",
          name: "Social",
          route: 1),
      FamilyModules(
          picture:
              "assets/newsIcons/thumbnail_ikon_3_7.png",
          name: "Gift",
          route: 2),
      FamilyModules(
          picture: "assets/newsIcons/thumbnail_ikon_4_2.png",
          name: "Budget",
          route: 3),
      FamilyModules(
          picture:
              "assets/newsIcons/thumbnail_ikon_shopping.png",
          name: "Shop",
          route: 4),
/*      FamilyModules(
          picture: "assets/newsIcons/thumbnail_ikon_dugun.png",
          name: "Düğün",
          route: 4),*/
      FamilyModules(
          picture: "assets/newsIcons/thumbnail_ikon_hal.png",
          name: "Kampanya",
          route: 4),
/*      FamilyModules(
          picture: "assets/newsIcons/thumbnail_ikon_takas.png",
          name: "Takas",
          route: 4),
      FamilyModules(
          picture:
              "assets/newsIcons/thumbnail_ikon_yemektarifi.png",
          name: "Tarif",
          route: 4),*/
    ];
  }

  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 80,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: ScrollController(keepScrollOffset: true),
          children: personBuild(),
        ),
      ),
    );
  }

  List<Widget> personBuild() {
    List<Widget> person;

    person = [
      InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddUserPage()))
              .then((value) {
            _controllerFamily
                .getFamily(
                    headers: _controllerDB.headers(),
                    date: buildStringDate(DateTime.now()))
                .then((value) {
              setState(() {
                family = value;
              });
            });
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 15),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent,
                border: Border.all(color: background)),
            width: 65,
            height: 35,
            child: Image.asset(
              "assets/newsIcons/thumbnail_ikon_3_2.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      )
    ];

    for (PersonList e in family.data.personList) {
      int index = family.data.personList.indexOf(e);

      person.add(buildPadding(index));
    }

    return person;
  }

  Padding buildPadding(int index) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Container(
          width: 75,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      UserInfo(family.data.personList[index])));
            },
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    backgroundImage: Image.network(_controllerChange.urlUsers +
                            family.data.personList[index].user.profilePhoto)
                        .image,
                  ),
                ),
                Text(
                  family.data.personList[index].user.firstName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ));
  }
}

class FamilyModules {
  String picture;
  String name;
  int route;

  FamilyModules({this.picture, this.name, this.route});
}
