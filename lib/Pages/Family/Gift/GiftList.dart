import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Pages/Family/Gift/AddGiftPage.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Gift/Gift.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class GiftList extends StatefulWidget {
  @override
  _GiftListState createState() => _GiftListState();
}

class _GiftListState extends State<GiftList> {
  Family family;
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;

  bool isLoading = true;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  Gift _gift;

//  List<PersonList> _personList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controller.family.value;

      _gift = await _controller.getFamilyGiftList(
          headers: _controller.headers(), familyId: family.data.id);

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddGiftPage()).then((value) {
            _controller
                .getFamilyGiftList(
                    headers: _controller.headers(), familyId: family.data.id)
                .then((value) {
              setState(() {
                _gift = value;
              });
            });
          });
        },
        child: Tab(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
      body: isLoading
          ? MyCircular()
          : ListView.builder(
              itemCount: _gift.data.length,
              itemBuilder: (context, index) {
                String url = _controllerChange.urlGift +
                    _gift.data[index].picture;

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    padding:
                        EdgeInsets.only(bottom: 8, top: 8, right: 5, left: 5),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Image.network(
                          url,
                          width: 35,
                          height: 35,
                          //  fit: BoxFit.contain,
                        )),
                      ),
                      title: Text(_gift.data[index].title),
                      trailing: Text(_gift.data[index].point.toString()),
                    ),
                  ),
                );
              }),
    );
  }
}
