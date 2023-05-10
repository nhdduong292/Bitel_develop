// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../res/app_colors.dart';
import '../../../../../../router/route_config.dart';
import '../../../../../../utils/common.dart';
import '../../../contracting/customer_information/pdf_preview_page.dart';
import 'cancel_service_pdf_logic.dart';

class CancelServicePDFPage extends GetView<CancelServicePDFLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: CancelServicePDFLogic(context: context),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      width: width,
                    ),
                    SvgPicture.asset(
                      AppImages.bgAppbar,
                      width: width,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      top: 50,
                      left: 70,
                      child: Text(
                          AppLocalizations.of(context)!
                              .textCancellationRequestForm,
                          style: AppStyles.title),
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
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
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
                                height: 18,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Get.to(PDFPreviewPage(),
                                      arguments: ['', controller.orderId]);
                                },
                                child: Image.asset(
                                  AppImages.imgDemoContract,
                                  width: 320,
                                  height: 372,
                                ),
                              ),
                              customRadioMutiple(
                                  width: width,
                                  text: AppLocalizations.of(context)!
                                      .textIConfirmThat,
                                  check: controller.checkOption,
                                  changeValue: (value) {
                                    controller.checkOption.value = value;
                                  }),
                              SizedBox(
                                height: 24,
                              )
                            ]),
                          ),
                          Container(
                            width: width - 62,
                            margin: EdgeInsets.only(left: 31, right: 31),
                            child: Obx(
                              () => bottomButton(
                                  text: AppLocalizations.of(context)!
                                      .textSignContract
                                      .toUpperCase(),
                                  onTap: () {
                                    Get.toNamed(RouteConfig.validateFingerprint,
                                        arguments: [
                                          '',
                                          controller.findAccountModel.custId,
                                          Common.getIdentityType(controller
                                              .findAccountModel.idType),
                                          controller.findAccountModel.idNumber,
                                          controller.orderId
                                        ]);
                                  },
                                  color: !(controller.checkOption.value)
                                      ? const Color(0xFF415263).withOpacity(0.2)
                                      : null),
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }
}
