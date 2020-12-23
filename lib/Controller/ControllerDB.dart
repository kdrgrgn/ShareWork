
import 'dart:async';

import 'package:get/get.dart';
import 'package:mobi/Services/AuthService.dart';
import 'package:mobi/Services/DbServiceRead.dart';
import 'package:mobi/model/Department/Department.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/FamilyTasks.dart';
import 'package:mobi/model/Office/Office.dart';
import 'package:mobi/model/Personels/Personels.dart';
import 'package:mobi/model/Project/Project.dart';
import 'package:mobi/model/User/User.dart';

class ControllerDB extends GetxController {
  AuthService _authService = AuthService();
  DbServiceRead _dbService = DbServiceRead();

  Rx<User> user = null.obs;
  RxString token="".obs;
  RxBool isLoading = false.obs;



  Map<String,String> headers(){

      return <String,String>{
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer " + token.value
      };
    }


  signIn({String mail, String password}) async {
    try {
      isLoading = true.obs;
      update();
      user = await _authService.signIn(mail: mail, password: password);
      update();
      token=user.value.data.token.obs;
      update();
    } catch (e) {
      // print("sign in hata = "+ e.toString());
    } finally {
      isLoading = false.obs;
      update();
    }
  }

  FutureOr<Office> getOffice({Map headers}) async {
    try {

      return await _dbService.getOffice(headers: headers);
    } catch (e) {
       print("get office hata = "+ e.toString());
    }
  }

  Future<Department> getDepartmentList({Map headers}) async {
    try {

      return   await _dbService.getDepartmentList(headers:headers);

    } catch (e) {
       print("get office hata = "+ e.toString());
    }
  }

  Future<Personels> getPersonelList({Map headers}) async {

    try {
      return   await _dbService.getPersonelList(headers:headers);

    } catch (e) {
      print("get pesrsnel hata = "+ e.toString());
    }
  }

  Future<Project> getProjectList({Map<String, String> headers,int userID}) async {
    try {

      return   await _dbService.getProjectList(headers:headers,userID:userID);

    } catch (e) {
      print("get pesrsnel hata = "+ e.toString());
    }

  }




  Future<FamilyTasks> getAllFamilyTaskList({Map<String, String> headers}) async {
    try {
      return   await _dbService.getAllFamilyTaskList(headers:headers);

    } catch (e) {
      print("get pesrsnel hata = "+ e.toString());
    }
  }

  Future<Family> getFamily({Map<String, String> headers}) async {
    try {
      return   await _dbService.getFamily(headers:headers);

    } catch (e) {
      print("get pesrsnel hata = "+ e.toString());
    }
  }

  Future<FamilyPerson> getFamilyPersonWithId({Map<String, String> headers, int id,String date}) async {
    try {
      return   await _dbService.getFamilyPersonWithId(headers:headers,id:id,date: date);

    } catch (e) {
      print("get pesrsnel hata = "+ e.toString());
    }
  }
}
