
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Office/Office.dart';

abstract class OfficeBase {
  Future<Csc> getOfficeServiceList(Map<String, String> header);

  editOfficeService(Map<String, String> header,
      {
        int serviceId,
        int countryId,
        int cityId,
        });

  Future<Office> getOffice({Map headers});

}