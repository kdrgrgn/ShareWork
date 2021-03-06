import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/Pages/Setup/FirstPage.dart';
import 'SecondPage.dart';
import 'ThirdPage.dart';

enum OptionType { service, city, country }

class OfficeSetup extends StatefulWidget {
  @override
  _OfficeSetupState createState() => _OfficeSetupState();
}

class _OfficeSetupState extends State<OfficeSetup> {
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());


  List<Widget> formWidget=[FirstPage(),SecondPage(),ThirdPage()];



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Setup Office"),
      ),
      body: GetBuilder<ControllerOffice>(
        builder: (office) {
          return formWidget[office.initialPage.value];
        }
      ) ,
    );
  }



/*
  void selectOption(OptionType service, BuildContext context,
      List<CscData> data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose One"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.red,
                ),
              )
            ],
            content: Container(
              height: Get.height - 300,
              width: Get.width,
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration:
                      BoxDecoration(border: Border(bottom: BorderSide())),
                      child: ListTile(
                        onTap: () {
                          switch (service) {
                            case OptionType.city:
                              setState(() {
                                nameCity = data[index].name;
                                idCity = data[index].id;
                              });
                              break;

                            case OptionType.country:
                              setState(() {
                                nameCountry = data[index].name;
                                idCountry = data[index].id;
                                nameCity = null;
                                idCity = null;
                              });
                              break;

                            case OptionType.service:
                              setState(() {
                                nameService = data[index].name;
                                idService = data[index].id;
                              });
                              break;
                          }
                          if (service == OptionType.country) {
                            _controllerDB
                                .getCityList(
                                _controllerDB.headers(), data[index].id)
                                .then((value) {
                              setState(() {
                                _cityList = value.data;
                              });
                            });
                          }
                          Navigator.pop(context);
                        },
                        title: Text(data[index].name),
                        trailing: Icon(data[index].id == idFind(service)
                            ? Icons.radio_button_on
                            : Icons.radio_button_off),
                      ),
                    );
                  }),
            ),
          );
        });
  }
*/

/*
  int idFind(OptionType type) {
    switch (type) {
      case OptionType.city:
        return idCity;
        break;
      case OptionType.country:
        return idCountry;
        break;
      case OptionType.service:
        return idService;
        break;
    }
  }
*/

/*
  Future<void> getOfficeServiceList() async{
    _controllerOffice
        .getOfficeServiceList(_controllerDB.headers())
        .then((value) {
          if(value==null) {
            getOfficeServiceList();
          }else{
            setState(() {
              _serviceList = value.data;
            });
          }

    });
  }
*/
}
