

import 'package:get/get.dart';


class ControllerChange extends GetxController {


  RxInt familyCount ;
  RxBool familyIsActive=false.obs;
  RxInt initialPage =0.obs;
  Rx<DateTime> selectedDay=DateTime.now().obs;
  RxList<int> tabIndex=[0].obs;
  RxList<int> familiyTabIndex=[0].obs;



  final  String _baseUrl = "https://share-work.com";
  String get baseUrl => _baseUrl;

  final String _urlUsers = "https://share-work.com" +
      "/media/users/";

  String get urlUsers => _urlUsers;


  final String _urlTask = "https://share-work.com" +
      "/media/familyTask/" ;

  String get urlTask => _urlTask;


  final String _urlGift = "https://share-work.com" +
      "/media/familyGift/" ;

  String get urlGift => _urlGift;



  final String _urlShop = "https://share-work.com" +
      "/media/familyShopping/" ;

  String get urlShop => _urlShop;








  void updateTabState(int state) {

if(tabIndex.contains(state)){
  tabIndex.remove(state);
}
tabIndex.add(state);
    update();
  }
  void updateFamilyTabState(int state) {

if(familiyTabIndex.contains(state)){
  familiyTabIndex.remove(state);
}
familiyTabIndex.add(state);
    update();
  }

  void updateFamily(int i) {

    familyCount=i.obs;
    update();
    familyIsActive=true.obs;
    update();

  }

  void updateSelectedDate(DateTime newDate) {

    selectedDay=newDate.obs;
    update();


  }
  void updateInitialPage(int i) {
    initialPage=i.obs;
    update();

  }

  void removeTab() {
    if(tabIndex.length!=1) {
      tabIndex.removeLast();
      update();
    }

  }
  void removeFamilyTab() {
    if(familiyTabIndex.length!=1) {
      familiyTabIndex.removeLast();
      update();
    }

  }





}
