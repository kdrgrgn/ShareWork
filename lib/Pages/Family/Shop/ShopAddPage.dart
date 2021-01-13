import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/Shop/ShopItem.dart';
import 'package:mobi/model/Family/Shop/ShopOrder.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';

class ShopAddPage extends StatefulWidget {
  @override
  _ShopAddPageState createState() => _ShopAddPageState();
}

class _ShopAddPageState extends State<ShopAddPage> {
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;
  List<ScrollController> _shopController = [
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];

  final _formkey = GlobalKey<FormState>();

  Family family;
  double containerW = 0;
  double containerH = 0;
  List<bool> listCatState = [false, false, false];

  List<bool> listTabState = [true, false, false];

  List<String> listCatWord = ["meyve", "sebze", "gida"];

  List<String> listSelectCatWord = [];

  ShopItem _shopItem;
  ShopOrder _shopOrder;
  List<ShopOrderData> _orderData = [];
  List<ShopItemData> itemData = [];

  List<bool> _selectedItemState;
  List<ShopItemData> _selectedItem = [];

  bool isLoading = true;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controller.family.value;

      _shopItem = await _controller.getFamilyShopItemList(
          headers: _controller.headers());
      _shopOrder = await _controller.getFamilyShopOrderList(
          headers: _controller.headers(), familyId: family.data.id);

      _selectedItemState = List(_shopItem.data.length);
      for (int i = 0; i < _selectedItemState.length; i++) {
        _selectedItemState[i] = false;
      }
      itemData = _shopItem.data;

      List<int> _repeatId = [];
      List<ShopOrderData> temp = [];

      for (ShopOrderData value in _shopOrder.data) {
        if (value.repeatType == 0) {
          temp.add(value);
          _repeatId.add(value.familyShopItem.id);
        }
      }

      _repeatId = _repeatId.toSet().toList();
      print("id pilot = " + _repeatId.toString());
      setState(() {
        for (ShopOrderData value in temp) {
          if (_repeatId.contains(value.familyShopItem.id) &&
              value.previousOrderId == 0) {
            _orderData.add(value);
            _repeatId.remove(value.familyShopItem.id);
          }
        }
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          bottomSheet();
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Tab(
                icon: Image.network(
                  "https://share-work.com/newsIcons/thumbnail_ikon_shopping.png",
                  width: 25,
                  height: 20,
                  //  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Get.theme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    _orderData.length.toString().toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BuildBottomNavigationBar(),
      body: isLoading
          ? MyCircular()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: filterButtons(),
                ),
                Expanded(child: body()),
              ],
            ),
    );
  }

  Widget body() {
    return isLoading
        ? MyCircular()
        : SingleChildScrollView(
            child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: buildSelectedShop()),
            filtCatRow(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                  height: 330, decoration: BoxDecoration(), child: buildShop()),
            ),
          ]));
  }

  Widget buildShop() {
    List<int> _orderIdList = [];

    for (ShopOrderData i in _orderData) {
      _orderIdList.add(i.familyShopItem.id);
    }

    return Stack(
      children: [
        GridView.builder(
          itemCount: itemData.length,
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: _shopController[listTabState.indexOf(true)],
          itemBuilder: (context, index) {
            String url = _controllerChange.urlShop + itemData[index].picture;

            return IgnorePointer(
              ignoring: _orderIdList.contains(itemData[index].id),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedItemState[index] = !_selectedItemState[index];
                    if (_selectedItemState[index]) {
                      _selectedItem.add(itemData[index]);
                    } else {
                      _selectedItem.remove(itemData[index]);
                    }
                  });
                },
                child: Stack(
                  children: [
                    Draggable(
                      data: itemData[index].id.toString(),
                      feedback: buildFeedback(_selectedItem, url),
                      child: Wrap(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: _selectedItemState[index]
                                      ? Colors.grey[300]
                                      : Colors.white,
                                  border:
                                      Border.all(color: themeColor, width: 0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.network(
                                url,
                                fit: BoxFit.contain,
                              )),
                          Text(
                            itemData[index].name,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    _orderIdList.contains(itemData[index].id)
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.4,
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: background.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        setState(() {
                          _shopController[listTabState.indexOf(true)].animateTo(
                              _shopController[listTabState.indexOf(true)]
                                      .offset -
                                  200,
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 500));
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: background.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                      onTap: () {
                        setState(() {
                          _shopController[listTabState.indexOf(true)].animateTo(
                              _shopController[listTabState.indexOf(true)]
                                      .offset +
                                  200,
                              curve: Curves.ease,
                              duration: Duration(milliseconds: 500));
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget buildSelectedShop() {
    return _orderData.length == 0
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: DragTarget(onAccept: (value) {
              if (_selectedItem.length == 0 &&
                  listTabState.indexOf(true) == 0) {
                insertFamilyShopOrder(value);
              } else {
                insertFamilyShopOrderMultiple(
                    familyID: family.data.id,
                    selectedItem: _selectedItem,
                    value: value);
              }
            }, builder: (context, List<String> candidateData, rejectedData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                decoration: BoxDecoration(
                    border: Border.all(color: themeColor, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: Opacity(
                  opacity: 0.5,
                  child: Image.network(
                    "https://share-work.com/newsIcons/thumbnail_ikon_shopping.png",
                    height: 150,

                    //  fit: BoxFit.contain,
                  ),
                ),
              );
            }),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: DragTarget(onAccept: (value) {
              if (_selectedItem.length == 0 &&
                  listTabState.indexOf(true) == 0) {
                insertFamilyShopOrder(value);
              } else {
                insertFamilyShopOrderMultiple(
                    familyID: family.data.id,
                    selectedItem: _selectedItem,
                    value: value);
              }
            }, builder: (context, List<String> candidateData, rejectedData) {
              return Container(
                width: double.infinity,
                height: 160,
                child: GridView.builder(
                  itemCount: _orderData.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String url = _controllerChange.urlShop +
                        _orderData[index].familyShopItem.picture;

                    return Wrap(
                      children: [
                        Container(
                            width: double.infinity,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: themeColor, width: 0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.contain,
                                  )),
                            )),
                        Center(
                          child: Text(
                            _orderData[index].familyShopItem.name,
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5),
                ),
              );
            }));
  }

  Future<void> insertFamilyShopOrder(value) async {
    ShopOrder result = await _controller.insertFamilyShopOrder(
        headers: _controller.headers(),
        itemID: int.parse(value),
        familyID: family.data.id);
    if (result.data.length != 0) {
      setState(() {
        _orderData.addAll(result.data);
      });
    }
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "." +
        date.month.toString() +
        "." +
        date.year.toString();
  }

  Widget buildFeedback(List<ShopItemData> multiItem, String urlItem) {
    return multiItem.length == 0
        ? Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: themeColor, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(
                  urlItem,
                  fit: BoxFit.contain,
                )),
          )
        : Column(
            children: multiItem.map((e) {
              String url = _controllerChange.urlShop + e.picture;

              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: themeColor, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                    )),
              );
            }).toList(),
          );
  }

  Future<void> insertFamilyShopOrderMultiple(
      {int familyID, List<ShopItemData> selectedItem, value}) async {
    List<int> _itemIdList = [];
    if (_selectedItem.length == 0) {
      _itemIdList.add(int.parse(value));
    } else {
      for (ShopItemData i in _selectedItem) {
        _itemIdList.add(i.id);
      }
    }
    DateTime today = DateTime.now();
    DateTime firstDay;
    if (listTabState.indexOf(true) == 0) {
      firstDay = today;
    } else if (listTabState.indexOf(true) == 1) {
      firstDay = today.subtract(new Duration(days: today.weekday - 1));
    } else {
      firstDay = DateTime(today.year, today.month, 1);
    }

    ShopOrder result = await _controller.insertFamilyShopOrderMultiple(
        familyID: family.data.id,
        itemID: _itemIdList,
        date: buildStringDate(firstDay),
        repeatType: listTabState.indexOf(true),
        headers: _controller.headers());

    if (result.data.length != 0) {
      setState(() async {
        _shopOrder = await _controller.getFamilyShopOrderList(
            headers: _controller.headers(), familyId: family.data.id);
        updateOrder(type: listTabState.indexOf(true));
      });
    }
/*    if (result.data.length != 0) {
      setState(() {
        _orderData.addAll(result.data);
      });
    }*/
    setState(() {
      _selectedItem = [];
      for (int i = 0; i < _selectedItemState.length; i++) {
        _selectedItemState[i] = false;
      }
    });
  }

  Widget filterButtons() {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              elevation: 3,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    updateOrder(type: 0);

                    listTabState = [true, false, false];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Daily"),
                    listTabState[0] == true
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              elevation: 3,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    updateOrder(type: 1);

                    listTabState = [false, true, false];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Weekly"),
                    listTabState[1] == true
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(30.0),
              elevation: 3,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    updateOrder(type: 2);

                    listTabState = [false, false, true];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Monthly"),
                    listTabState[2] == true
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filtCatRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        containerH == 0
            ? Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        containerW = Get.width - 40;
                        containerH = 40;
                      });
                    },
                    child: Container(
                        width: 30,
                        height: 30,
                        child: Image.network(
                          "https://share-work.com/newsIcons/thumbnail_ikonlar_ek_1.png",
                          fit: BoxFit.contain,
                        ))),
              )
            : Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        containerW = 0;
                        containerH = 0;
                      });
                    },
                    child: Icon(Icons.close)),
              ),
        containerH != 0
            ? Container()
            : Expanded(
                flex: 7,
                child: Container(
                  height: 45,
                  width: Get.width - 50,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    controller: ScrollController(keepScrollOffset: true),
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[0] = !listCatState[0];
                              if (listCatState[0]) {
                                listSelectCatWord.add(listCatWord[0]);
                              } else {
                                listSelectCatWord.remove(listCatWord[0]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Meyve"),
                              listCatState[0] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[1] = !listCatState[1];
                              if (listCatState[1]) {
                                listSelectCatWord.add(listCatWord[1]);
                              } else {
                                listSelectCatWord.remove(listCatWord[1]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Sebze"),
                              listCatState[1] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 3,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              listCatState[2] = !listCatState[2];
                              if (listCatState[2]) {
                                listSelectCatWord.add(listCatWord[2]);
                              } else {
                                listSelectCatWord.remove(listCatWord[2]);
                              }
                              updateItem();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Gida"),
                              listCatState[2] == true
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        AnimatedContainer(
          width: containerW,
          height: containerH,
          duration: Duration(milliseconds: 500),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: TextFormField(
                onChanged: (value) {
                  if (value.length == 0) {
                    setState(() {
                      itemData = _shopItem.data;
                    });
                  } else {
                    setState(() {
                      itemData = [];

                      for (int i = 0; i < _shopItem.data.length; i++) {
                        if (_shopItem.data[i].name
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          itemData.add(_shopItem.data[i]);
                        }
                      }
                    });
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),

                    suffixIcon: Icon(Icons.filter_list_outlined),
                    labelText: "Search Shop"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  updateItem() {
    itemData = [];
    if (listSelectCatWord.length == 0) {
      setState(() {
        itemData = _shopItem.data;
      });
    } else {
      for (ShopItemData value in _shopItem.data) {
        if (listSelectCatWord.contains(value.category)) {
          setState(() {
            itemData.add(value);
          });
        }
      }
    }
  }

  updateOrder({int type}) async {
    DateTime today = DateTime.now();

    setState(() {
      for (int i = 0; i < _selectedItemState.length; i++) {
        _selectedItemState[i] = false;
      }
      _selectedItem = [];
    });

    _orderData = [];

    if (type == 0) {
      for (ShopOrderData value in _shopOrder.data) {
        if (value.repeatType == 0) {
          setState(() {
            _orderData.add(value);
          });
        }
      }
    } else {
      DateTime firstDay;
      if (type == 1) {
        firstDay = today.subtract(new Duration(days: today.weekday - 1));
        print("firsttt= " + buildStringDate(firstDay));
      } else {
        firstDay = DateTime(today.year, today.month, 1);
      }

      for (ShopOrderData value in _shopOrder.data) {
        if (value.repeatType == type) {
          DateTime dateString =
              DateTime.parse(value.dateString.split('.').reversed.join());

          if (firstDay.year == dateString.year &&
              firstDay.month == dateString.month &&
              firstDay.day == dateString.day) {
            print("buraya girdii value = " +
                value.dateString +
                " + " +
                value.familyShopItem.name);
            setState(() {
              _orderData.add(value);
            });
          }

          //   temp.add(value);
          //   _repeatId.add(value.familyShopItem.id);
        }
      }
    }
  }

  bottomSheet() {
    final _formSheet = GlobalKey<FormState>();

    int payment;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 10,left: 10),
              child: Wrap(children: [
                Container(
                  height: 500,
                  padding: MediaQuery.of(context).viewInsets,
                  child: ListView.builder(
                    itemCount: _orderData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String url = _controllerChange.urlShop +
                          _orderData[index].familyShopItem.picture;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          width: Get.width-20,

                          child: SwipeActionCell(
                            key: ValueKey(_orderData[index]),
                            leadingActions: [
                              SwipeAction(
                                onTap: (a) async {
                                  setState(() {
                                    deleteFamilyShopOrder(
                                        id: _orderData[index].id,
                                        data: _orderData[index]);
                                    //  _orderData.remove(_orderData[index]);
                                  });
                                },
                                nestedAction: SwipeNestedAction(
                                  ///customize your nested action content

                                  content: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30),
                                      color: Colors.red,
                                    ),
                                    width: 130,
                                    height: 60,
                                    child: OverflowBox(
                                      maxWidth: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text('Sil',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                ///you should set the default  bg color to transparent
                                color: Colors.transparent,

                                ///set content instead of title of icon
                                content: _getIconButton(
                                    Colors.red, Icons.delete),
                              ),
                              SwipeAction(
                                  content: _getIconButton(
                                      Colors.grey, Icons.note_add_sharp),
                                  color: Colors.transparent,
                                  onTap: (handler) {}),
                            ],
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.only(
                                  bottom: 5, top: 5, right: 5, left: 5),

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeColor,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Colors.transparent,
                                          backgroundImage:
                                              Image.network(url).image,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            _orderData[index]
                                                .familyShopItem
                                                .name,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            _orderData[index].unit == 1
                                                ? "Adet"
                                                : "Kilogram",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                editFamilyShopOrder(
                                                    id: _orderData[index]
                                                        .id,
                                                    count: _orderData[index]
                                                            .count +
                                                        1,
                                                    unit: _orderData[index]
                                                        .unit);
                                                setState(() {
                                                  _orderData[index].count++;
                                                });
                                              },
                                              child: Icon(Icons.add)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            decoration: BoxDecoration(
                                                color: background,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5)),
                                            child: Text(
                                              _orderData[index]
                                                  .count
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                editFamilyShopOrder(
                                                    id: _orderData[index]
                                                        .id,
                                                    count: _orderData[index]
                                                            .count -
                                                        1,
                                                    unit: _orderData[index]
                                                        .unit);
                                                setState(() {
                                                  _orderData[index].count--;
                                                });
                                              },
                                              child: Icon(Icons.remove)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Total"),
                      Container(
                        width: MediaQuery.of(context).size.width - 300,
                        child: Form(
                          key: _formSheet,
                          child: Container(
                            height: 40,
                            child: TextFormField(
                              onSaved: (value) {
                                payment = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value.isEmpty ? "Bos olamaz" : null,
                              maxLines: 1,
                              decoration: InputDecoration(
                                suffix: Text("€"),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _formSheet.currentState.save();
                          buyFamilyShopOrder(price: payment);
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Chek Out",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
            );
          });
        });
  }

  Widget _getIconButton(color, icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        ///set you real bg color in your content
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  editFamilyShopOrder({int unit, int count, int id}) async {
    await _controller.editFamilyShopOrder(
        unit: unit, count: count, id: id, headers: _controller.headers());
  }

  deleteFamilyShopOrder({int id, ShopOrderData data}) async {
    await _controller.deleteFamilyShopOrder(
        id: id, headers: _controller.headers());
    setState(() {
      _orderData.remove(data);
    });
  }

  buyFamilyShopOrder({int price}) async {
    List<int> ids = [];
    for (ShopOrderData i in _orderData) {
      ids.add(i.id);
    }

    await _controller.buyFamilyShopOrder(
        familyId: family.data.id,
        headers: _controller.headers(),
        fsoIds: ids,
        price: price);

    setState(() {
      _orderData = [];
    });
  }
}
