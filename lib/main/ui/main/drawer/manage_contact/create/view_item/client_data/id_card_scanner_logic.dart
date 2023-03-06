import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class IdCardScannerLogic extends GetxController {
  late BuildContext context;
  late XFile imageFile;
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  IdCardScannerLogic({required this.cameras, required this.context});
  CroppedFile? _croppedFile;
  XFile? _pickedFile;

  @override
  void onInit() {
    super.onInit();
    startCamera();
  }

  void startCamera() async {
    // cameras = await availableCameras();
    cameraController =
        CameraController(cameras[0], ResolutionPreset.max, enableAudio: false);
    await cameraController.initialize();
    update();
  }

  Future<XFile> takePicture() async {
    final XFile file = await cameraController.takePicture();
    return file;
  }

  Future<void> onTakePictureButtonPressed() async {
    await takePicture().then((XFile? file) {
      Img.Image? image = Img.decodeImage(File(file!.path).readAsBytesSync());
      // imageFile = file;
      // final Size screenSize = MediaQuery.of(context).size;

      // Tính kích thước của vùng cắt
      // final double cropSize = screenSize.width * 0.8;
      // final int size = cropSize.toInt();
      int size = 1900;
      int x =
          (image!.width - 1900) ~/ 2; // Tọa độ x của góc trái trên của vùng cắt
      int y =
          (image.height - 1150) ~/ 2; // Tọa độ y của góc trái trên của vùng cắt
      int width = 1900; // Chiều rộng của vùng cắt
      int height = 1150; // Chiều cao của vùng cắt
      Img.Image cropImage = Img.copyCrop(image, x, y, width, height);
      File(file.path).writeAsBytesSync(Img.encodeJpg(cropImage));
      imageFile = file;
      if (file != null) {
        // showInSnackBar('Picture saved to ${file.path}');
      }
    });
  }

  Future<void> cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        _croppedFile = croppedFile;
        Get.back(result: croppedFile.path);
      }
    }
  }

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedFile = pickedFile;
      cropImage();
    }
  }
}
