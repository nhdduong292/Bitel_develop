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

class PDFPreviewLogic extends GetxController {
  var path = '';
  Uint8List? bytesPDF;
  var loadSuccess = false.obs;
  var type = '';
  int contractId = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.arguments;
    type = data[0];
    contractId = data[1];
    getPDF().then((value) {
      bytesPDF = value;
      loadSuccess.value = true;
    });
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

  Future<Uint8List> getPDF() async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<Uint8List> completer = Completer();
    try {
      ApiUtil.getInstance()!.getPDF(
        url: ApiEndPoints.API_CONTRACT_PREVIEW
            .replaceAll("id", contractId.toString()),
        params: {"type": type},
        onSuccess: (response) async {
          completer.complete(response.data);
        },
        onError: (error) {},
      );
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}

class PDFScreen extends GetView<PDFPreviewLogic> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  var pages = 0.obs;
  var currentPage = 0.obs;
  var isReady = false.obs;
  var errorMessage = ''.obs;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: PDFPreviewLogic(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Document"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Obx(
                      () => SizedBox(
                        width: width,
                        height: width * 1.1625,
                        child: (controller.loadSuccess.value)
                            ? PDFView(
                                // filePath: controller.path,
                                pdfData: controller.bytesPDF,
                                enableSwipe: true,
                                swipeHorizontal: true,
                                autoSpacing: false,
                                pageFling: true,
                                pageSnap: true,
                                defaultPage: currentPage.value,
                                fitPolicy: FitPolicy.BOTH,
                                preventLinkNavigation:
                                    false, // if set to true the link is handled in flutter
                                onRender: (_pages) {
                                  if (_pages != null) {
                                    pages.value = _pages;
                                    isReady.value = true;
                                  }
                                },
                                onError: (error) {
                                  errorMessage.value = error.toString();

                                  print(error.toString());
                                },
                                onPageError: (page, error) {
                                  errorMessage.value =
                                      '$page: ${error.toString()}';

                                  print('$page: ${error.toString()}');
                                },
                                onViewCreated:
                                    (PDFViewController pdfViewController) {
                                  _controller.complete(pdfViewController);
                                },
                                onLinkHandler: (String? uri) {
                                  print('goto uri: $uri');
                                },
                                onPageChanged: (int? page, int? total) {
                                  print('page change: $page/$total');
                                  if (page != null) {
                                    currentPage.value = page;
                                  }
                                },
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
                // errorMessage.isEmpty
                //     ? !isReady.value
                //         ? Center(
                //             child: CircularProgressIndicator(),
                //           )
                //         : Container()
                //     : Center(
                //         child: Text(errorMessage.value),
                //       )
              ],
            ),
          );
        });
  }
}
