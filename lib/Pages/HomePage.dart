import 'package:flutter/material.dart';
import 'package:mobi/widgets/plugin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String,dynamic>> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getMenuItem();
  }
  getMenuItem(){
    items = [
      {
        'title': "Ofis",
        'path': "assets/images/svg_png/my office/gray/128h/Artboard 1.png",
        'notifications': 0,

      }, {
        'title':"Bölüm",
        'path':"assets/images/svg_png/department/gray/128h/Artboard 1.png",
        'notifications': 0 ,

      }, {
        'title': "My Cloud",
        'path':"assets/images/svg_png/my cloud/my cloud gray/128.png",
        'notifications':0,

      }, {
        'title':"My Safe",
        'path':"assets/images/svg_png/my safe/gray/128h/Artboard 1.png",
        'notifications':0,

      },


    ];
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
    itemBuilder: (context,index){
      return MyPlugin(title: items[index]['title'],path: items[index]['path'],notification: items[index]['notifications'],);
    },
    );
  }
}
