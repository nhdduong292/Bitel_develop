import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/pdf_preview_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_information/contract_information.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_preview/contract_preview.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/additional_information/additional_information.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_uploading/contract_uploading_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/resign_contract/resign_contract_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../router/route_config.dart';
import '../customer_information/pdf_preview_page.dart';

class ReSignContractPage extends GetView {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: ReSignContractLogic(context: context),
        builder: (controller) {
          return Scaffold(
            body: Column(
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
                      top: 50,
                      left: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .textRequestToContracting,
                              style: AppStyles.title),
                          const SizedBox(height: 5),
                        ],
                      ),
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
                        top: 111,
                        width: width,
                        height: 36,
                        child: SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              circleMarkerView(check: false.obs, text: '1'),
                              const SizedBox(
                                width: 22,
                              ),
                              circleMarkerView(check: false.obs, text: '2'),
                              const SizedBox(
                                width: 22,
                              ),
                              circleMarkerView(check: true.obs, text: '3'),
                            ],
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                    AppLocalizations.of(context)!
                                        .textContractPreview,
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
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .textMainContract,
                                          style: controller
                                                  .checkMainContract.value
                                              ? AppStyles.rU9454C9_12_500
                                              : AppStyles.rU9454C9_12_500
                                                  .copyWith(
                                                      color: const Color(
                                                              0xFF415263)
                                                          .withOpacity(0.2)),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .textLendingContract,
                                            style: controller
                                                    .checkLendingContract.value
                                                ? AppStyles.rU9454C9_12_500
                                                : AppStyles.rU9454C9_12_500
                                                    .copyWith(
                                                        color: const Color(
                                                                0xFF415263)
                                                            .withOpacity(0.2))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (controller.checkMainContract.value) {
                                    Get.to(PDFPreviewPage(), arguments: [
                                      'MAIN',
                                      controller.requestDetailLogic.requestModel
                                          .contractModel.contractId
                                    ]);
                                  } else {
                                    Get.to(PDFPreviewPage(), arguments: [
                                      'LENDING',
                                      controller.requestDetailLogic.requestModel
                                          .contractModel.contractId
                                    ]);
                                  }
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
                              const SizedBox(
                                height: 24,
                              )
                            ]),
                          ),
                          Container(
                            width: width - 62,
                            margin: const EdgeInsets.only(left: 31, right: 31),
                            child: Obx(
                              () => bottomButton(
                                  text: AppLocalizations.of(context)!
                                      .textSignContract
                                      .toUpperCase(),
                                  onTap: () {
                                    Get.toNamed(RouteConfig.validateFingerprint,
                                        arguments: [
                                          controller.checkOption.value
                                              ? 'MAIN'
                                              : 'LENDING',
                                          controller
                                              .requestDetailLogic
                                              .requestModel
                                              .customerModel
                                              .custId,
                                          controller.requestDetailLogic
                                              .requestModel.customerModel.type,
                                          controller
                                              .requestDetailLogic
                                              .requestModel
                                              .customerModel
                                              .idNumber,
                                          controller
                                              .requestDetailLogic
                                              .requestModel
                                              .contractModel
                                              .contractId
                                        ])?.then((value) {
                                      if (value != null && value) {
                                        controller.checkMainContract.value =
                                            false;
                                        controller.checkLendingContract.value =
                                            true;
                                      }
                                    });
                                  },
                                  color: !(controller.checkOption.value)
                                      ? const Color(0xFF415263).withOpacity(0.2)
                                      : null),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
