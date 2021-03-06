import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh,
        enableAudio: false);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context,images);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Fotograf cek"),),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Stack(
                  children: [
                    CameraPreview(controller),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                          onTap: () async {
                            final path = join(
                              (await getTemporaryDirectory())
                                  .path, //Temporary path
                              'camera${DateTime.now()}.png',
                            );

                            await controller.takePicture(path);
                            setState(() {
                              images.add(File(path));
                            });
                          },
                          child: Icon(
                            Icons.camera,
                            size: 45,
                          )),
                    ),
                    Container(
                      width: 45,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                          width: 50,
                          child: Image.file(images[index],fit: BoxFit.cover,)),
                    ); //categoryItem(index);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
