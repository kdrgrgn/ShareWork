import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/CalendarPage.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/Pages/MailPage.dart';
import 'package:mobi/Pages/OfficePage.dart';
import 'package:mobi/Pages/Department.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/model/User/User.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items;

  ControllerChange _controllerChange = Get.put(ControllerChange());
  ControllerDB _controllerDb = Get.put(ControllerDB());

  List<Plugins> _plugins;
  List<Plugins> _filterPlugins=[];
  User _user;
  bool isLoading=true;
  List<int> filterID;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _user = _controllerDb.user.value;
      _user.data.userType == 1 ? getMenuItemOffice() : getMenuItemCustomer();
      /*  _plugins =
      await _controllerDb.getPluginList(headers: _controllerDb.headers());
      if (_user.data.userType == 1) {
        filterID = [1, 2, 3, 6,7];
      }else {
        filterID = [6,7];

      }
      _pluginsFilter();
      */

      setState(() {
        isLoading=false;
      });
    });
  }

  getMenuItemOffice() {
    items = [
      {
        'title': "Ofis",
        'path': "/newsIcons/thumbnail_ikon_7_4.png",
        'page': OfficePage(),
        'notifications': 0,
      },
      {
        'title': "Bölüm",
        'path': "/newsIcons/thumbnail_ikon_7_7.png",
        'page': DepartmentPage(),
        'notifications': 0,
      },
      {
        'title': "Partner",
        'path': "/newsIcons/thumbnail_ikon_7_12.png",
        'page': Container(),
        'notifications': 0,
      },
      {
        'title': "My Safe",
        'path': "/newsIcons/thumbnail_ikon_4_3.png",
        'page': Container(),
        'notifications': 0,
      },

    ];
  }

  getMenuItemCustomer() {
    items = [


      {
        'title': "My Safe",
        'path': "/newsIcons/thumbnail_ikon_4_3.png",
        'page': Container(),
        'notifications': 0,
      },

      {
        'title': "Takvim",
        'path': "/newsIcons/thumbnail_ikon_7_5.png",
        'page': CalendarPage(),
        'notifications': 0,
      }, {
        'title': "Message",
        'path': "/newsIcons/thumbnail_ikon_3_8.png",
        'page': MailPage(),
        'notifications': 0,
      },
      {
        'title': "Communication",
        'path': "/newsIcons/thumbnail_ikon_3_10.png",
        'page': CommunicationPage(),
        'notifications': 0,
      },
    ];
  }

/*
  Dashboard iconlar

  Office
  https://www.share-work.com/newsIcons/thumbnail_ikon_7_4.png
  department
  https://www.share-work.com/newsIcons/thumbnail_ikon_7_7.png
  Partner
  https://www.share-work.com/newsIcons/thumbnail_ikon_7_12.png
  my cloaud

  https://www.share-work.com/newsIcons/thumbnail_ikon_5_2.png bu kaldirirli dah boardttan

Private
https://share-work.com/newsIcons/thumbnail_ikon_5_2.png
  my safe
  https://www.share-work.com/newsIcons/thumbnail_ikon_4_3.png
  comunication
  https://www.share-work.com/newsIcons/thumbnail_ikon_3_10.png
  Calendar
  https://www.share-work.com/newsIcons/thumbnail_ikon_7_5.png

*/
  Color themeColor = Get.theme.accentColor;
  Color backgroundColor = Get.theme.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return isLoading?MyCircular():SingleChildScrollView(
      child:           GridView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: ScrollController(keepScrollOffset: false),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(items[index]['page']);
            },
            child: Container(
              width: 20,
              height: 30,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: Image.network(
                      _controllerChange.baseUrl + items[index]['path'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        items[index]['title'],
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
            childAspectRatio: 1.5,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
      ),
    );
  }

/*

  Widget buildPluginInstall() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: double.infinity,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount:_filterPlugins.length,
          itemBuilder: (context, index) {
            String install="" ;
          */
/*  for(Plugins i in _plugins){
              if(filterID.contains(i.pluginId)){

              }
              else{
                String
              }
            }*//*

if(_plugins.contains(_filterPlugins[index])){
  install="install";
}


            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Container(

                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: backgroundColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          child: Image.network(
                            _controllerChange.baseUrl + _filterPlugins[index].iconUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _filterPlugins[index].pluginName,
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(install,
                    style: TextStyle( fontSize: 15),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _pluginsFilter() {
print("plugins = + " + _plugins.length.toString());
print("filterID = + " + filterID.toString());
    for (Plugins i in _plugins) {
      if (filterID.contains(i.pluginId)) {
        setState(() {
          _filterPlugins.add(i);
        });
      }
    }
  }
*/


}
