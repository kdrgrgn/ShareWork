import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mobi/model/Department/Department.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/FamilyTasks.dart';
import 'package:mobi/model/Office/Office.dart';
import 'package:mobi/model/Personels/Personels.dart';
import 'package:mobi/model/Project/Project.dart';

import 'ServiceUrl.dart';

class DbServiceRead {
  final ServiceUrl _serviceUrl = ServiceUrl();

  Future<Office> getOffice({Map headers}) async {
    try {
      var response = await http.get(_serviceUrl.GET_BURO, headers: headers);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Office.fromJson(responseData);
    } catch (e) {
      print("office hata  service= " + e.toString());
    }
  }

  Future<Department> getDepartmentList({Map headers}) async {
    try {
      var response = await http.post(_serviceUrl.GET_DEPARTMENT_SCAN,
          headers: headers, body: jsonEncode({}));
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Department.fromJson(responseData);
    } catch (e) {
      print("office hata  service= " + e.toString());
    }
  }

  Future<Personels> getPersonelList({Map headers}) async {
    try {
      var response = await http.post(_serviceUrl.GET_PERSONAL_SCAN,
          headers: headers, body: jsonEncode({}));
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Personels.fromJson(responseData);
    } catch (e) {
      print("personel hata  service= " + e.toString());
    }
  }

  Future<Project> getProjectList(
      {Map<String, String> headers, int userID}) async {
    try {
      var response = await http.post(_serviceUrl.GET_PROJECT_LIST,
          headers: headers,
          body: jsonEncode({
            "userId": userID,
            "page": 0,
            "take": 100,
            "projectTypeName": "",
            "search": "",
            "groupId": 0,
            "ownerId": 0
          }));

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Project.fromJson(responseData);
    } catch (e) {
      print("projecttt hata  service= " + e.toString());
    }
  }

  Future<FamilyTasks> getAllFamilyTaskList(
      {Map<String, String> headers}) async {
    try {
      var response = await http.get(
        _serviceUrl.GET_All_FAMILY_TASK_LIST,
        headers: headers,
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return FamilyTasks.fromJson(responseData);
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }

  Future<Family> getFamily({Map<String, String> headers}) async {
    try {
      var response = await http.get(
        _serviceUrl.GET_FAMILY,
        headers: headers,
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Family.fromJson(responseData);
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }

 Future<FamilyPerson> getFamilyPersonWithId({Map<String, String> headers, int id,String date}) async {
    try {
      var response = await http.post(_serviceUrl.GET_FAMILY_PERSON_WITH_ID,
          headers: headers,
          body: jsonEncode({"personId": id, "date": date}));


      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        return FamilyPerson.fromJson(responseData);
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }
}
