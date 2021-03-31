import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/Pages/Product/ProfilePage.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Services/Services.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/GradientWidget.dart';

import 'CategorySearchResult.dart';
import 'OfficeDetailsPage.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  double x = 0;
  double y = 0;
  bool isLoading = true;
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());
  List<CscData> catTitle = [];
  List<CscData> staticCat = [];
  Services service;
  List<ServiceData> data=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getOfficeServiceList();


          service = await _controllerOffice.getOfficeListWithService(
              _controllerDB.headers(),
            serviceId: 0
              );
          data = service.data;


      setState(() {
        isLoading = false;
      });
      });

  }

  Future<void> getOfficeServiceList() async {
    _controllerOffice
        .getOfficeServiceList(_controllerDB.headers())
        .then((value) {
      if (value == null) {
        getOfficeServiceList();
      } else {
        setState(() {
          catTitle = value.data;
          staticCat = value.data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(primary: false, slivers: [
      SliverAppBar(
        expandedHeight: 280,
        floating: true,
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: MyGradientWidget().linear(
                        start: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 25),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductProfile()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: Image.network(
                          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                        ).image,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55.0, left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: buildFilterButton(context),
                ),
              ),
              Align(
                child: buildCustomAppBar(context).first,
                alignment: Alignment(0, 0.8),
              ),
              Align(
                child: Text(
                  "Aradığınız Nedir?",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                alignment: Alignment(-0.5, 0.0),
              ),
              Align(
                child: Text(
                  "İstediniz hizmeti arayabilirsiniz",
                  style: TextStyle(color: Colors.grey[300]),
                ),
                alignment: Alignment(-0.5, 0.3),
              ),
            ],
          ),
        ),
      ),

      SliverList(
        delegate: SliverChildListDelegate(
          buildServices(),
        ),
      ),

    ]);


  }

  Widget itemSearch(int index) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategorySearchResult(catTitle[index])));
        },
        title: Text(catTitle[index].name),
        subtitle: Text("Kategori"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget buildFilterButton(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.transparent.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "İstanbul   ",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildCustomAppBar(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 40.0, left: 40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          // duration: Duration(milliseconds: 2000),
          child: TextFormField(
            /* onTap: () {
            setState(() {
              width = Get.width - 30;
              searchActive = true;
            });
          },*/
            onChanged: (value) {},
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Birseyler Arayin",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
      ),
    ];
  }

  List<Widget> buildServices() {
    return [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: isLoading
              ? MyCircular()
              : GridView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (context, index) {
                    return listItem(index);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 25,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                ),
        ),
      )
    ];
  }

  Widget listItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(
              builder: (context) =>
                  OfficeDetailsPage(data[index])));
        },
        child: Container(
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    // products[index].images.first ??
                    "https://i.pinimg.com/originals/3f/3d/d9/3f3dd9219f7bb1c9617cf4f154b70383.jpg",
                    fit: BoxFit.cover,

                    //  fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    data[index].title,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    data[index].service.name,
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          "4.9",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right_alt)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
