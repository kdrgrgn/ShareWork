import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobi/model/Family/Budget/Budget.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/Gift/Gift.dart';
import 'package:mobi/model/Family/Shop/ShopItem.dart';
import 'package:mobi/model/Family/Shop/ShopOrder.dart';
import 'package:mobi/model/Family/Social/Feed.dart';
import 'package:mobi/model/Family/Social/FeedReply.dart';
import 'package:mobi/model/Family/Social/Invite.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/RepeatTasks.dart';
import 'package:mobi/model/Family/Task/TaskMessage.dart';
import 'package:mobi/Services/ServiceUrl.dart';
import 'package:mobi/Services/Family/FamilyBase.dart';
import 'package:path/path.dart';

class FamilyService implements FamilyServiceBase {
  final ServiceUrl _serviceUrl = ServiceUrl();

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
      print("jsoonn get family with id " +
          jsonEncode({"personId": id, "date": date}));

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
      log("jsoonn insertFamilyBudgetItem" +
          jsonEncode({
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
    var response = await http.post(
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
    log("reeqqqq= " +
        jsonEncode({
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
    await http.post(_serviceUrl.editFamilyShopOrder,
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

      await http.post(
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

  insertFamilyPersonTaskLike(
      {Map<String, String> headers, int familyPersonTaskId}) async {
    var response = await http.get(
      _serviceUrl.insertFamilyPersonTaskLike +
          "?familyPersonTaskId=$familyPersonTaskId",
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

  @override
  acceptFamilyship(Map<String, String> header, {int id}) async {
    var response = await http.get(
      _serviceUrl.acceptFamilyship + "?id=$id",
      headers: header,
    );
    log("Reessss acceptFamilyship = " + response.body);
    //   final responseData = jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  getFamilyInviteList(Map<String, String> header, {int familyId}) async {
    var response = await http.get(
      _serviceUrl.getFamilyInviteList + "?familyId=$familyId",
      headers: header,
    );
    log("Reessss getFamilyInviteList = " + response.body);
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Invite.fromJson(json);
  }

  @override
  getFamilySearch(Map<String, String> header, {String text}) async {
    var response = await http.get(
      _serviceUrl.getFamilySearch + "?text=$text",
      headers: header,
    );
    log("Reessss getFamilySearch = " + response.body);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    List<FamilyData> data = [];

    if (json['data'] != null) {
      final list = json['data'] as List;
      list.forEach((v) {
        data.add(new FamilyData.fromJson(v));
      });
    }
    return data;
  }

  @override
  getFamilySocialFamilyList(Map<String, String> header, {int id}) async {
    var response = await http.get(
      _serviceUrl.getFamilySocialFamilyList + "?id=$id",
      headers: header,
    );
    log("Reessss getFamilySocialFamilyList = " + response.body);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    List<FamilyData> data = [];

    if (json['data'] != null) {
      final list = json['data'] as List;
      list.forEach((v) {
        data.add(new FamilyData.fromJson(v));
      });
    }
    return data;
  }

  @override
  ignoreFamilyship(Map<String, String> header, {int id}) async {
    var response = await http.get(
      _serviceUrl.ignoreFamilyship + "?id=$id",
      headers: header,
    );
    log("Reessss ignoreFamilyship = " + response.body);
    //   final responseData = jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  insertFamilyshipInvite(Map<String, String> header,
      {int receiverFamilyId}) async {
    var response = await http.get(
      _serviceUrl.insertFamilyshipInvite +
          "?receiverFamilyId=$receiverFamilyId",
      headers: header,
    );
    log("Reessss insertFamilyshipInvite = " + response.body);
    //   final responseData = jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  Future<Feed> getFamilyFeedListHome(Map<String, String> header, {int familyId,int page,int rowsPerPage}) async {
  // print("req = " + _serviceUrl.getFamilyFeedListHome + "?familyId=$familyId&page=$page&rowsPerPage=$rowsPerPage");
    var response = await http.get(
      _serviceUrl.getFamilyFeedListHome + "?familyId=$familyId&page=$page&rowsPerPage=$rowsPerPage",
      headers: header,
    );
  //  log("Reessss getFamilyFeedListHome = " + response.body);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return Feed.fromJson(responseData);
  }

  @override
  getFamilyFeedReplyList(Map<String, String> header, {int familyFeedId}) async {
    var response = await http.get(
      _serviceUrl.getFamilyFeedReplyList + "?familyFeedId=$familyFeedId",
      headers: header,
    );
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;
    return Reply.fromJson(responseData);
  }

  @override
  insertFamilyFeed(Map<String, String> header,
      {int familyId, int personId, String feed}) async {

    var response = await http.post(
      _serviceUrl.insertFamilyFeed,
      body: jsonEncode(
          {"familyId": familyId, "personId": personId, "feed": feed}),
      headers: header,
    );

    log("Reessss insertFamilyFeed = " + response.body);
  }

  @override
  insertFamilyFeedReply(Map<String, String> header,
      {int familyFeedId, int personId, String feed}) async {
    var response = await http.post(
      _serviceUrl.insertFamilyFeedReply,
      body: jsonEncode({
        "familyFeedId": familyFeedId,
        "personId": personId,
        "feed": feed,
      }),
      headers: header,
    );
    log("Reessss insertFamilyFeedReply = " + response.body);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return ReplyData.fromJson(responseData['data']);
  }

  @override
  deleteFamilyFeedLike(Map<String, String> header, {int feedId}) async {
    var response = await http.get(
      _serviceUrl.deleteFamilyFeedLike + "?FeedId=$feedId",
      headers: header,
    );
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    log("Reessss deleteFamilyFeedLike = " + response.body);

  }

  @override
  insertFamilyFeedLike(Map<String, String> header, {int feedId}) async {
    var response = await http.get(
      _serviceUrl.insertFamilyFeedLike + "?FeedId=$feedId",
      headers: header,
    );
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    log("Reessss insertFamilyFeedLike = " + response.body);

    return LikeList.fromJson(responseData['data']);

  }
}
