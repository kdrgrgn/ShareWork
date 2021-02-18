import 'dart:io';

import 'package:get/get.dart';
import 'package:mobi/Services/FileManager/DbFileManager.dart';
import 'package:mobi/Services/FileManager/FileManagerBase.dart';
import 'package:mobi/model/FileManager/FileManager.dart';

class ControllerFileManager extends GetxController implements FileManagerBase {
  DbFileManager _fileManager = DbFileManager();
RxList<String> directory=[""].obs;
RxList<int> fileIdList=[0].obs;
RxBool delete=false.obs;
  RxList<FileResult> fileResult;

  @override
  Future createDirectory(Map<String, String> header,
      {int userId,
        int customerId = 0,
        int moduleType = 3,
        int ownerId,
        String directoryName}) {
    _fileManager.createDirectory(header,
        userId: userId,
        customerId: customerId,
        moduleType: moduleType,
        ownerId: ownerId,
        directoryName: directoryName);
  }

  @override
  Future deleteDirectory(Map<String, String> header,
      {int userId,
        int customerId = 0,
        int moduleType = 3,
        String directoryName}) {
    _fileManager.deleteDirectory(header,
        userId: userId,
        customerId: customerId,
        moduleType: moduleType,
        directoryName: directoryName);
  }

  @override
  Future deleteMultiFileAndDirectory(Map<String, String> header,
      {int userId,
        int customerId = 0,
        int moduleType = 3,
        List<String> sourceDirectoryNameList,
        List<int> fileIdList,
        int sourceOwnerId}) async {
   return await _fileManager.deleteMultiFileAndDirectory(header,
        userId: userId,
        customerId: customerId,
        moduleType: moduleType,
        sourceDirectoryNameList: sourceDirectoryNameList,
        fileIdList: fileIdList,
        sourceOwnerId: sourceOwnerId);
  }

  @override
  Future fileRename(Map<String, String> header,
      {int userId, int fileId = 0, String newFileName}) {
    _fileManager.fileRename(header,
        userId: userId, fileId: fileId, newFileName: newFileName);
  }

  @override
  Future<FileManager> getFilesByUserIdForDirectory(Map<String, String> header,
      {int userId,
        int customerId = 0,
        int moduleType = 3,
        int page = 0,
        String directory}) async {
  FileManager files=await  _fileManager.getFilesByUserIdForDirectory(header,
        userId: userId,
        customerId: customerId,
        moduleType: moduleType,
        page: page,
        directory: directory);
  if(page==0) {
    fileResult = files.data.result.obs;
  }else{
    fileResult.addAll(files.data.result);

  }
  update();
 return files;
  }



  @override
  Future renameDirectory(Map<String, String> header,
      {int userId,
        int folderId,
        String newDirectoryName}) {
    _fileManager.renameDirectory(header,userId: userId,
         folderId: folderId,
         newDirectoryName: newDirectoryName);
  }

  @override
  Future uploadFiles(Map<String, String> header,
      {int userId,
        int customerId = 0,

        String moduleType = "3",
        List<File> files,
        String directory,

        bool isCombine = false,
        String combineFileName = ""}) {
   return  _fileManager.uploadFiles(header, userId: userId,
        customerId: customerId,
        moduleType: moduleType,
        files: files,
        isCombine
        : isCombine,combineFileName: combineFileName,directory: directory);
  }

  updateDirectory(String newDirectory){

    directory.add("/");
    directory.add(newDirectory);
    update();
  }
  updatePopDirectory(){

    directory.removeLast();
    directory.removeLast();
    update();
  }
deleteFolder(FileResult result){
    fileResult.remove(result);
    update();

}

 String getDirectory() {
    String get="";
if(directory.length>1) {
  int i=0;
  directory.forEach((element) {
    if(i!=1) {
      get =get+ element ;
    }
    i++;

  });
}

    return get;
  }

  updateDeleting(bool state) {
    delete = state.obs;
    update();
  }
removeDeleting(int id){
    fileIdList.remove(id);
    update();
if(fileIdList.length==0){
  fileIdList=[0].obs;
  update();
  }

  if(fileIdList.length==0){
    deleteCancel();
  }
}
deleteCancel(){

    fileIdList=[0].obs;
    update();
delete=false.obs;
update();
  }

  addDeleting(int id){
      if(fileIdList.first==0){
        fileIdList.remove(0);
        fileIdList.add(id);
      }
      else {
        fileIdList.add(id);
      }
      update();




  }
updateName(int index,bool isFolder,String name){
    if(isFolder) {
      fileResult[index].folderName=name;
      update();
    }
    else{
      fileResult[index].fileName=name;
      update();
    }
}

}
