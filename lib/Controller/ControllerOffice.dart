import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mobi/Services/Office/OfficeBase.dart';
import 'package:mobi/Services/Office/OfficeDB.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Office/Office.dart';

class ControllerOffice extends GetxController implements OfficeBase {
  OfficeDB _dbService = OfficeDB();
  RxInt initialPage=0.obs;
  RxString nameService="".obs;
  RxString nameCity="".obs;
  RxString nameCountry="".obs;
  RxString nameDistrict="".obs;
  RxString description="".obs;
  RxInt idService=0.obs;
  RxInt idCity=0.obs;
  RxInt idDistrict=0.obs;
  RxInt idCountry=0.obs;
  RxList<File> files;

  Future<Office> getOffice({Map headers}) async {
    return await _dbService.getOffice(headers: headers);
  }

  @override
  editOfficeService(Map<String, String> header,
      {int serviceId, int countryId, int cityId,String description,int disrtictId}) async {
    return await _dbService.editOfficeService(header,
        serviceId: serviceId, cityId: cityId, countryId: countryId,description:description,disrtictId: disrtictId);
  }

  @override
  Future<Csc> getOfficeServiceList(Map<String, String> header) async {
    return await _dbService.getOfficeServiceList(header);
  }

  @override
  Future insertOfficeImages(Map<String, String> header, {List<File> files}) async {
    return await _dbService.insertOfficeImages(header,files:files);

  }
}
