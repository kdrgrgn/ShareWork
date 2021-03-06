import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobi/Controller/ControllerDB.dart';
import 'package:mobi/Controller/ControllerOffice.dart';
import 'package:mobi/widgets/MyCircularProgress.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../landingPage.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  ControllerOffice _controllerOffice = Get.put(ControllerOffice());
  ControllerDB _controllerDB = Get.put(ControllerDB());

  bool isLoading = false;
  List<File> files = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (_controllerOffice.files != null) {
          files = _controllerOffice.files;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? MyCircular()
        : Scaffold(
            floatingActionButton: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _controllerOffice.editOfficeService(
                          _controllerDB.headers(),
                          cityId: _controllerOffice.idCity.value,
                          description: _controllerOffice.description.value,
                          countryId: _controllerOffice.idCountry.value,
                          serviceId: _controllerOffice.idService.value,
                          disrtictId: _controllerOffice.idDistrict.value
                        );

                        if(files.length!=0){
                          await _controllerOffice.insertOfficeImages(_controllerDB.headers(),files: files);
                        }
                        _controllerDB.updateUser();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LandingPage()));
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        onPressed: () {
                          _controllerOffice.initialPage--;
                          _controllerOffice.update();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "Daha onceden yapmis oldugunuz projelerin resimlerini yukleyebilirsiniz"),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        shrinkWrap: true,
                        controller: ScrollController(keepScrollOffset: true),
                        children: imageBuild(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  List<Widget> imageBuild() {
    List<Widget> images;

    images = [
      InkWell(
        onTap: () async {
          Permission.camera.request();
          FilePickerResult result = await FilePicker.platform
              .pickFiles(allowMultiple: true, type: FileType.image);

          if (result != null) {
            setState(() {
              files.addAll(result.paths.map((path) => File(path)).toList());
              _controllerOffice.files = files.obs;
              _controllerOffice.update();
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.transparent,
            border: Border.all(),
          ),
          child: Center(
              child: Icon(
            Icons.add_circle_outline,
            size: 45,
          )),
        ),
      )
    ];

    for (File e in files) {
      int index = files.indexOf(e);

      images.add(buildfile(index));
    }

    return images;
  }

  Widget buildfile(int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.transparent,
            border: Border.all(),
          ),
          width: 30,
          height: 50,
          child: Image.file(
            files[index],
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              setState(() {
                files.removeAt(index);
                _controllerOffice.files = files.obs;
                _controllerOffice.update();
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.remove_circle_outline,
                  size: 26,
                )),
          ),
        )
      ],
    );
  }
}
