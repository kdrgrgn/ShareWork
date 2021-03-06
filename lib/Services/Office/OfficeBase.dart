
import 'dart:io';

import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Office/Office.dart';

abstract class OfficeBase {
  Future<Csc> getOfficeServiceList(Map<String, String> header);

  editOfficeService(Map<String, String> header,
      {
        int serviceId,
        int countryId,
        int cityId,
        String description,
        int disrtictId
        });

  Future<Office> getOffice({Map headers});

  Future insertOfficeImages(Map<String, String> header ,{List<File> files});



}