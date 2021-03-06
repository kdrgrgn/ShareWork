
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Office/Office.dart';
import 'package:path/path.dart';
import '../ServiceUrl.dart';

import 'OfficeBase.dart';

class OfficeDB implements OfficeBase{
  final ServiceUrl _serviceUrl = ServiceUrl();

  @override
  editOfficeService(Map<String, String> header, {int serviceId, int countryId, int cityId, String description,int disrtictId}) async {

   log("req = edit ofice "+ jsonEncode(
       {
         "serviceId": serviceId,
         "countryId": countryId,
         "cityId": cityId,
         "districtId":disrtictId,
         "description" : description
       }
   ));
    var response =
        await http.post(_serviceUrl.editOfficeService, headers: header,
        body: jsonEncode(
            {
              "serviceId": serviceId,
              "countryId": countryId,
              "cityId": cityId,
              "districtId":disrtictId,
              "description" : description
            }
        ));
    log("editOfficeService = " + response.body);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
return responseData['data'];
  }

  @override
  Future<Csc>  getOfficeServiceList(Map<String, String> header) async {
    log("headerss= " +header.toString());
    var response = await http.get(_serviceUrl.getOfficeServiceList, headers: header);
    log("getOfficeServiceList = " + response.body);
if(response.body.isEmpty){
  return null;
}else {
  final responseData = jsonDecode(response.body) as Map<String, dynamic>;

  return Csc.fromJson(responseData);
}
  }

  Future<Office> getOffice({Map headers}) async {
    try {
      var response = await http.get(_serviceUrl.getOffice, headers: headers);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Office.fromJson(responseData);
    } catch (e) {
      print("office hata  service= " + e.toString());
    }
  }

  @override
  Future insertOfficeImages(Map<String, String> header, {List<File> files}) async {


    List<Map<String,dynamic>> reqFile=[];

    files.forEach((file) {
      List<int> imageBytes = file.readAsBytesSync();
      String fileName = basename(file.path).toString();
      String content = base64Encode(imageBytes);

      reqFile.add(  {
        "fileName": fileName,
        "directory": "",
        "fileContent": content,

      });

    });

log("reqFile = " + jsonEncode(
    {
      "files": reqFile,

    }
));

    var response =
        await http.post(_serviceUrl.insertOfficeImages, headers: header,
        body: jsonEncode(
            {
              "files": reqFile,

            }
        ));

    log("responsee insertOfficeImages = " + response.body);

  }


}