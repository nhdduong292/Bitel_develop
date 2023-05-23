import 'dart:async';
import 'dart:io';

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../../res/app_images.dart';
import '../../../../../../../../res/app_styles.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'contract_uploading_logic.dart';

class ContractUploadingPage extends GetView<CustomerInformationLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: CustomerInformationLogic(context: context),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width - 40,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(26),
                            dashPattern: const [2, 2],
                            strokeWidth: 1,
                            color: const Color(0xFF9454C9),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  AppLocalizations.of(context)!
                                      .textScanOrUploadImagesForMainContract,
                                  style: AppStyles.r9454C9_14_500.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                                flex: 2,
                                child: bottomButtonV2(
                                    text:
                                        AppLocalizations.of(context)!.textScan,
                                    onTap: () {
                                      controller.getFromGallery(context, true);
                                    })),
                            Expanded(
                                flex: 2,
                                child: bottomButton(
                                    text: AppLocalizations.of(context)!
                                        .textUpload,
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
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width - 40,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(26),
                            dashPattern: const [2, 2],
                            strokeWidth: 1,
                            color: const Color(0xFF9454C9),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  AppLocalizations.of(context)!
                                      .textScanOrUploadImagesForLendingContract,
                                  style: AppStyles.r9454C9_14_500.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                                flex: 2,
                                child: bottomButtonV2(
                                    text:
                                        AppLocalizations.of(context)!.textScan,
                                    onTap: () {
                                      controller.getFromGallery(context, false);
                                    })),
                            Expanded(
                                flex: 2,
                                child: bottomButton(
                                    text: AppLocalizations.of(context)!
                                        .textUpload,
                                    onTap: () {
                                      controller.uploadImage(context, false);
                                    })),
                            const Expanded(flex: 1, child: SizedBox()),
                          ],
                        ),
                        Visibility(
                          visible:
                              controller.listFileLendingContract.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 120,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.listFileLendingContract.length,
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
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          activeColor: AppColors.colorText3,
                          value: controller.valueCheckBox,
                          onChanged: (value) {
                            controller.valueCheckBox = value ?? false;
                            controller.update();
                          }),
                      Text(
                        '${AppLocalizations.of(context)!.textUploadContractLater}.',
                        style: AppStyles.r2B3A4A_12_500.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  width: width - 62,
                  margin: const EdgeInsets.only(left: 31, right: 31),
                  child: bottomButton(
                    color: controller.listFileMainContract.isEmpty ||
                            controller.listFileLendingContract.isEmpty
                        ? const Color(0xFF415263).withOpacity(0.2)
                        : null,
                    text: AppLocalizations.of(context)!
                        .textContinue
                        .toUpperCase(),
                    onTap: () {
                      if (controller.listFileMainContract.isEmpty ||
                          controller.listFileLendingContract.isEmpty) {
                        return;
                      }
                      controller.createPDF(true);
                      controller.savePDF(true, (isSuccessMain) {
                        if (isSuccessMain) {
                          controller.createPDF(false);
                          controller.savePDF(false, (isSuccessLending) {
                            if (isSuccessLending) {
                              controller.createPDF(true);
                              controller.savePDF(false, (isSuccess) {
                                if (isSuccess) {
                                  if (!controller.valueCheckBox) {
                                    controller.uploadContract((isSuccess) {
                                      if (isSuccess) {
                                        controller.signContract(
                                            (p0) => {
                                                  if (p0)
                                                    {
                                                      controller.signContract(
                                                          (p1) => {
                                                                Get.toNamed(
                                                                    RouteConfig
                                                                        .ftthContracting,
                                                                    arguments: [
                                                                      controller
                                                                          .contract
                                                                          .contractId,
                                                                    ])
                                                              },
                                                          'LENDING')
                                                    }
                                                },
                                            'MAIN');
                                      }
                                    });
                                  } else {
                                    controller.signContract(
                                        (p0) => {
                                              if (p0)
                                                {
                                                  controller.signContract(
                                                      (p1) => {
                                                            Get.toNamed(
                                                                RouteConfig
                                                                    .ftthContracting,
                                                                arguments: [
                                                                  controller
                                                                      .contract
                                                                      .contractId,
                                                                ])
                                                          },
                                                      'LENDING')
                                                }
                                            },
                                        'MAIN');
                                  }
                                }
                              });
                            }
                          });
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
