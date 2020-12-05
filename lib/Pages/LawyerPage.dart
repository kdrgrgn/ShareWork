import 'package:flutter/material.dart';
import 'package:mobi/widgets/plugin.dart';
class LawyerPage extends StatefulWidget {
  @override
  _LawyerPageState createState() => _LawyerPageState();
}

class _LawyerPageState extends State<LawyerPage> {
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
        'title': "Ofis",
        'path': "assets/images/svg_png/my office/gray/128h/Artboard 1.png",
        'notifications': 4,
      },
      {
        'title': "Bölüm",
        'path': "assets/images/svg_png/department/gray/128h/Artboard 1.png",
        'notifications': 4,
      },
      {
        'title': "My Cloud",
        'path': "assets/images/svg_png/my cloud/my cloud gray/128.png",
        'notifications': 4,
      },
      {
        'title': "My Safe",
        'path': "assets/images/svg_png/my safe/gray/128h/Artboard 1.png",
        'notifications': 4,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide()
              ),
            ),


            items: [
              DropdownMenuItem(
                value: '0',
                child: Text("User Test"),
              ),
              DropdownMenuItem(
                value: '1',
                child: Text("User Test1"),
              ),
              DropdownMenuItem(
                value: '2',
                child: Text("User Test2"),
              ),
            ],
            onChanged: (value) {},
          ),
        ),
        buildListView(),
      ],
    );
  }

  Widget buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MyPlugin(
          title: items[index]['title'],
          path: items[index]['path'],
          notification: items[index]['notifications'],
        );
      },
    );
  }
}
