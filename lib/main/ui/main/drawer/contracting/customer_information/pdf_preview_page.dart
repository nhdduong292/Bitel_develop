import 'dart:async';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/pdf_preview_logic.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PDFPreviewPage extends GetView<PDFPreviewLogic> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  var pages = 0.obs;
  var currentPage = 0.obs;
  var isReady = false.obs;
  var errorMessage = ''.obs;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: PDFPreviewLogic(context: context),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FBFB),
                        ),
                        width: width,
                        height: 147,
                      ),
                      SvgPicture.asset(
                        AppImages.bgAppbar,
                        width: width,
                      ),
                      Positioned(
                          top: 45,
                          left: 20,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13)),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 15,
                                  color: AppColors.colorTitle,
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                        top: 50,
                        left: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                controller.type == 'MAIN'
                                    ? AppLocalizations.of(context)!
                                        .textMainContract
                                    : AppLocalizations.of(context)!
                                        .textLendingContract,
                                style: AppStyles.title),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFFE3EAF2),
                        width: 1.0,
                      ),
                      boxShadow: [
                         const BoxShadow(
                          color: Color.fromRGBO(185, 212, 220, 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 52,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.textContractPreview,
                            style: AppStyles.r00A5B1_15d5_500,
                          ),
                        ),
                      ),
                      const DottedLine(
                        dashColor: Color(0xFFE3EAF2),
                        dashGapLength: 3,
                        dashLength: 4,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Obx(
                        () => SizedBox(
                          width: width - 100,
                          height: (width - 100) * 1.2,
                          child: (controller.loadSuccess.value &&
                                  controller.bytesPDF != null)
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
                              : LoadingCirculApi(),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      )
                    ]),
                  ),
                  Container(
                    width: width - 62,
                    margin: const EdgeInsets.only(left: 31, right: 31),
                    child: bottomButton(
                      text: AppLocalizations.of(context)!
                          .textContinue
                          .toUpperCase(),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
