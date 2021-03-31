
import 'dart:io';

import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Office/Office.dart';
import 'package:mobi/model/Services/Services.dart';

abstract class OfficeBase {
  Future<Csc> getOfficeServiceList(Map<String, String> header);

  Future<Services> getOfficeListWithService(Map<String, String> header,{int serviceId});

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