import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    controller = CameraController(cameras[0], ResolutionPreset.ultraHigh,enableAudio: false);

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
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height-100,

            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,30,10,30),
              child: CameraPreview(controller),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.close,size: 45,),
              Icon(Icons.camera,size: 45,),
              Container(width: 45 ,),

            ],
          ),

        ],
      ),
    );
  }
}
