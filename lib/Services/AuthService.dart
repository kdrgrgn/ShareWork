import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:mobi/Services/ServiceUrl.dart';
import 'package:mobi/model/CityServiceCountry/CityServiceCountry.dart';
import 'package:mobi/model/User/User.dart';
import 'package:mobi/model/User/UserData.dart';
import 'package:path/path.dart';

class AuthService {
  final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final ServiceUrl _serviceUrl = ServiceUrl();

  Future<Rx<User>> signIn({String mail, String password}) async {
    try {
      var postValue = {"email": mail, "password": password};

      var response = await http.post(_serviceUrl.login,
          headers: headers, body: jsonEncode(postValue));

      log("Usseerrr= "+response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      User user = User.fromJson(responseData);
      String _token = await _firebaseMessaging.getToken();
      await http.get(_serviceUrl.setUserToken + "?Token=$_token", headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer " + user.data.token
      });

      return user.obs;
    } catch (e) {
      print("sign in hata = " + e.toString());
      return null.obs;
    }
  }

  Future<bool> signUp (
      {String mail,
      String password,
      String firstName,
      String lastName,
      int regType,
      String title}) async {
    try {
      var postValue;
      if (regType == 0) {
        postValue = {
          "email": mail,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "registrationType": regType
        };
      } else {
        postValue = {
          "email": mail,
          "password": password,
          "title": title,
          "firstName": firstName,
          "lastName": lastName,
          "registrationType": regType
        };
      }

      log("reqq signop = " +postValue.toString());

      var response = await http.post(_serviceUrl.register,
          headers: headers, body: jsonEncode(postValue));
log("resp signop = " +response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (responseData['data'] == true) {
        return true;
      }else{
        return false;
      }

    } catch (e) {
      print("sign up hata = " + e.toString());
      return false;
    }
  }

  updateUserInfo(
      {String firstName,
      String lastName,
      String pass,
      String email,
      Map<String, String> header}) async {
    var response = await http.post(_serviceUrl.updateUserInfo,
        headers: header,
        body: jsonEncode({
          "FirstName": firstName,
          "LastName": lastName,
          "PassWord": pass,
          "Email": email,
        }));
  }

  changeProfilePhoto({File file, Map<String, String> header}) async {
    List<int> imageBytes = file.readAsBytesSync();
    String fileName = basename(file.path).toString();
    String content = base64Encode(imageBytes);

    var response = await http.post(_serviceUrl.changeProfilePhoto,
        headers: header,
        body: jsonEncode(
            {"Directory": "", "FileContent": content, "FileName": fileName}));
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;


    return responseData['data']['fileName'];
  }

  Future<List<UserData>> getUserListExceptCurrent(
      {Map<String, String> header}) async {
    var response = await http.get(
      _serviceUrl.getUserListExceptCurrent,
      headers: header,
    );
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    List<UserData> userList = [];

    log("UserListExceptCurrent = " + response.body);

    if (responseData['data'] != null) {
      responseData['data'].forEach((v) {
        userList.add(new UserData.fromJson(v));
      });
    }
    return userList;
  }

  Future<void> logOut(String userToken) async {
    String _token = await _firebaseMessaging.getToken();

    await http.get(_serviceUrl.deleteUserToken + "?Token=$_token", headers: {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer " + userToken
    });
  }

  Future<Csc> getCountryList(Map<String,String> header) async {

   var response=  await http.get(_serviceUrl.getCountryList , headers: header);
   final responseData = jsonDecode(response.body) as Map<String, dynamic>;

   return Csc.fromJson(responseData);
 }

  Future<Csc> getCityList(Map<String,String> header ,int countryID) async {

   var response=  await http.get(_serviceUrl.getCityList + "?CountryId=$countryID", headers: header);
   final responseData = jsonDecode(response.body) as Map<String, dynamic>;

   return Csc.fromJson(responseData);
 }



}
