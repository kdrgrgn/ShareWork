import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobi/Pages/FileManager/FileGridList.dart';
import 'package:mobi/model/FileManager/FileManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/FileManagerController.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:path_provider/path_provider.dart';

import 'FileListView.dart';

class FolderManager extends StatefulWidget {
  bool isGridView;

  FolderManager({this.isGridView});

  @override
  _FolderManagerState createState() => _FolderManagerState();
}

class _FolderManagerState extends State<FolderManager> {
  Color themeColor;
  bool isLoading = true;
  bool isGridView;

  ControllerFileManager _fileManager = Get.put(ControllerFileManager());
  ControllerDB _controllerDB = Get.put(ControllerDB());
  FileManager _fileM;
  FileData _fileData;
  List<FileResult> _fileResult;
  String _downloadPath;
  bool morePage = true;
  bool isUpload = false;
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isGridView = widget.isGridView ?? true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _downloadPath = await _objectPath('Download');
      await saveDir(_downloadPath);

      _fileM = await _fileManager.getFilesByUserIdForDirectory(
          _controllerDB.headers(),
          userId: _controllerDB.user.value.data.id,
          directory: _fileManager.getDirectory());
      _fileData = _fileM.data;
      _fileResult = _fileData.result;
      setState(() {
        isLoading = false;
      });
    });
  }

  Future saveDir(String path) async {
    final savedDir = Directory(path);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _findDownloadPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _objectPath(String dir) async =>
      (await _findDownloadPath()) + Platform.pathSeparator + dir;

  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).accentColor;
    return GetBuilder<ControllerFileManager>(builder: (f) {
      if (_fileResult != f.fileResult) {
        _fileResult = f.fileResult;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("File Manager"),
          actions: [
            f.delete.value
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          f.deleteCancel();
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          String res = await f.deleteMultiFileAndDirectory(
                            _controllerDB.headers(),
                            userId: _controllerDB.user.value.data.id,
                            sourceOwnerId: _controllerDB.user.value.data.id,
                            fileIdList: f.fileIdList.length == 1 &&
                                    f.fileIdList.first == 0
                                ? []
                                : f.fileIdList,
                          );
                          if (res == "true") {
                            List<FileResult> deleting = [];
                            _fileResult.forEach((element) {
                              if (f.fileIdList.contains(element.id)) {
                                setState(() {
                                  deleting.add(element);
                                });
                              }
                            });
                            deleting.forEach((element) {
                              setState(() {
                                f.deleteFolder(element);
                                // _fileResult.remove(element);
                              });
                            });
                            f.deleteCancel();

                            //  _fileResult.removeWhere((element) =>f.fileIdList.contains(element.id));
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      InkWell(
                        onTap: () => createShowDiolog(setState),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add, color: Colors.black, size: 32),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Icon(Icons.search, color: Colors.black, size: 32),
                      ),
                    ],
                  ),
          ],
        ),
        //    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final picker = ImagePicker();

            PickedFile image = await picker.getImage(
                source: ImageSource.camera, imageQuality: 50);
            setState(() {
              isLoading = true;
            });

            await _fileManager
                .uploadFiles(_controllerDB.headers(),
                    userId: _controllerDB.user.value.data.id,
                    files: [File(image.path)],
                    directory: _fileManager.getDirectory().isEmpty
                        ? _fileManager.getDirectory()
                        : _fileManager.getDirectory())
                .then((value) {
              updateFiles(result: value);
              setState(() {
                isLoading = false;
              });
            });
          },
          child: Tab(
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),

        body: WillPopScope(
          onWillPop: () async {
            _fileManager.updatePopDirectory();
            return true;
          },
          child: isLoading
              ? MyCircular()
              : Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!isUpload &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            if (morePage) {
                              _loadData();
                            }
                          }
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              buildRowButton(),
                              isGridView ? buildGridView() : buildListView(),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: isUpload ? 60.0 : 0,
                      child: MyCircular(),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: _fileResult.length ?? 0,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      itemBuilder: (context, index) {
        return FileListView(_fileResult[index], _downloadPath, index);
      },
    );
  }

  Widget buildRowButton() {
    return GetBuilder<ControllerFileManager>(builder: (f) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 15,
                  width: Get.width - 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: _fileManager.directory.map((e) {
                      return Text(
                        e,
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isGridView = false;
                        });
                      },
                      child: Icon(
                        Icons.list,
                        color: !isGridView ? themeColor : Colors.grey,
                        size: 32,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isGridView = true;
                        });
                      },
                      child: Icon(
                        Icons.grid_view,
                        color: isGridView ? themeColor : Colors.grey,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider()
          ],
        ),
      );
    });
  }

  GridView buildGridView() {
    return GridView.builder(
      itemCount: _fileResult.length ?? 0,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      itemBuilder: (context, index) {
        return FileGridList(_fileResult[index], _downloadPath, index);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0, crossAxisSpacing: 10, crossAxisCount: 2),
    );
  }

  createShowDiolog(StateSetter mainSetState) {
    bool addFolder = false;
    final _formKey = GlobalKey<FormState>();

    String newName;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Directory or File"),
              actions: [
                addFolder
                    ? FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await _fileManager.createDirectory(
                                _controllerDB.headers(),
                                userId: _controllerDB.user.value.data.id,
                                ownerId: _controllerDB.user.value.data.id,
                                directoryName:
                                    _fileManager.getDirectory().isEmpty
                                        ? newName
                                        : _fileManager.getDirectory() +
                                            "/" +
                                            newName);
                            updateFiles(isDirecoty: true, folderName: newName);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Save Folder",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      )
                    : Container(),
                FlatButton(
                  onPressed: () {
                    if (!addFolder) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        addFolder = true;
                      });
                    }
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                )
              ],
              content: addFolder
                  ? Form(
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
                    )
                  : Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            setState(() {
                              addFolder = true;
                            });
                          },
                          title: Text("Create New Folder"),
                          trailing: Icon(Icons.create_new_folder),
                        ),
                        Divider(),
                        ListTile(
                          onTap: () async {
                            FilePickerResult result = await FilePicker.platform
                                .pickFiles(
                                    allowMultiple: true);

                            if (result != null) {
                              List<File> files = result.paths
                                  .map((path) => File(path))
                                  .toList();

                              Navigator.pop(context);
                              mainSetState(() {
                                isLoading = true;
                              });

                              await _fileManager
                                  .uploadFiles(_controllerDB.headers(),
                                      userId: _controllerDB.user.value.data.id,
                                      files: files,
                                      directory:
                                          _fileManager.getDirectory().isEmpty
                                              ? _fileManager.getDirectory()
                                              : _fileManager.getDirectory())
                                  .then((value) {
                                updateFiles(result: value);
                                mainSetState(() {
                                  isLoading = false;
                                });
                              });
                            }
                          },
                          title: Text("Upload File"),
                          trailing: Icon(Icons.upload_file),
                        ),
                      ],
                    ),
            );
          });
        });
  }

  void updateFiles(
      {bool isDirecoty: false, String folderName, List<FileResult> result}) {
    if (isDirecoty) {
      DateTime time = DateTime.now();
      String month =
          time.month < 10 ? "0" + time.month.toString() : time.month.toString();
      String day =
          time.day < 10 ? "0" + time.day.toString() : time.day.toString();
      setState(() {
        _fileResult.insert(
            0,
            FileResult(
                folderName: folderName,
                createDate:
                    time.year.toString() + "-" + month + "-" + day + "---"));
      });
    } else {
      setState(() {
        _fileResult.addAll(result);
        isLoading = false;
      });
    }
  }

  Future _loadData() async {
    setState(() {
      page++;
      isUpload = true;
    });
    _fileManager
        .getFilesByUserIdForDirectory(_controllerDB.headers(),
            page: page,
            userId: _controllerDB.user.value.data.id,
            directory: _fileManager.getDirectory())
        .then((value) {
      setState(() {
        if (value.data.result.length == 0) {
          morePage = false;
        } else {
          _fileM = value;
          _fileData = _fileM.data;
          _fileResult.addAll(_fileM.data.result);
        }
        isUpload = false;
      });
    });
  }
}
