import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../utils/common.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ContractUploadingLogic extends GetxController {
  BuildContext context;
  ContractUploadingLogic({required this.context});
  List<File> listFileMainContract = [];
  List<File> listFileLendingContract = [];
  File? pdfMainContract;
  File? pdfLendingContract;
  final pdf = pw.Document();
  var loadSuccess = false.obs;
  bool isCamera = true;

  uploadImage(BuildContext context, bool isMain) async {
    isCamera = false;
    if (isMain) {
      listFileMainContract.clear();
    } else {
      listFileLendingContract.clear();
    }
    try {
      final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
      if (selectedImages.isNotEmpty) {
        for (var image in selectedImages) {
          if (isMain) {
            listFileMainContract.add(File(image.path));
          } else {
            listFileLendingContract.add(File(image.path));
          }
        }
        update();
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      Common.showToastCenter(e.toString());
    }
  }

  getFromGallery(BuildContext context, bool isMain) async {
    if (!isCamera) {
      if (isMain) {
        listFileMainContract.clear();
      } else {
        listFileLendingContract.clear();
      }
    }
    isCamera = true;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (isMain) {
      listFileMainContract.add(File(pickedFile!.path));
    } else {
      listFileLendingContract.add(File(pickedFile!.path));
    }
    update();
  }

  createPDF(bool isMain) async {
    List<File> list = [];
    if (isMain) {
      list = listFileMainContract;
    } else {
      list = listFileLendingContract;
    }
    for (var img in list) {
      final image = pw.MemoryImage(img.readAsBytesSync());
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Center(child: pw.Image(image));
          }));
    }
  }

  savePDF(bool isMain) async {
    try {
      final dir = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationSupportDirectory(); //FOR iOS
      if (isMain) {
        final file = File('${dir?.path}/main_contract.pdf');
        await file.writeAsBytes(await pdf.save());
        pdfMainContract = file;
      } else {
        final file = File('${dir?.path}/lending_contract.pdf');
        await file.writeAsBytes(await pdf.save());
        pdfLendingContract = file;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
