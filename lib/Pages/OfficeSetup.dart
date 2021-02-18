import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

import '../landingPage.dart';

enum OptionType { service, city, country }

class OfficeSetup extends StatefulWidget {
  @override
  _OfficeSetupState createState() => _OfficeSetupState();
}

class _OfficeSetupState extends State<OfficeSetup> {
  int initialPage = 0;
  Color background = Get.theme.backgroundColor;
  String nameService;
  String nameCity;
  String nameCountry;

  int idService;
  int idCity;
  int idCountry;
  bool isLoading = true;
  List<CscData> _cityList=[];
  List<CscData> _serviceList=[];
  List<CscData> _countryList=[];

  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    await getOfficeServiceList();

      _controllerDB.getCountryList(_controllerDB.headers()).then((value) {
        _countryList = value.data;
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup Office"),
      ),
      body: isLoading
          ? MyCircular()
          : Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: InkWell(
              onTap: () {
                selectOption(OptionType.service, context, _serviceList);
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(nameService ?? "Servis Seciniz"),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: InkWell(
              onTap: () {
                selectOption(OptionType.country, context, _countryList);
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(nameCountry ?? "Ulke Seciniz"),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
            child: InkWell(
              onTap: () {
                if (_cityList != null) {
                  selectOption(OptionType.city, context, _cityList);
                }
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(nameCity ?? "Sehir Seciniz"),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                if (idCity == null ||
                    idService == null ||
                    idCountry == null) {
                  Get.showSnackbar(GetBar(
                    message: "Bos deger olamaz",
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  _controllerOffice
                      .editOfficeService(_controllerDB.headers(),
                      serviceId: idService,
                      countryId: idCountry,
                      cityId: idCity)
                      .then((value) {
                    if (value == true) {
                      _controllerDB.updateUser();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LandingPage()));
                    }
                  });
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Container(
                width: Get.width,
                color: Get.theme.accentColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

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
}
