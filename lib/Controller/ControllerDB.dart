import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mobi/Pages/Login/rememberMeControl.dart';
import 'package:mobi/Services/AuthService.dart';
import 'package:mobi/Services/DbService.dart';
import 'package:mobi/model/Customers/Customers.dart';
import 'package:mobi/model/Department/Department.dart';
import 'package:mobi/model/Family/Budget/Budget.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/Gift/Gift.dart';
import 'package:mobi/model/Family/Shop/ShopItem.dart';
import 'package:mobi/model/Family/Shop/ShopOrder.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/RepeatTasks.dart';
import 'package:mobi/model/Family/Task/TaskMessage.dart';
import 'package:mobi/model/Office/Office.dart';
import 'package:mobi/model/Personels/Personels.dart';
import 'package:mobi/model/Project/Project.dart';
import 'package:mobi/model/User/Plugins.dart';
import 'package:mobi/model/User/User.dart';
import 'package:mobi/model/User/UserData.dart';

class ControllerDB extends GetxController {
  AuthService _authService = AuthService();
  DbService _dbService = DbService();

  Rx<User> user = null.obs;
  Rx<Family> family = null.obs;
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

  Future<Family> createFamily(
      {Map<String, String> headers, String title, File file}) async {
    Family result = await _dbService.createFamily(
        headers: headers, title: title, file: file);
    family = result.obs;
    update();
  }

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
      user = await _authService.signUp(
          mail: mail,
          password: password,
          firstName: firstName,
          lastName: lastName,
          regType: regType,
          title: title);
      update();
      if (user.value != null && rememberMe) {
        RememberMeControl.instance.setRemember("login", [mail, password]);
      }
      token = user.value.data.token.obs;
      update();
    } catch (e) {
      // print("sign in hata = "+ e.toString());
    } finally {
      isLoading = false.obs;
      update();
    }
  }

  signIn({String mail, String password, bool rememberMe}) async {
    try {
      isLoading = true.obs;
      update();
      user = await _authService.signIn(mail: mail, password: password);
      update();
      if (user.value != null && rememberMe) {
        RememberMeControl.instance.setRemember("login", [mail, password]);
      }
      token = user.value.data.token.obs;
      update();
    } catch (e) {
      // print("sign in hata = "+ e.toString());
    } finally {
      isLoading = false.obs;
      update();
    }
  }

  FutureOr<Office> getOffice({Map headers}) async {
    return await _dbService.getOffice(headers: headers);
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

  Future<FamilyTasks> getAllFamilyTaskList(
      {Map<String, String> headers}) async {
    return await _dbService.getAllFamilyTaskList(headers: headers);
  }

  Future<Family> getFamily({Map<String, String> headers, String date}) async {
    Family result = await _dbService.getFamily(headers: headers, date: date);
    family = result.obs;
    update();
    return family.value;
  }

  Future<FamilyPerson> getFamilyPersonWithId(
      {Map<String, String> headers, int id, String date}) async {
    return await _dbService.getFamilyPersonWithId(
        headers: headers, id: id, date: date);
  }

  Future<int> insertFamilyPersonTask({Map<String, String> headers,
    int personID,
    int familyID,
    int taskID,
    String date}) async {
    return await _dbService.insertFamilyPersonTask(
        headers: headers,
        personID: personID,
        familyID: familyID,
        taskID: taskID,
        date: date);
  }

  Future<int> multipleInsertFamilyPersonTask({Map<String, String> headers,
    int personID,
    int familyID,
    List<int> taskID,
    String date,
    int repeatType}) async {
    return await _dbService.multipleInsertFamilyPersonTask(
        headers: headers,
        personID: personID,
        familyID: familyID,
        repeatType: repeatType,
        taskID: taskID,
        date: date);
  }

  Future<Customers> getCustomerList(
      {Map<String, String> headers, int pluginID}) async {
    return await _dbService.getCustomerList(
        headers: headers, pluginID: pluginID);
  }

  Future<ShopItem> getFamilyShopItemList({Map<String, String> headers}) {
    return _dbService.getFamilyShopItemList(headers: headers);
  }

  Future<ShopOrder> getFamilyShopOrderList(
      {Map<String, String> headers, int familyId}) {
    return _dbService.getFamilyShopOrderList(
        headers: headers, familyId: familyId);
  }

  Future<ShopOrder> insertFamilyShopOrder(
      {Map<String, String> headers, int itemID, int familyID}) {
    return _dbService.insertFamilyShopOrder(
        headers: headers, itemID: itemID, familyID: familyID);
  }

  Future<ShopOrder> insertFamilyShopOrderMultiple({int familyID,
    int repeatType,
    String date,
    List<int> itemID,
    Map<String, String> headers}) async {
    return await _dbService.insertFamilyShopOrderMultiple(
        headers: headers,
        itemID: itemID,
        date: date,
        repeatType: repeatType,
        familyID: familyID);
  }

  Future<Budget> getFamilyBudgetItemList(
      {Map<String, String> headers, int familyId}) async {
    return await _dbService.getFamilyBudgetItemList(
        headers: headers, familyId: familyId);
  }

  void insertFamilyBudgetItem({Map<String, String> headers,
    int familyId,
    int payerPerson,
    String title,
    int amount,
    List<Map<String, int>> personList}) {
    _dbService.insertFamilyBudgetItem(
        headers: headers,
        familyId: familyId,
        payerPerson: payerPerson,
        title: title,
        amount: amount,
        personList: personList);
  }

  void editFamilyBudgetItem({Map<String, String> headers,
    int budgetItemId,
    int payerPerson,
    String title,
    int amount,
    List<Map<String, int>> personList}) {
    _dbService.editFamilyBudgetItem(
        headers: headers,
        budgetItemId: budgetItemId,
        payerPerson: payerPerson,
        title: title,
        amount: amount,
        personList: personList);
  }

  Future<Gift> getFamilyGiftList(
      {Map<String, String> headers, int familyId}) async {
    return await _dbService.getFamilyGiftList(
        headers: headers, familyId: familyId);
  }

  Future<List<Plugins>> getPluginList({Map<String, String> headers}) async {
    return await _dbService.getPluginList(headers: headers);
  }

  addPerson({Map<String, String> headers,
    int age,
    String email,
    String phone,
    String firstName,
    String lastName,
    int familyId}) async {
    Family result = await _dbService.addPerson(
        headers: headers,
        age: age,
        email: email,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        familyId: familyId);
    family = result.obs;
    update();
  }

  Future<TaskMessage> getFamilyPersonTaskMessageList(
      {int id, Map<String, String> headers}) async {
    return await _dbService.getFamilyPersonTaskMessageList(
        id: id, headers: headers);
  }

  insertFamilyPersonTaskMessage(
      {int id, String message, Map<String, String> headers}) async {
    await _dbService.insertFamilyPersonTaskMessage(
        id: id, headers: headers, message: message);
  }

  Future<RepeatTasks> getFamilyPersonTaskListRepeat(
      {Map<String, String> headers, int familyId}) async {
    return await _dbService.getFamilyPersonTaskListRepeat(
        headers: headers, familyId: familyId);
  }

  Future<int> editFamilyPersonTaskDetailsWithPersonId(
      {Map<String, String> headers,
        int personId,
        int familyPersonTaskId,
        int status,
        int points}) async {
    return await _dbService.editFamilyPersonTaskDetailsWithPersonId(
        headers: headers,
        personId: personId,
        status: status,
        points: points,
        familyPersonTaskId: familyPersonTaskId);
  }

  editFamilyShopOrder({
    int unit,
    int count,
    int id,
    Map<String, String> headers,
  }) {
    _dbService.editFamilyShopOrder(
        unit: unit, count: count, id: id, headers: headers);
  }

  deleteFamilyShopOrder({int id, Map<String, String> headers}) {
    _dbService.deleteFamilyShopOrder(id: id, headers: headers);
  }

  buyFamilyShopOrder({int familyId,
    Map<String, String> headers,
    List<int> fsoIds,
    int price}) {
    _dbService.buyFamilyShopOrder(
        familyId: familyId, headers: headers, fsoIds: fsoIds, price: price);
  }

  Future<int> editFamilyPersonTaskPersonId(
      {List<int> fptIds, int personId, Map<String, String> headers}) async {
    return await _dbService.editFamilyPersonTaskPersonId(
      fptIds: fptIds,
      personId: personId,
      headers: headers,
    );
  }

  insertFamilyGift({int familyId,
    Map<String, String> headers,
    String title,
    int point,
    File file}) async {
    await _dbService.insertFamilyGift(
        familyId: familyId,
        headers: headers,
        title: title,
        point: point,
        file: file);
  }

  insertFamilyPersonTaskLike(
      {Map<String, String> headers, int familyPersonTaskId}) async {
    await _dbService.insertFamilyPersonTaskLike(
        headers: headers, familyPersonTaskId: familyPersonTaskId);
  }

  getFamilyBudgetItem({Map<String, String> headers, int id}) async {
    return await _dbService.getFamilyBudgetItem(headers: headers, id: id);
  }

  logOut() {
    try {
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

  Future<List<UserData>> getUserListExceptCurrent({Map<String, String> header}) async {

return await _authService.getUserListExceptCurrent(header: header);
  }
}
