import 'dart:async';

import 'package:get/get.dart';
import 'package:mobi/Services/Office/OfficeBase.dart';
import 'package:mobi/Services/Office/OfficeDB.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Office/Office.dart';

class ControllerOffice extends GetxController implements OfficeBase {
  OfficeDB _dbService = OfficeDB();

  Future<Office> getOffice({Map headers}) async {
    return await _dbService.getOffice(headers: headers);
  }

  @override
  editOfficeService(Map<String, String> header,
      {int serviceId, int countryId, int cityId}) async {
    return await _dbService.editOfficeService(header,
        serviceId: serviceId, cityId: cityId, countryId: countryId);
  }

  @override
  Future<Csc> getOfficeServiceList(Map<String, String> header) async {
    return await _dbService.getOfficeServiceList(header);
  }
}
