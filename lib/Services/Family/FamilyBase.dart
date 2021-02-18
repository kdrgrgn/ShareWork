import 'dart:io';

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

abstract class FamilyServiceBase {
  Future<FamilyTasks> getAllFamilyTaskList({Map<String, String> headers});

  Future<Family> getFamily({Map<String, String> headers, String date});

  Future<FamilyPerson> getFamilyPersonWithId(
      {Map<String, String> headers, int id, String date});

  Future<int> insertFamilyPersonTask(
      {Map<String, String> headers,
      int personID,
      int familyID,
      int taskID,
      String date});

  Future<int> multipleInsertFamilyPersonTask(
      {Map<String, String> headers,
      int personID,
      int familyID,
      List<int> taskID,
      String date,
      int repeatType});

  Future<ShopItem> getFamilyShopItemList({Map<String, String> headers});

  Future<ShopOrder> getFamilyShopOrderList(
      {Map<String, String> headers, int familyId});

  Future<ShopOrder> insertFamilyShopOrder({
    Map<String, String> headers,
    int itemID,
    int familyID,
  });

  Future<ShopOrder> insertFamilyShopOrderMultiple({
    Map<String, String> headers,
    int familyID,
    String date,
    int repeatType,
    List<int> itemID,
  });

  Future<Budget> getFamilyBudgetItemList(
      {Map<String, String> headers, int familyId});

  Future<void> insertFamilyBudgetItem(
      {Map<String, String> headers,
      int familyId,
      int payerPerson,
      String title,
      int amount,
      List<Map<String, int>> personList});

  Future<void> editFamilyBudgetItem(
      {Map<String, String> headers,
      int budgetItemId,
      int payerPerson,
      String title,
      int amount,
      List<Map<String, int>> personList});

  Future<Gift> getFamilyGiftList({Map<String, String> headers, int familyId});

  Future<Family> createFamily(
      {Map<String, String> headers, String title, File file});

  Future<Family> addPerson(
      {Map<String, String> headers,
      int age,
      String email,
      String phone,
      String firstName,
      String lastName,
      int familyId});

  Future<TaskMessage> getFamilyPersonTaskMessageList(
      {int id, Map<String, String> headers});



  insertFamilyPersonTaskMessage(
      {int id, Map<String, String> headers, String message});


  Future<RepeatTasks> getFamilyPersonTaskListRepeat(
      {Map<String, String> headers, int familyId});


  Future<int> editFamilyPersonTaskDetailsWithPersonId(
      {Map<String, String> headers,
        int personId,
        int familyPersonTaskId,
        int status,
        int points});

  Future<void> editFamilyShopOrder(
      {Map<String, String> headers, int unit, int count, int id});

  Future<void> deleteFamilyShopOrder(
      {int id, Map<String, String> headers});
  Future<void> buyFamilyShopOrder(
      {int familyId,
        Map<String, String> headers,
        List<int> fsoIds,
        int price});

  Future<int> editFamilyPersonTaskPersonId(
      {List<int> fptIds, int personId, Map<String, String> headers});

  insertFamilyGift(
      {int familyId,
        Map<String, String> headers,
        String title,
        int point,
        File file});

  insertFamilyPersonTaskLike({Map<String, String> headers, int familyPersonTaskId});

  getFamilyBudgetItem({Map<String, String> headers, int id});



  getFamilySocialFamilyList(Map<String, String> header,{int id});

  getFamilySearch(Map<String, String> header,{String text});

  insertFamilyshipInvite(Map<String, String> header,{int receiverFamilyId});

  getFamilyInviteList(Map<String, String> header,{int familyId});


  acceptFamilyship(Map<String, String> header,{int id});

  ignoreFamilyship(Map<String, String> header,{int id});


  Future<Feed> getFamilyFeedListHome(Map<String, String> header,{int familyId,int page,int rowsPerPage});

  getFamilyFeedReplyList(Map<String, String> header,{int familyFeedId});

  insertFamilyFeedLike(Map<String, String> header,{int feedId});

  deleteFamilyFeedLike(Map<String, String> header,{int feedId});

  insertFamilyFeed(Map<String, String> header,{int familyId,int personId,String feed});

  insertFamilyFeedReply(Map<String, String> header,{int familyFeedId,int personId,String feed});




}
