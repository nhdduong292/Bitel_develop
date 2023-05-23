import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'contract_uploading_logic.dart';

class ContractUploadingPage extends GetView<ContractUploadingLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: ContractUploadingLogic(context: context),
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
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
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
                            Text('Contract Uploading', style: AppStyles.title),
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
                          color: const Color.fromRGBO(185, 212, 220, 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('1.Main contract'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                  flex: 2,
                                  child: bottomButton(
                                      text: AppLocalizations.of(context)!
                                          .textCamera,
                                      onTap: () {
                                        controller.getFromGallery(
                                            context, true);
                                      })),
                              Expanded(
                                  flex: 2,
                                  child: bottomButton(
                                      text: AppLocalizations.of(context)!
                                          .textGallery,
                                      onTap: () {
                                        controller.uploadImage(context, true);
                                      })),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                          Visibility(
                            visible: controller.listFileMainContract.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 120,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.listFileMainContract.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                          width: 100,
                                          height: 120,
                                          child: Image.file(
                                            File(controller
                                                .listFileMainContract[index]
                                                .path),
                                          ));
                                    }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
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
                          color: const Color.fromRGBO(185, 212, 220, 0.2),
                          offset: Offset(0, 2),
                          blurRadius: 7.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('1.Main contract'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                  flex: 2,
                                  child: bottomButton(
                                      text: AppLocalizations.of(context)!
                                          .textCamera,
                                      onTap: () {
                                        controller.getFromGallery(
                                            context, false);
                                      })),
                              Expanded(
                                  flex: 2,
                                  child: bottomButton(
                                      text: AppLocalizations.of(context)!
                                          .textGallery,
                                      onTap: () {
                                        controller.uploadImage(context, false);
                                      })),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                          Visibility(
                            visible:
                                controller.listFileLendingContract.isNotEmpty,
                            child: SizedBox(
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller
                                        .listFileLendingContract.length,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                          width: 100,
                                          height: 120,
                                          child: Image.file(
                                            File(controller
                                                .listFileLendingContract[index]
                                                .path),
                                          ));
                                    }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                        controller.createPDF(true);
                        controller.createPDF(false);
                        controller.savePDF(true);
                        controller.savePDF(false);
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
