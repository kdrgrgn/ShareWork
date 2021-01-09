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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorPush();
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
              itemCount: _budget.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.only(
                        bottom: 5, top: 5, right: 5, left: 5),

                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                                await navigatorPush(index:index);


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
                          trailing: Text(_budget.data[index].amount.toString()+" €"),
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

    if(index==null){
int id;

for(PersonList element in family.data.personList){


  if(element.user.id ==_controller.user.value.data.id){
    id=element.id;
  }

}


      Get.to(BudgetPage(id)).then((value) async {
        await buildPage();
      });
    }else{
      Get.to(BudgetPage(_budget.data[index].payerPerson.id)).then((value) async {
        await buildPage();
      });
    }

  }

  Future buildPage() async {
       setState(() {
      isLoading = true;
    });



    Budget result = await _controller.getFamilyBudgetItemList(
        headers: _controller.headers(), familyId: family.data.id);

    setState(() {
      _budget=result;
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
