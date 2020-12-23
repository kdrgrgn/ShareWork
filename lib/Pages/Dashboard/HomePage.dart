import 'package:flutter/material.dart';
import 'package:mobi/Pages/CalendarPage.dart';
import 'package:mobi/Pages/Chat/CommunicationPage.dart';
import 'package:mobi/widgets/ModuleWidget.dart';
import 'package:mobi/Pages/OfficePage.dart';
import 'package:mobi/Pages/Department.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMenuItem();
  }

  getMenuItem() {
    items = [
      {
        'title': "Ofis/Personel",
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
        'notifications': 0,
      },

      {
        'title': "My Safe",
        'path': "/newsIcons/thumbnail_ikon_4_3.png",
        'notifications': 0,
      },
      {
        'title': "Communication",
        'path': "/newsIcons/thumbnail_ikon_3_10.png",
        'page': CommunicationPage(),
        'notifications': 0,
      },
      {
        'title': "Takvim",
        'path': "/newsIcons/thumbnail_ikon_7_5.png",
        'page': CalendarPage(),
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

  my safe
  https://www.share-work.com/newsIcons/thumbnail_ikon_4_3.png
  comunication
  https://www.share-work.com/newsIcons/thumbnail_ikon_3_10.png
  Calendar
  https://www.share-work.com/newsIcons/thumbnail_ikon_7_5.png

*/

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ModuleWidget(
          title: items[index]['title'],
          path: items[index]['path'],
          notification: items[index]['notifications'],
          page: items[index]['page'],
        );
      },
    );
  }
}
