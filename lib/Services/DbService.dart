import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
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
import 'package:path/path.dart';

import 'ServiceUrl.dart';

class DbService {
  final ServiceUrl _serviceUrl = ServiceUrl();

  Future<Office> getOffice({Map headers}) async {
    try {
      var response = await http.get(_serviceUrl.getBuro, headers: headers);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Office.fromJson(responseData);
    } catch (e) {
      print("office hata  service= " + e.toString());
    }
  }

  Future<Department> getDepartmentList({Map headers}) async {
    try {
      var response = await http.post(_serviceUrl.getDepartment,
          headers: headers, body: jsonEncode({}));
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Department.fromJson(responseData);
    } catch (e) {
      print("office hata  service= " + e.toString());
    }
  }

  Future<Personels> getPersonelList({Map headers}) async {
    try {
      var response = await http.post(_serviceUrl.getPersonal,
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
      var response = await http.post(_serviceUrl.getProjectList,
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
        _serviceUrl.getAllFamilyTaskList,
        headers: headers,
      );

      log("getAllFamilyTaskList = " + response.body);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return FamilyTasks.fromJson(responseData);
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }

  Future<Family> getFamily({Map<String, String> headers, String date}) async {
    try {
      var response = await http.get(
        _serviceUrl.getFamily + "?date=" + date,
        headers: headers,
      );

      log("reesssss  familyyy = " + response.body);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Family.fromJson(responseData);
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }

  Future<FamilyPerson> getFamilyPersonWithId(
      {Map<String, String> headers, int id, String date}) async {
    try {

      print("jsoonn get family with id "+ jsonEncode({"personId": id, "date": date}));


      var response = await http.post(_serviceUrl.getFamilyPersonWithId,
          headers: headers, body: jsonEncode({"personId": id, "date": date}));
      log("responsee get person with id " + response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return FamilyPerson.fromJson(responseData);
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }

  Future<int> insertFamilyPersonTask(
      {Map<String, String> headers,
      int personID,
      int familyID,
      int taskID,
      String date}) async {
    try {
      var response = await http.post(_serviceUrl.insertFamilyPersonTask,
          headers: headers,
          body: jsonEncode({
            "FamilyPerson": {"Id": personID, "FamilyId": familyID},
            "FamilyTask": {"Id": taskID},
            "DateString": date
          }));

      return response.statusCode;
    } catch (e) {
      print("family hata  service= " + e.toString());
    }
  }

  Future<int> multipleInsertFamilyPersonTask(
      {Map<String, String> headers,
      int personID,
      int familyID,
      List<int> taskID,
      String date,
      int repeatType}) async {
    if (personID == null && repeatType != null) {
      log("dolu json = " +
          jsonEncode({
            "FamilyPerson": {"familyId": familyID},
            "ftIds": taskID,
            "repeat": repeatType,
            "FamilyTask": {},
            "DateString": date
          }));

      try {
        var response =
            await http.post(_serviceUrl.multipleInsertFamilyPersonTask,
                headers: headers,
                body: jsonEncode({
                  "FamilyPerson": {"familyId": familyID},
                  "ftIds": taskID,
                  "repeat": repeatType,
                  "FamilyTask": {},
                  "DateString": date
                }));

        log("rsponseee multi task repeat " + response.body);

        return response.statusCode;
      } catch (e) {
        print("family hata  service= " + e.toString());
      }
    } else {
      try {
        var response =
            await http.post(_serviceUrl.multipleInsertFamilyPersonTask,
                headers: headers,
                body: jsonEncode({
                  "FamilyPerson": {"Id": personID, "FamilyId": familyID},
                  "ftIds": taskID,
                  "FamilyTask": {},
                  "DateString": date
                }));

        return response.statusCode;
      } catch (e) {
        print("family hata  service= " + e.toString());
      }
    }
  }

  Future<Customers> getCustomerList(
      {Map<String, String> headers, int pluginID}) async {
    try {
      var response = await http.post(_serviceUrl.getCustomeList,
          headers: headers,
          body: jsonEncode({
            "pluginId": pluginID,
          }));

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      return Customers.fromJson(responseData);
    } catch (e) {
      print("Customers hata  service= " + e.toString());
    }
  }

  Future<ShopItem> getFamilyShopItemList({Map<String, String> headers}) async {
    var response = await http.get(
      _serviceUrl.getFamilyShopItemList,
      headers: headers,
    );

    log("responseee shop item list = " + response.body);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return ShopItem.fromJson(responseData);
  }

  Future<ShopOrder> getFamilyShopOrderList(
      {Map<String, String> headers, int familyId}) async {
    var response = await http.get(
      _serviceUrl.getFamilyShopOrderList + "?familyId=$familyId",
      headers: headers,
    );
    log("responseee shop order = " + response.body);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return ShopOrder.fromJson(responseData);
  }

  Future<ShopOrder> insertFamilyShopOrder({
    Map<String, String> headers,
    int itemID,
    int familyID,
  }) async {
    try {
      var response = await http.post(_serviceUrl.insertFamilyShopOrder,
          headers: headers,
          body: jsonEncode({
            "Family": {"Id": familyID},
            "FamilyshopItem": {"Id": itemID},
          }));
      log("reeess insertt = " + response.body);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      return ShopOrder.fromJson(responseData);
    } catch (e) {
      print("family hata shop  service= " + e.toString());
    }
  }

  Future<ShopOrder> insertFamilyShopOrderMultiple({
    Map<String, String> headers,
    int familyID,
    String date,
    int repeatType,
    List<int> itemID,
  }) async {
    try {
      log("orderrrrrr multtii " +
          jsonEncode({
            "FamilyShopOrder": {
              "FamilyShopItem": {},
              "Family": {"Id": familyID}
            },
            "repeat": repeatType,
            "Date": date,
            "fsiIds": itemID,
          }));
      var response = await http.post(_serviceUrl.insertFamilyShopOrderMultiple,
          headers: headers,
          body: jsonEncode({
            "FamilyShopOrder": {
              "FamilyShopItem": {},
              "Family": {"Id": familyID}
            },
            "repeat": repeatType,
            "Date": date,
            "fsiIds": itemID,
          }));

      log("reeess insertt multttiii orderr = " + response.body);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      return ShopOrder.fromJson(responseData);
    } catch (e) {
      print("family hata shop multiple  service= " + e.toString());
    }
  }

  Future<Budget> getFamilyBudgetItemList(
      {Map<String, String> headers, int familyId}) async {
    try {
      var response = await http.get(
        _serviceUrl.getFamilyBudgetItemList + "?familyId=$familyId",
        headers: headers,
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      return Budget.fromJson(responseData);
    } catch (e) {
      print("family hata shop multiple  service= " + e.toString());
    }
  }

  Future<void> insertFamilyBudgetItem(
      {Map<String, String> headers,
      int familyId,
      int payerPerson,
      String title,
      int amount,
      List<Map<String, int>> personList}) async {
    try {


      log("jsoonn insertFamilyBudgetItem" + jsonEncode({
        "FamilyId": familyId,
        "PayerPerson": {"Id": payerPerson},
        "Title": title,
        "Amount": amount,
        "personList": personList
      }));

      await http.post(
        _serviceUrl.insertFamilyBudgetItem,
        body: jsonEncode({
          "FamilyId": familyId,
          "PayerPerson": {"Id": payerPerson},
          "Title": title,
          "Amount": amount,
          "personList": personList
        }),
        headers: headers,
      );

      // final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // return Budget.fromJson(responseData);
    } catch (e) {
      print("family hata shop multiple  service= " + e.toString());
    }
  }
  Future<void> editFamilyBudgetItem(
      {Map<String, String> headers,
      int budgetItemId,
      int payerPerson,
      String title,
      int amount,
      List<Map<String, int>> personList}) async {

   var response=   await http.post(
        _serviceUrl.editFamilyBudgetItem,
        body: jsonEncode({
            "Id": budgetItemId,
            "PayerPerson": {"Id": payerPerson},
            "Title": title,
            "Amount": amount,
            "personList": personList
        }),
        headers: headers,
      );
log("reess edit budget id = " + response.body);
      // final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      // return Budget.fromJson(responseData);

  }

  Future<Gift> getFamilyGiftList(
      {Map<String, String> headers, int familyId}) async {
    try {
      var response = await http.get(
        _serviceUrl.getFamilyGiftList + "?familyId=$familyId",
        headers: headers,
      );
      log("giiffttt  = " + response.body);

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return Gift.fromJson(responseData);
    } catch (e) {
      print("family hata shop multiple  service= " + e.toString());
    }
  }

  Future<List<Plugins>> getPluginList({Map<String, String> headers}) async {
    try {
      var response = await http.get(
        _serviceUrl.getPluginList,
        headers: headers,
      );
      log("plugin list  = " + response.body);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      List<Plugins> data;
      data = new List<Plugins>();
      responseData['data'].forEach((v) {
        data.add(new Plugins.fromJson(v));
      });
      return data;
    } catch (e) {
      print("plugin list hata    service= " + e.toString());
    }
  }

  Future<Family> createFamily(
      {Map<String, String> headers, String title, File file}) async {
    try {
      List<int> imageBytes = file.readAsBytesSync();
      String fileName = basename(file.path).toString();
      String content = base64Encode(imageBytes);
      log("jsssoonn  = " +
          jsonEncode({
            "f": {"Title": title},
            "Picture": {
              "Directory": "",
              "FileContent": content,
              "FileName": fileName
            }
          }));

      var response = await http.post(
        _serviceUrl.createFamily,
        body: jsonEncode({
          "f": {"Title": title},
          "Picture": {
            "Directory": "",
            "FileContent": content,
            "FileName": fileName
          }
        }),
        headers: headers,
      );
      log("ress create family= " + response.body);

      if (response.statusCode == 200) {
        DateTime date = DateTime.now();

        return await getFamily(
            headers: headers,
            date: date.day.toString() +
                "/" +
                date.month.toString() +
                "/" +
                date.year.toString());
      }
    } catch (e) {
      print("plugin list hata    service= " + e.toString());
    }
  }

  Future<Family> addPerson(
      {Map<String, String> headers,
      int age,
      String email,
      String phone,
      String firstName,
      String lastName,
      int familyId}) async {
    var response = await http.post(
      _serviceUrl.addPerson,
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phone,
        "familyId": familyId,
        "age": age
      }),
      headers: headers,
    );

    if (response.statusCode == 200) {
      DateTime date = DateTime.now();

      return await getFamily(
          headers: headers,
          date: date.day.toString() +
              "/" +
              date.month.toString() +
              "/" +
              date.year.toString());
    }
  }

  Future<TaskMessage> getFamilyPersonTaskMessageList(
      {int id, Map<String, String> headers}) async {
    print("id = " + id.toString());
    var response = await http.get(
      _serviceUrl.getFamilyPersonTaskMessageList + "?prm=$id",
      headers: headers,
    );
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return TaskMessage.fromJson(responseData);
  }

  insertFamilyPersonTaskMessage(
      {int id, Map<String, String> headers, String message}) async {
    await http.post(_serviceUrl.insertFamilyPersonTaskMessage,
        headers: headers,
        body: jsonEncode({
          "personTaskId": id,
          "message": message,
        }));
  }

  Future<RepeatTasks> getFamilyPersonTaskListRepeat(
      {Map<String, String> headers, int familyId}) async {
    var response = await http.get(
      _serviceUrl.getFamilyPersonTaskListRepeat,
      headers: headers,
    );
    log("repeat ress = + 0 " + response.body);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return RepeatTasks.fromJson(responseData);
  }

  Future<int> editFamilyPersonTaskDetailsWithPersonId(
      {Map<String, String> headers,
      int personId,
      int familyPersonTaskId,
      int status,
      int points}) async {


    log("reeqqqq= " +jsonEncode({
      "id": familyPersonTaskId,
      "status": status,
      "points": points,
      "FamilyPerson": {"Id": personId}
    }));

    var response =
        await http.post(_serviceUrl.editFamilyPersonTaskDetailsWithPersonId,
            headers: headers,
            body: jsonEncode({
              "id": familyPersonTaskId,
              "status": status,
              "points": points,
              "FamilyPerson": {"Id": personId}
            }));
    log("repeat ress edit  = + 0 " + response.body);

    return response.statusCode;
  }

  Future<void> editFamilyShopOrder(
      {Map<String, String> headers, int unit, int count, int id}) async {
    var response = await http.post(_serviceUrl.editFamilyShopOrder,
        headers: headers,
        body: jsonEncode({
          "id": id,
          "unit": unit,
          "count": count,
        }));
  }

  Future<void> deleteFamilyShopOrder(
      {int id, Map<String, String> headers}) async {
    var response = await http.get(
        _serviceUrl.deleteFamilyShopOrder + "?fsoId=$id",
        headers: headers);

    log("order ress delete order  = + 0 " + response.body);
  }

  Future<void> buyFamilyShopOrder(
      {int familyId,
      Map<String, String> headers,
      List<int> fsoIds,
      int price}) async {
    log("buy json" +
        jsonEncode(
            {"fsoIds": fsoIds, "fsoPrice": price, "familyId": familyId}));

    var response = await http.post(_serviceUrl.buyFamilyShopOrder,
        headers: headers,
        body: jsonEncode(
            {"fsoIds": fsoIds, "fsoPrice": price, "familyId": familyId}));
    log("order ress buyy order  = + 0 " + response.body);
  }

  Future<int> editFamilyPersonTaskPersonId(
      {List<int> fptIds, int personId, Map<String, String> headers}) async {
    log("ediiitttttt json" +
        jsonEncode({
          "fptIds": fptIds,
          "personId": personId,
        }));

    var response = await http.post(_serviceUrl.editFamilyPersonTaskPersonId,
        headers: headers,
        body: jsonEncode({
          "fptIds": fptIds,
          "personId": personId,
        }));
    log("task ress edit   = + 0 " + response.body);
    return response.statusCode;
  }

  insertFamilyGift(
      {int familyId,
      Map<String, String> headers,
      String title,
      int point,
      File file}) async {
    try {
      List<int> imageBytes = file.readAsBytesSync();
      String fileName = basename(file.path).toString();
      String content = base64Encode(imageBytes);


      var response = await http.post(
        _serviceUrl.insertFamilyGift,
        body: jsonEncode({
          "familyId": familyId,
          "title": title,
          "point": point,
          "Picture": {
            "Directory": "",
            "FileContent": content,
            "FileName": fileName
          },

        }),
        headers: headers,
      );


    } catch (e) {
      print("ress create giftt  service= " + e.toString());
    }
  }

  insertFamilyPersonTaskLike({Map<String, String> headers, int familyPersonTaskId}) async {
    var response = await http.get(
      _serviceUrl.insertFamilyPersonTaskLike+"?familyPersonTaskId=$familyPersonTaskId",

      headers: headers,
    );

log("insertFamilyPersonTaskLike = " + response.body);

  }

  getFamilyBudgetItem({Map<String, String> headers, int id}) async {
    var response = await http.get(
      _serviceUrl.getFamilyBudgetItem + "?id=$id",
      headers: headers,
    );
log("Reessss budget = " + response.body);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return BudgetData.fromJson(responseData['data']);
  }


}
