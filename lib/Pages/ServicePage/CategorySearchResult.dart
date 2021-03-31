import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/Pages/ServicePage/OfficeDetailsPage.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Services/Services.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';

class CategorySearchResult extends StatefulWidget {
  CscData catTitle;

  CategorySearchResult(this.catTitle);

  @override
  _CategorySearchResultState createState() => _CategorySearchResultState();
}

class _CategorySearchResultState extends State<CategorySearchResult> {
  List<String> productUrl = [
    "https://i.pinimg.com/564x/33/b8/69/33b869f90619e81763dbf1fccc896d8d.jpg",
    "https://i.pinimg.com/236x/27/cc/9e/27cc9ef32bbbac16bb915777d2d1fdbf.jpg",
    "https://i.pinimg.com/236x/75/5e/f5/755ef56def45ebe781fae19144d68238.jpg",
    "https://i.pinimg.com/236x/df/52/e9/df52e98f17053c9363233a59fde74da8.jpg",
    "https://i.pinimg.com/236x/c2/65/a0/c265a01c25dc01cc3a8cc27279163e6a.jpg",
    "https://i.pinimg.com/236x/1f/78/05/1f7805edaac9c536ada9f6747ca26043.jpg",
    "https://i.pinimg.com/236x/7c/1a/99/7c1a99d4bb812008e8a05e4f10c93728.jpg",
    "https://i.pinimg.com/236x/9c/97/bb/9c97bbe1b2b84d5c1c57966c4a3bd159.jpg",
    "https://i.pinimg.com/236x/c0/ea/11/c0ea11e64aa0c6a230e64ddb9d2fbe92.jpg",
  ];

  bool isLoading = true;
  ControllerDB _controllerDB = Get.put(ControllerDB());
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());
  Services service;
  List<ServiceData> data=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      service = await _controllerOffice.getOfficeListWithService(
          _controllerDB.headers(),
          serviceId: widget.catTitle.id);
      data = service.data;

      setState(() {
        isLoading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catTitle.name),
      ),
      body: isLoading?MyCircular():ListView.builder(
          controller: ScrollController(),
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return itemSearch(index);
          }),
    );
  }

  Widget itemSearch(int index) {
    return Card(
      child: ListTile(
        leading: Image.network(
          productUrl[index],
          height: 40,
        ),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OfficeDetailsPage(data[index])));
        },
        title: Text(data[index].title),
        subtitle: Text(data[index].service.name),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
