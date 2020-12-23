

import 'package:get/get.dart';


class ControllerChange extends GetxController {


  RxInt familyCount ;
  RxBool familyIsActive=false.obs;
  RxInt initialPage =0.obs;
  Rx<DateTime> selectedDay=DateTime.now().obs;

  final String _baseUrl = "https://share-work.com";
  String get baseUrl => _baseUrl;








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





}
