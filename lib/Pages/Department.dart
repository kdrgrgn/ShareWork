import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import '../widgets/MyCircularProgress.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Department/Department.dart';
import 'package:mobi/model/Department/DepartmentData.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  Color themeColor;

Department _department;
  ControllerDB _controller=Get.put(ControllerDB());
  bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _department=await  _controller.getDepartmentList(headers: _controller.headers());
      setState(() {
        isLoading=false;
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;

    return Scaffold(
      bottomNavigationBar: BuildBottomNavigationBar(),
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
      appBar: AppBar(
        title: Text(
          "Department",
          style: TextStyle(color: themeColor),
        ),
        iconTheme: IconThemeData(color: themeColor),
      ),
      body: GetBuilder<ControllerDB>(builder: (c){
        return isLoading?MyCircular():_department.data.length==0?Text("Department yok"):ListView.builder(
          itemCount: _department.data.length,
          itemBuilder: (context, index) {
            return cardBuilder(_department.data[index]);
          },
        );
      },),
    );
  }

  Widget cardBuilder(DepartmentData data) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(data.description),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        color: Colors.teal,

                        onPressed: () {},
                        child: Text(
                          "Customers",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(data.email),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(data.phone),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(data.location),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
