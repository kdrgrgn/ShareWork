import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerProduct.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';

enum OptionType { city, country, district }

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> categoryUrl = [
    "assets/newsIcons/thumbnail_ikon_money.png",
    "assets/newsIcons/thumbnail_ikon_shopping.png",
    "assets/newsIcons/thumbnail_ikon_food.png",
    "assets/newsIcons/thumbnail_ikon_journey.png",
    "assets/newsIcons/thumbnail_ikon_kasa.png",
    "assets/newsIcons/thumbnail_ikon_bill.png",
    "assets/newsIcons/thumbnail_ikon_fuel.png",
    "assets/newsIcons/thumbnail_ikon_rent.png",
  ];
  List<String> category = [
    "Harclik",
    "Alisveris",
    "Yemek",
    "Gezi",
    "Kasa",
    "Fatura",
    "Benzin",
    "Kira",
  ];
  ControllerProduct _controllerProduct = Get.put(ControllerProduct());

  List<Color> categoryColor = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.cyanAccent,
    Colors.deepPurpleAccent,
    Colors.brown,
  ];

  ControllerDB _controllerDB = Get.put(ControllerDB());
  Color background = Get.theme.backgroundColor;

  bool isLoading = true;

  List<CscData> _cityList = [];
  List<CscData> _countryList = [];
  List<CscData> _districtList = [];
  String nameCountry = "";
  String nameDistrict = "";
  String nameCity = "";
  String key = "";


  int countryID=0;
int min=0;
  int max=0;

  int cityID=0;

  int districtID=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
        title: Text("Filter Page"),
        actions: [

          Icon(Icons.refresh,
            size: 32,
        )],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                Container(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryUrl.length,
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      controller: ScrollController(keepScrollOffset: false),
                      itemBuilder: (context, index) {
                        return categoryItem(index);
                      }),
                ),

                Divider(),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    color: Colors.grey[200],
                    child: TextFormField(
                      onChanged: (value){
                        setState(() {
                          key=value;

                        });
                      },
                      decoration: InputDecoration(hintText: "Kelime Arayin",border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[200],
                          child: TextFormField(                      onChanged: (value){
                            setState(() {
                              min=int.parse(value);

                            });
                          },
                            decoration: InputDecoration(hintText: "Min Price",border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      Text("   --   ",style: TextStyle(color: Colors.black),),

                      Expanded(
                        child: Container(
                          color: Colors.grey[200],
                          child: TextFormField(    onChanged: (value){
                            setState(() {
                              max=int.parse(value);

                            });
                          },
                            decoration: InputDecoration(hintText: "Max Price",border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: InkWell(
                    onTap: () {
                      selectOption(OptionType.country, context, _countryList);
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(nameCountry.isEmpty ? "ulke Seciniz" : nameCountry,style: TextStyle(color: Colors.grey),),
                            Icon(Icons.keyboard_arrow_down,color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: InkWell(
                    onTap: () {
                      if (_cityList.length != 0) {
                        selectOption(OptionType.city, context, _cityList);
                      }
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(nameCity.isEmpty ? "sehir  Seciniz" : nameCity,style: TextStyle(color: Colors.grey),),
                            Icon(Icons.keyboard_arrow_down,color: Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: InkWell(
                    onTap: () {
                      if (_districtList.length != 0) {
                        selectOption(OptionType.district, context, _districtList);
                      }
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                                nameDistrict.isEmpty ? "Ilce Seciniz" : nameDistrict,style: TextStyle(color: Colors.grey),),
                            Icon(Icons.keyboard_arrow_down,color:Colors.grey)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, top: 10),
            child: InkWell(
              onTap: (){
                _controllerProduct.keyString=key.obs;
                _controllerProduct.minPrice=min.obs;
                _controllerProduct.maxPrice=max.obs;
                _controllerProduct.cityID=cityID.obs;
                _controllerProduct.countryID=countryID.obs;
                _controllerProduct.districtID=districtID.obs;
                Navigator.pop(context,true);

             //   _controllerProduct.categoryID=ca;
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Get.theme.backgroundColor,
                  //  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Search Now",
                      style: TextStyle(color: Colors.white, fontSize: 22),
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

  Widget categoryItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: categoryColor[index],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Image.asset(
                  categoryUrl[index],
                  color: Colors.white,
                  width: 30,
                  height: 30,
                  //  fit: BoxFit.contain,
                )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category[index],
            )
          ],
        ),
      ),
    );
  }

  void selectOption(
      OptionType service, BuildContext context, List<CscData> data) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
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
                                _districtList = [];
                                cityID=data[index].id;
                                nameCity=data[index].name;

                              });
                              break;
                            case OptionType.district:
                              setState(() {
                                districtID=data[index].id;
                                nameDistrict=data[index].name;
                              });
                              break;

                            case OptionType.country:
                              setState(() {
                                _cityList = [];
                                countryID=data[index].id;
                                nameCountry=data[index].name;

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
                          } else if (service == OptionType.city) {
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
                        trailing: Icon(/*data[index].id == idFind(service, office)
                            ? Icons.radio_button_on
                            :*/ Icons.radio_button_off),
                      ),
                    );
                  }),
            );
          });
  }


  int idFind(OptionType type) {
    switch (type) {
      case OptionType.city:
        return cityID ;
        break;
      case OptionType.country:
        return countryID;
        break;
      case OptionType.district:
        return districtID;
        break;

    }
  }

}
