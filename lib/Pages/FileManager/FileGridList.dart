import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/FileManagerController.dart';
import 'package:mobi/Pages/FileManager/FolderManager.dart';
import 'package:mobi/model/FileManager/FileManager.dart';
import 'package:open_file/open_file.dart';

class FileGridList extends StatefulWidget {
  FileResult fileResult;
  String downloadPath;
  int index;

  FileGridList(this.fileResult, this.downloadPath, this.index);

  @override
  _FileGridListState createState() => _FileGridListState();
}

class _FileGridListState extends State<FileGridList> {
  bool isExist;
  ControllerFileManager _fileManager = Get.put(ControllerFileManager());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isExist = File(widget.downloadPath +
            Platform.pathSeparator +
            widget.fileResult.fileName)
            .existsSync();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return fileBox(widget.fileResult);
  }

  Widget buildDirectory(FileResult file) {
    return GetBuilder<ControllerFileManager>(builder: (f) {
      return InkWell(
        onLongPress: () {
          if (!f.delete.value) {
            f.updateDeleting(true);
            f.addDeleting(file.id);
          }
        },
        onTap: () {
          if (f.delete.value) {
            if (f.fileIdList.contains(file.id)) {
              f.removeDeleting(file.id);
            } else {
              f.addDeleting(file.id);
            }
          } else {
            _fileManager.updateDirectory(file.folderName);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FolderManager(
                          isGridView: true,
                        )));
          }
        },
        child: Column(children: [
          Container(
            width: 80,
            height: 100,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/directory.png",
                  height: 100,
                ),
                f.delete.value
                    ? Align(
                  alignment: Alignment.topRight,
                  child: Icon(f.fileIdList.contains(file.id)
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked_rounded),
                )
                    : Container() /*Align(
                  alignment: Alignment.topRight,

                  child: InkWell(
                    onTap: () => editName(isFolder: true),
                    child: Icon(Icons.edit),
                  ),
                )*/,
              ],
            ),
          ),
          Text(
            file.folderName,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40,),

                Text(
                  "${file.createDate.substring(0, 10)}",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: () => editName(isFolder: true),
                  child: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
        ]),
      );
    });
  }

  Widget buildFile(FileResult file) {
    return GetBuilder<ControllerFileManager>(builder: (f) {
      return InkWell(
        onLongPress: () {
          if (!f.delete.value) {
            f.updateDeleting(true);
            f.addDeleting(file.id);
          }
        },
        onTap: () async {
          if (f.delete.value) {
            if (f.fileIdList.contains(file.id)) {
              f.removeDeleting(file.id);
            } else {
              f.addDeleting(file.id);
            }
          } else {
            if (!File(widget.downloadPath +
                Platform.pathSeparator +
                widget.fileResult.fileName)
                .existsSync()) {
              FlutterDownloader.enqueue(
                  url: file.path,
                  savedDir: widget.downloadPath,
                  openFileFromNotification: false)
                  .then((value) {
                Get.showSnackbar(GetBar(message: "Dosya indiriliyor...",
                  duration: Duration(seconds: 3),));
                setState(() {
                  isExist = true;
                });
              });
            }

            OpenFile.open(
                widget.downloadPath + Platform.pathSeparator + file.fileName);
          }
        },
        child: Column(children: [
          Container(
            width: 80,
            height: 100,
            child: Stack(
              children: [
                Image.network(
                  file.thumbnailUrl,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: 80,
                  height: 100,
                  color: Colors.grey.withOpacity(0.4),
                  child: Icon(
                    isExist ?? false
                        ? Icons.download_done_outlined
                        : Icons.download_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                f.delete.value
                    ? Align(
                  alignment: Alignment.topRight,
                  child: Icon(f.fileIdList.contains(file.id)
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked_rounded),
                )
                    : Container(),
              ],
            ),
          ),
          Text(
            file.fileName,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40,),

                Text(
                  "${file.createDate.substring(0, 10)}",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 20,),
                Align(
                  alignment: Alignment.topRight,

                  child: InkWell(
                    onTap: () => editName(isFolder: false),
                    child: Icon(Icons.more_vert),
                  ),
                )
              ],
            ),
          ),
        ]),
      );
    });
  }

  Widget fileBox(FileResult file) {
    String extension = file.extension;

    switch (extension) {
      case null:
        return buildDirectory(file);
        break;

      default:
        return buildFile(file);
        break;
    }
  }

  editName({bool isFolder}) {
    String newName;
    final _formKey = GlobalKey<FormState>();
    ControllerDB _controllerDB = Get.put(ControllerDB());
    bool isEdit = false;

    showDialog(context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text(
                      isFolder ? widget.fileResult.folderName : widget
                          .fileResult
                          .fileName),
                  actions: [
                    isEdit ? FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (isFolder) {
                            String newN = _fileManager
                                .getDirectory()
                                .isEmpty
                                ? newName
                                : _fileManager.getDirectory() + "/" +
                                newName;

                            _fileManager.renameDirectory(_controllerDB
                                .headers(),
                                userId: _controllerDB.user.value.data.id,
                                newDirectoryName: newN,
                                folderId: widget.fileResult.id

                            );
                            setState(() {
                              widget.fileResult.folderName = newName;
                              _fileManager.updateName(widget.index, isFolder, newName);
                            });
                          } else {
                            _fileManager.fileRename(_controllerDB.headers(),
                                userId: _controllerDB.user.value.data.id,
                                newFileName: newName,
                                fileId: widget.fileResult.id
                            );
                            setState(() {
                              widget.fileResult.fileName = newName;
                              _fileManager.updateName(widget.index, isFolder, newName);

                            });
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                    ) : Container(),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red,
                    )


                  ],
                  content: isEdit ? Form(
                    key: _formKey,
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        onSaved: (value) {
                          newName = value;
                        },
                        validator: (value) =>
                        value.isEmpty ? "Bos olamaz" : null,
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ) : Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          setState(() {
                            isEdit = true;
                          });
                        },
                        title: Text("Edit Name"),
                        trailing: Icon(Icons.edit),
                      ),
                      Divider(),
                      ListTile(
                        onTap: () async {
                          String res = await _fileManager
                              .deleteMultiFileAndDirectory(
                              _controllerDB.headers(),
                              userId: _controllerDB.user.value.data.id,
                              sourceOwnerId: _controllerDB.user.value.data.id,
                              fileIdList: [widget.fileResult.id]);
                          if (res == "true") {
                            _fileManager.deleteFolder(widget.fileResult);
                          }
                          else{
                            Get.showSnackbar(GetBar(message: "Islem gerceklesmedi",duration: Duration(seconds: 2),));
                          }
                          Navigator.pop(context);

                        },
                        title: Text("Delete"),
                        trailing: Icon(Icons.delete),
                      ),
                    ],
                  )
                  ,
                );
              }
          );
        });
  }
}
