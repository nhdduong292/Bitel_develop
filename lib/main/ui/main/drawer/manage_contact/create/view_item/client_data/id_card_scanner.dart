import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Img;

import 'id_card_scanner_logic.dart';

class IDCardScanner extends GetView<IdCardScannerLogic> {
  final List<CameraDescription> cameras = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: IdCardScannerLogic(cameras: cameras, context: context),
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xFF0b0b0b).withAlpha(80),
            body: Builder(builder: (context) {
              return Stack(children: [
                FutureBuilder<void>(
                  future: controller.cameraController.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(controller.cameraController);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Center(
                  child: Container(
                    width: 380,
                    height: 230,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: const Color(0xFF0DD4D5)),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: FloatingActionButton(
                    onPressed: () {
                      controller.onTakePictureButtonPressed().then(
                        (value) {
                          Get.back(result: controller.imageFile.path);
                        },
                      );
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 50,
                  child: FloatingActionButton(
                    onPressed: () {
                      controller.uploadImage();
                    },
                    tooltip: 'Pick Image',
                    child: Icon(Icons.add_a_photo),
                  ),
                ),
              ]);
            }),
          );
        });
  }
}

class PreviewScreen extends StatelessWidget {
  final String imagePath;

  const PreviewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('bxloc ok');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Container(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
