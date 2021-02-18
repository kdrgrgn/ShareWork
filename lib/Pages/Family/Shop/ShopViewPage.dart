import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerFamily.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import 'ShopAddPage.dart';

class ShopViewPage extends StatefulWidget {
  @override
  _ShopViewPageState createState() => _ShopViewPageState();
}

class _ShopViewPageState extends State<ShopViewPage> {


  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;

  Family family;
  List<PersonList> _personList;
  bool isLoading = true;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  ControllerFamily _controllerFamily = Get.put(ControllerFamily());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controllerFamily.family.value;
      _personList = family.data.personList;

      setState(() {
        isLoading = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ShopAddPage());
        },
        child: Tab(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
   //   bottomNavigationBar: BuildBottomNavigationBar(),



      appBar: AppBar(title: Text("Shop Page")),

      body: isLoading?MyCircular():SingleChildScrollView(
        child: Column(
            children: [

        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: buildCirclePerson(),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
              height: 360,
              decoration: BoxDecoration(),
              child: buildWShop()),
        ),
      ]
    )
      )

    );
  }





  Widget buildWShop() {
    return GridView.builder(
      itemCount: 20,
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      controller: ScrollController(keepScrollOffset: true),
      itemBuilder: (context, index) {

        return Container(
          child: Wrap(
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: themeColor, width: 0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child:Icon(Icons.shopping_bag_rounded), /*Image.network(
                    url,
                    fit: BoxFit.contain,
                  )*/),
              Text("Shop",style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,),

            ],
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 30, crossAxisSpacing: 20),
    );
  }




  Widget buildCirclePerson() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _personList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage:Image.network(_controllerChange.baseUrl +
                "/media/users/" +
                _personList[index].user.profilePhoto)
                    .image,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

}
