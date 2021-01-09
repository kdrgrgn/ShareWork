import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:mobi/Services/ServiceUrl.dart';
import 'package:mobi/model/User/User.dart';

class AuthService {
  final Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  final ServiceUrl _serviceUrl = ServiceUrl();

  Future<Rx<User>> signIn({String mail, String password}) async {
    try {
      var postValue = {"email": mail, "password": password};

      var response = await http.post(_serviceUrl.login,
          headers: headers, body: jsonEncode(postValue));

        log("Usseerrr= "+response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      User user = User.fromJson(responseData);

      return user.obs;
    } catch (e) {
      print("sign in hata = " + e.toString());
    }
  }

  signUp(
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


      var response = await http.post(_serviceUrl.register,
          headers: headers, body: jsonEncode(postValue));

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      Rx<User> user;
if(responseData['data']==true) {
 user  = await signIn(mail: mail, password: password);

}

      return user;
    } catch (e) {
      print("sign up hata = " + e.toString());
    }
  }
}
