import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CategorySearchResult.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  double x = 0;
  double y = 0;

  List<String> catTitle = [
    "Software",
    "Home Cleaning",
    "Home Safetity",
    "Mobile Developer",
    "Web Developer",

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height-100,
      child: Column(
        mainAxisAlignment:y==0? MainAxisAlignment.center:MainAxisAlignment.start,
        children: [
          AnimatedAlign(
            duration: Duration(seconds: 1),
            alignment: Alignment(x, y),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (value) {},
                onTap: () {
                  setState(() {
                    y = -1;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Birseyler Arayin",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0))),
              ),
            ),
          ),
         y==0?Container(): Expanded(
           child: ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: true),
            itemCount: catTitle.length,
            itemBuilder: (context, index) {
              return itemSearch(index);
            }),
         ),
        ],
      ),
    );
  }

  Widget itemSearch(int index) {
    return Card(
      child: ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategorySearchResult()));
        },
        title: Text(catTitle[index]),
        subtitle: Text("Kategori"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}


