import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Office/Office.dart';
import 'package:mobi/model/Personels/PersonelData.dart';
import 'package:mobi/model/Personels/Personels.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import '../widgets/MyCircularProgress.dart';


class OfficePage extends StatefulWidget {
  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  Color themeColor;

  ControllerDB _controller=Get.put(ControllerDB());

  Office _office;
  Personels _personels;
  List<PersonelData> _personelData;
  bool isLoading=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     _personels= await _controller.getPersonelList(headers: _controller.headers() );
     _personelData=_personels.data;
   _office= await  _controller.getOffice(headers :_controller.headers());
   setState(() {
     isLoading=false;
   });
    });
  }


  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;
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

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Ofis",
          style: TextStyle(color: themeColor),
        ),
        iconTheme: IconThemeData(color: themeColor),
      ),
      body: GetBuilder<ControllerDB>(builder: (c){
        return isLoading?MyCircular():ListView(
          children: [
            _office.data==null?Text("Ofis yok"):firstCard(),

            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Personel",style: TextStyle(fontSize: 25,color: Colors.black),),
                  ),
                ],
              ),
            ),
            _personelData.length==0?Text("Personel Yok"): ListView.builder(
              itemCount: _personelData.length,
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (context,index){
                return personelCards(_personelData[index]);
              },
            )
          ],
        );
      },),
    );
  }

  Widget firstCard() {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 0.2),
            ),
            child: Row(
              children: [
          Icon(
            Icons.person,
              size: 100,
            ),
                Column(
                  children: [
                    Text(
                      _office.data.title,
                      style: TextStyle(color: Colors.black,fontSize: 18),
                    ),
                    SizedBox(height: 10,),
                    Text(_office.data.description,style:TextStyle(fontSize: 15)),
                  ],
                )
              ],
            ),
          ),
        );
  }
  Widget personelCards(PersonelData data) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 0.2),
            ),
            child: Row(
              children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                  size: 60,
                ),
            ),
          ),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data.firstName +" "+ data.lastName,
                              style: TextStyle(color: Colors.black,fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Text(data.title.toString(),style:TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
  }
}
