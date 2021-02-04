

import 'package:get/get.dart';


class ControllerChange extends GetxController {


  RxInt familyCount ;
  RxBool familyIsActive=false.obs;
  RxInt initialPage =0.obs;
  Rx<DateTime> selectedDay=DateTime.now().obs;
  RxList<int> tabIndexList=[0].obs;
  RxInt tabIndex=0.obs;
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



  final String _urlFamilyPicture = "https://share-work.com" +
      "/media/familyPicture/" ;

  String get urlFamilyPicture => _urlFamilyPicture;








  void updateTabState(int state) {

/*if(tabIndexList.contains(state)){
  tabIndexList.remove(state);
}*/
tabIndexList.add(state);
    update();
    tabIndex=state.obs;
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
    if(tabIndexList.length!=1) {
      tabIndexList.removeLast();
      update();
      tabIndex=tabIndexList.last.obs;
      update();
    }

  }






}
