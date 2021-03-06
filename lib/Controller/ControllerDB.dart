import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mobi/Pages/Login/rememberMeControl.dart';
import 'package:mobi/Services/AuthService.dart';
import 'package:mobi/Services/DbService.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/Customers/Customers.dart';
import 'package:mobi/model/Department/Department.dart';
import 'package:mobi/model/Personels/Personels.dart';
import 'package:mobi/model/Project/Project.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/model/User/User.dart';
import 'package:mobi/model/User/UserData.dart';

class ControllerDB extends GetxController {
  AuthService _authService = AuthService();
  DbService _dbService = DbService();

  Rx<User> user = null.obs;
  RxString token = "".obs;
  RxBool isLoading = false.obs;
  RxBool isSignIn = true.obs;

  updateLoginState(bool state) {
    isSignIn = state.obs;
    update();
  }

  Map<String, String> headers() {
    return <String, String>{
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer " + token.value
    };
  }

  final String _urlUsers = "https://share-work.com" +
      "/media/users/";



  signUp({String mail,
    String password,
    String firstName,
    String lastName,
    int regType,
    bool rememberMe,
    String title}) async {
    try {
      isLoading = true.obs;
      update();
   bool result= await _authService.signUp(
          mail: mail,
          password: password,
          firstName: firstName,
          lastName: lastName,
          regType: regType,
          title: title);
   print("result = $result");
if(result){
  print("result true donmus");
 await signIn(mail: mail,password: password,rememberMe: rememberMe);
}



    } catch (e) {
      // print("sign in hata = "+ e.toString());
    } finally {
      isLoading = false.obs;
      update();
    }
  }

  signIn({String mail, String password, bool rememberMe}) async {
    try {
      print("mail $mail , password $password , rememberME $rememberMe");

      isLoading = true.obs;
      update();

      user = await _authService.signIn(mail: mail, password: password);
      update();
      print("usserrim = " + user.value.toString());
      if(user.value!=null) {
        token = user.value.data.token.obs;
        update();

        if (rememberMe) {
          RememberMeControl.instance.setRemember("login", [mail, password]);
        }
      }
    } catch (e) {
      // print("sign in hata = "+ e.toString());
    } finally {
      isLoading = false.obs;
      update();
    }
  }


  Future<Department> getDepartmentList({Map headers}) async {
    return await _dbService.getDepartmentList(headers: headers);
  }

  Future<Personels> getPersonelList({Map headers}) async {
    return await _dbService.getPersonelList(headers: headers);
  }

  Future<Project> getProjectList(
      {Map<String, String> headers, int userID}) async {
    return await _dbService.getProjectList(headers: headers, userID: userID);
  }

  Future<Customers> getCustomerList(
      {Map<String, String> headers, int pluginID}) async {
    return await _dbService.getCustomerList(
        headers: headers, pluginID: pluginID);
  }

  Future<List<Plugins>> getPluginList({Map<String, String> headers}) async {
    return await _dbService.getPluginList(headers: headers);
  }

  logOut() {
    try {

      _authService.logOut(token.value);
      isLoading = true.obs;
      update();
      RememberMeControl.instance.setRemember("login", null);
      token = "".obs;
      user = null.obs;
      update();
    } catch (e) {} finally {
      isLoading = false.obs;
      update();
    }
  }

  Future<void> updateUserInfo(
      {String firstName, String lastName, String pass, String email, Map<
          String,
          String> headers,}) async {
    RememberMeControl.instance.setRemember("login", null);
    await _authService.updateUserInfo(
        firstName: firstName,
        lastName: lastName,
        pass: pass,
        email: email,
        header: headers);
    user.value.data.firstName = firstName;
    update();
    user.value.data.lastName = lastName;
    update();

    user.value.data.email = email;
    update();
  }

  changeProfilePhoto({File file, Map<String, String> header}) async {
    String url = await _authService.changeProfilePhoto(
        file: file, header: header);
    user.value.data.profilePhoto = _urlUsers + url;
    update();
    return url;
  }

  Future<List<UserData>> getUsersWithFCMTokens({List<int> ids, Map<String, String> header}) async {

    return await _authService.getUsersWithFCMTokens(
        ids: ids, header: header);
  }

  Future<List<UserData>> getUserListExceptCurrent({Map<String, String> header}) async {

return await _authService.getUserListExceptCurrent(header: header);
  }

  Future<Csc> getCountryList(Map<String,String> header) async {

  return  await _authService.getCountryList(header);
  }

  Future<Csc> getCityList(Map<String,String> header ,int countryID) async {

  return   await _authService.getCityList(header, countryID);
  }

  void updateUser() {
    user.value.data.officeServiceId=1;
    update();
  }

  Future<Csc> getDistrictList(Map<String, String> header, int id) async {
    return   await _authService.getDistrictList(header, id);
  }

}
