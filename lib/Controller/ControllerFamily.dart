import 'dart:io';

import 'package:get/get.dart';
import 'package:mobi/model/Family/Budget/Budget.dart';
import 'package:mobi/model/Family/Family.dart';
import 'package:mobi/model/Family/FamilyPerson.dart';
import 'package:mobi/model/Family/Gift/Gift.dart';
import 'package:mobi/model/Family/Shop/ShopItem.dart';
import 'package:mobi/model/Family/Shop/ShopOrder.dart';
import 'package:mobi/model/Family/Social/Feed.dart';
import 'package:mobi/model/Family/Task/FamilyTasks.dart';
import 'package:mobi/model/Family/Task/RepeatTasks.dart';
import 'package:mobi/model/Family/Task/TaskMessage.dart';
import 'package:mobi/Services/Family/FamilyService.dart';
import 'package:mobi/Services/Family/FamilyBase.dart';

class ControllerFamily extends GetxController implements FamilyServiceBase {
  Rx<Family> family = null.obs;
  FamilyService _dbService = FamilyService();

  Future<Family> createFamily(
      {Map<String, String> headers, String title, File file}) async {
    Family result = await _dbService.createFamily(
        headers: headers, title: title, file: file);
    family = result.obs;
    update();
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

  Future<int> insertFamilyPersonTask(
      {Map<String, String> headers,
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

  Future<int> multipleInsertFamilyPersonTask(
      {Map<String, String> headers,
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

  Future<ShopOrder> insertFamilyShopOrderMultiple(
      {int familyID,
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

  Future<void> insertFamilyBudgetItem(
      {Map<String, String> headers,
      int familyId,
      int payerPerson,
      String title,
      int amount,
      List<Map<String, int>> personList}) async {
    await _dbService.insertFamilyBudgetItem(
        headers: headers,
        familyId: familyId,
        payerPerson: payerPerson,
        title: title,
        amount: amount,
        personList: personList);
  }

  Future<void> editFamilyBudgetItem(
      {Map<String, String> headers,
      int budgetItemId,
      int payerPerson,
      String title,
      int amount,
      List<Map<String, int>> personList}) async {
    await _dbService.editFamilyBudgetItem(
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

  addPerson(
      {Map<String, String> headers,
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

  buyFamilyShopOrder(
      {int familyId,
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

  insertFamilyGift(
      {int familyId,
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

  @override
  acceptFamilyship(Map<String, String> header, {int id}) async {
    return await _dbService.acceptFamilyship(header, id: id);
  }

  @override
  getFamilyInviteList(Map<String, String> header, {int familyId}) async {
    return await _dbService.getFamilyInviteList(header, familyId: familyId);
  }

  @override
  getFamilySearch(Map<String, String> header, {String text}) async {
    return await _dbService.getFamilySearch(header, text: text);
  }

  @override
  getFamilySocialFamilyList(Map<String, String> header, {int id}) async {
    return await _dbService.getFamilySocialFamilyList(header, id: id);
  }

  @override
  ignoreFamilyship(Map<String, String> header, {int id}) async {
    return await _dbService.ignoreFamilyship(header, id: id);
  }

  @override
  insertFamilyshipInvite(Map<String, String> header,
      {int receiverFamilyId}) async {
    return await _dbService.insertFamilyshipInvite(header,
        receiverFamilyId: receiverFamilyId);
  }

  @override
  Future<Feed> getFamilyFeedListHome(Map<String, String> header, {int familyId,int page,int rowsPerPage}) async {
    return await _dbService.getFamilyFeedListHome(header, familyId: familyId,page: page,rowsPerPage: rowsPerPage);
  }

  @override
  getFamilyFeedReplyList(Map<String, String> header, {int familyFeedId}) async {
    return await _dbService.getFamilyFeedReplyList(header,
        familyFeedId: familyFeedId);
  }

  @override
  insertFamilyFeed(Map<String, String> header,
      {int familyId, int personId, String feed}) async {
    return await _dbService.insertFamilyFeed(header,
        familyId: familyId, personId: personId, feed: feed);
  }

  @override
  insertFamilyFeedReply(Map<String, String> header,
      {int familyFeedId, int personId, String feed}) async {
    return await _dbService.insertFamilyFeedReply(header,
        familyFeedId: familyFeedId, personId: personId, feed: feed);
  }

  @override
  deleteFamilyFeedLike(Map<String, String> header, {int feedId}) async {
   return await _dbService.deleteFamilyFeedLike(header,feedId: feedId);
  }

  @override
  insertFamilyFeedLike(Map<String, String> header, {int feedId}) async {
    return await _dbService.insertFamilyFeedLike(header,feedId: feedId);

  }
}
