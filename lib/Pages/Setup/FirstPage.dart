import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

enum OptionType { service, city, country,district }

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());
  Color background = Get.theme.backgroundColor;

  bool isLoading = true;

  List<CscData> _cityList = [];
  List<CscData> _serviceList = [];
  List<CscData> _countryList = [];
  List<CscData> _districtList = [];

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
    return isLoading ? MyCircular() : GetBuilder<ControllerOffice>(
        builder: (office) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (office.idCity.value == 0 ||
                    office.idService.value == 0 ||
                    office.idCountry.value == 0) {
                  Get.showSnackbar(GetBar(
                    message: "Bos deger olamaz",
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  setState(() {
                    isLoading = true;
                  });

                      _controllerOffice.initialPage =
                      _controllerOffice.initialPage++;
                      _controllerOffice.update();
                      /*_controllerDB.updateUser();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => LandingPage()));*/


                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Icon(Icons.arrow_forward, color: Colors.white,),
            ),
            body: Column(
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
                            Text(office.nameService.value.isEmpty
                                ? "Servis Seciniz": office.nameService.value ),
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
                            Text(office.nameCountry.value.isEmpty
                                ? "ulke Seciniz": office.nameCountry.value ),
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
                      if (_cityList.length!=0) {
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
                            Text(office.nameCity.value.isEmpty
                                ? "sehir  Seciniz": office.nameCity.value ),
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
                      if (_districtList.length!=0) {
                        selectOption(OptionType.district, context, _districtList);
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
                            Text(office.nameDistrict.value.isEmpty
                                ? "Ilce Seciniz": office.nameDistrict.value ),
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

                SizedBox(
                  height: 150,
                ),
/*
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
*/
              ],
            ),
          );
        }
    );
  }

  Future<void> getOfficeServiceList() async {
    _controllerOffice
        .getOfficeServiceList(_controllerDB.headers())
        .then((value) {
      if (value == null) {
        getOfficeServiceList();
      } else {
        setState(() {
          _serviceList = value.data;
        });
      }
    });
  }

  void selectOption(OptionType service, BuildContext context,
      List<CscData> data) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return GetBuilder<ControllerOffice>(
              builder: (office) {
                return Container(
                  height: Get.height - 150,
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
                                    _districtList=[];
                                    office.nameCity = data[index].name.obs;
                                    office.update();
                                    office.idCity = data[index].id.obs;
                                    office.update();
                                    office.nameDistrict = "".obs;
                                    office.update();
                                    office.idDistrict = 0.obs;
                                    office.update();

                                  });
                                  break;
                                  case OptionType.district:
                                  setState(() {
                                    office.nameDistrict = data[index].name.obs;
                                    office.update();
                                    office.idDistrict = data[index].id.obs;
                                    office.update();
                                  });
                                  break;

                                case OptionType.country:
                                  setState(() {
                                    _cityList=[];
                                    office.nameCountry = data[index].name.obs;
                                    office.update();
                                    office.idCountry = data[index].id.obs;
                                    office.update();
                                    office.nameCity = "".obs;
                                    office.update();
                                    office.idCity = 0.obs;
                                    office.update();
                                    office.nameDistrict = "".obs;
                                    office.update();
                                    office.idDistrict = 0.obs;
                                    office.update();
                                  });
                                  break;

                                case OptionType.service:
                                  setState(() {
                                    office.nameService = data[index].name.obs;
                                    office.update();
                                    office.idService = data[index].id.obs;
                                    office.update();
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
                              }else if(service == OptionType.city){
                                _controllerDB
                                    .getDistrictList(
                                    _controllerDB.headers(), data[index].id)
                                    .then((value) {
                                  setState(() {
                                    _districtList = value.data;
                                  });
                                });
                              }
                              Navigator.pop(context);
                            },
                            title: Text(data[index].name),
                            trailing: Icon(data[index].id ==
                                idFind(service, office)
                                ? Icons.radio_button_on
                                : Icons.radio_button_off),
                          ),
                        );
                      }),
                );
              }
          );
        });
  }

  int idFind(OptionType type, ControllerOffice office) {
    switch (type) {
      case OptionType.city:
        return office.idCity.value;
        break;
      case OptionType.country:
        return office.idCountry.value;
        break;
        case OptionType.district:
        return office.idDistrict.value;
        break;
      case OptionType.service:
        return office.idService.value;
        break;
    }
  }


}
