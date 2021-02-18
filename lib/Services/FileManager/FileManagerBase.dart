import 'dart:io';

import 'package:mobi/model/FileManager/FileManager.dart';

abstract class FileManagerBase {
  Future<FileManager> getFilesByUserIdForDirectory(Map<String, String> header,
      {int userId,
      int customerId: 0,
      int moduleType: 3,
      int page: 0,
      String directory});

  Future createDirectory(Map<String, String> header,
      {int userId,
      int customerId: 0,
      int moduleType: 3,
      int ownerId,
      String directoryName});

  Future deleteDirectory(Map<String, String> header,
      {int userId, int customerId: 0, int moduleType: 3, String directoryName});

  Future uploadFiles(Map<String, String> header,
      {int userId,
      int customerId: 0,
      String moduleType: "3",
      List<File> files,
        String directory,
      bool isCombine: false,
      String combineFileName: ""});

  Future deleteMultiFileAndDirectory(Map<String, String> header,
      {int userId,
      int customerId: 0,
      int moduleType: 3,
      List<String> sourceDirectoryNameList,
      List<int> fileIdList,
      int sourceOwnerId});

  Future renameDirectory(Map<String, String> header,
      {int userId,
      int folderId,
     String newDirectoryName});

  Future fileRename(Map<String, String> header,
      {int userId,
      int fileId: 0,
      String newFileName});
}
