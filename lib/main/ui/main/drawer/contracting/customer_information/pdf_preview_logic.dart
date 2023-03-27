import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../utils/common_widgets.dart';

class PDFPreviewLogic extends GetxController {
  BuildContext context;
  var path = '';
  Uint8List? bytesPDF;
  var loadSuccess = false.obs;
  var type = '';
  int contractId = 0;

  PDFPreviewLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.arguments;
    type = data[0];
    contractId = data[1];
    getPDF();
  }

  Future<Uint8List> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<Uint8List> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(bytes);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  getPDF() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"

    try {
      ApiUtil.getInstance()!.getPDF(
        url: ApiEndPoints.API_CONTRACT_PREVIEW
            .replaceAll("id", contractId.toString()),
        params: {"type": type},
        onSuccess: (response) async {
          bytesPDF = response.data;
          loadSuccess.value = true;
        },
        onError: (error) {
          loadSuccess.value = true;
        },
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }
}