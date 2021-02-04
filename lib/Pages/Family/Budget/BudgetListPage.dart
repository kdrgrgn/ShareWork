import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerChange.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/model/Family/Budget/Budget.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:mobi/widgets/buildBottomNavigationBar.dart';
import 'package:mobi/widgets/buildFamilyBottomNavigationBar.dart';

import 'BudgetPage.dart';

class BudgetList extends StatefulWidget {
  @override
  _BudgetListState createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  Family family;
  Color themeColor = Get.theme.accentColor;
  Color background = Get.theme.backgroundColor;

  bool isLoading = true;
  final ControllerDB _controller = Get.put(ControllerDB());
  ControllerChange _controllerChange = Get.put(ControllerChange());
  Budget _budget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      family = _controller.family.value;

      _budget = await _controller.getFamilyBudgetItemList(
          headers: _controller.headers(), familyId: family.data.id);

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  //    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int id;
          for (PersonList element in family.data.personList) {
            if (element.user.id == _controller.user.value.data.id) {
              id = element.id;
            }
          }
          //  Get.to(BudgetPage(id));
          navigatorPush();
          //navigatorPush();
        },
        backgroundColor: Colors.white,
        child: Tab(
          icon: Container(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset(
                "assets/newsIcons/thumbnail_thumbnail_ikon_4_15_1.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    //  bottomNavigationBar: BuildBottomNavigationBar(),
      body: isLoading
          ? MyCircular()
          : ListView.builder(
              itemCount: _budget.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    padding:
                        EdgeInsets.only(bottom: 5, top: 5, right: 5, left: 5),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            await navigatorPush(index: index);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: Image.network(
                                    _controllerChange.urlUsers +
                                        _budget.data[index].payerPerson.user
                                            .profilePhoto)
                                .image,
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(_budget.data[index].title),
                          subtitle: Text(
                            _budget.data[index].payerPerson.user.firstName +
                                " " +
                                _budget.data[index].payerPerson.user.lastName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            _budget.data[index].amount.toString() + " €",
                            style: TextStyle(
                                color: _budget.data[index].payerPerson.debt >= 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future navigatorPush({int index}) async {
    BudgetData data;
    ;

    if (index == null) {
/*
      for (PersonList element in family.data.personList) {
        if (element.user.id == _controller.user.value.data.id) {
          id = element.id;
        }
      }
*/
      data = null;
    } else {
      data = _budget.data[index];
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            BudgetPage(
              budgetData: data,
            ))).then((value) async {
      await buildPage();
    });
  }

  Future buildPage() async {
    setState(() {
      isLoading = true;
    });

    _controller
        .getFamilyBudgetItemList(
            headers: _controller.headers(), familyId: family.data.id)
        .then((value) {
      setState(() {
        _budget = value;
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  String buildStringDate(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }
}
