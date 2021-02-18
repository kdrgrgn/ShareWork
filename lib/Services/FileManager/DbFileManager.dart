import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobi/model/FileManager/FileManager.dart';
import 'package:path/path.dart';

import '../ServiceUrl.dart';
import 'FileManagerBase.dart';


class DbFileManager implements FileManagerBase {
  final ServiceUrl _serviceUrl = ServiceUrl();

  @override
  Future createDirectory(Map<String, String> header,
      {int userId,
      int customerId = 0,
      int moduleType = 3,
      int ownerId,
      String directoryName}) async {
    var response =
        await http.post(_serviceUrl.createDirectory, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "customerId": customerId,
              "moduleTypeId": moduleType,
              "ownerId": ownerId,
              "directoryName": directoryName
            }
        ));
    log("createDirectory = " + response.body);
  }

  @override
  Future deleteDirectory(Map<String, String> header,
      {int userId,
      int customerId = 0,
      int moduleType = 3,
      String directoryName}) async {

    var response =
        await http.post(_serviceUrl.deleteDirectory, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "customerId": customerId,
              "moduleTypeId": moduleType,
              "directoryName": directoryName
            }
        ));
    log("deleteDirectory = " + response.body);
  }

  @override
  Future deleteMultiFileAndDirectory(Map<String, String> header,
      {int userId,
      int customerId = 0,
      int moduleType = 3,
      List<String> sourceDirectoryNameList,
      List<int> fileIdList,
      int sourceOwnerId}) async {
    print("deleteMultiFileAndDirectory = "+jsonEncode(
        {
          "userId": userId,
          "customerId": customerId,
          "moduleTypeId": moduleType,
          "sourceDirectoryNameList": [],
          "fileIdList": fileIdList,
          "sourceOwnerId": sourceOwnerId
        }
    ));
    var response =
        await http.post(_serviceUrl.deleteMultiFileAndDirectory, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "customerId": customerId,
              "moduleTypeId": moduleType,
              "sourceDirectoryNameList": [],
              "fileIdList": fileIdList,
              "sourceOwnerId": sourceOwnerId
            }
        ));
    log("deleteMultiFileAndDirectory = " + response.body);
    return response.body;
  }

  @override
  Future fileRename(Map<String, String> header,
      {int userId, int fileId = 0, String newFileName}) async {
    var response =
        await http.post(_serviceUrl.fileRename, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "fileId": fileId,
              "newFileName": newFileName
              }
        ));
    log("fileRename = " + response.body);
  }

  @override
  Future<FileManager> getFilesByUserIdForDirectory(Map<String, String> header,
      {int userId,
      int customerId = 0,
      int moduleType = 3,
      int page = 0,
      String directory}) async {
    print("directory = " +  directory);
    var response =
        await http.post(_serviceUrl.getFilesByUserIdForDirectory, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "customerId": customerId,
              "moduleType": moduleType,
              "directory": directory,
              "page": page
            }
        ));
    log("getFilesByUserIdForDirectory = " + response.body);
    final responseData = jsonDecode(response.body) as Map<String, dynamic>;


    return FileManager.fromJson(responseData);

  }

  @override
  Future renameDirectory(Map<String, String> header,
      {int userId,
        int folderId,
        String newDirectoryName}) async {
    print("rename directory = "+ jsonEncode(
        {
          "userId": userId,
          "newDirectoryName": newDirectoryName,
          "FolderId":folderId
        }
    ));
    var response =
        await http.post(_serviceUrl.renameDirectory, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "newDirectoryName": newDirectoryName,
              "FolderId":folderId

            }
        ));
    log("renameDirectory = " + response.body);


  }

  @override
  Future uploadFiles(Map<String, String> header,
      {int userId,
      int customerId = 0,
        String directory,
        String moduleType = "3",
      List<File> files,
      bool isCombine = false,
      String combineFileName = ""}) async {



List<Map<String,dynamic>> reqFile=[];

files.forEach((file) {
  List<int> imageBytes = file.readAsBytesSync();
  String fileName = basename(file.path).toString();
  String content = base64Encode(imageBytes);

  reqFile.add(  {
    "fileName": fileName,
    "directory": directory,
    "fileContent": content,

  });

});




    var response =
        await http.post(_serviceUrl.filesUpload, headers: header,
        body: jsonEncode(
            {
              "userId": userId,
              "customerId": customerId,
              "moduleTypeId": moduleType,
              "files": reqFile,
              "isCombine": isCombine,
              "combineFileName": combineFileName
            }
        ));
    log("uploadFiles = " + response.body);
    final responseData = jsonDecode(response.body) as List;
List<FileResult> result=[];
    if (responseData != null) {
      responseData.forEach((v) {
        result.add(new FileResult.fromJson(v));
      });
    }

    return result;
  }
}
