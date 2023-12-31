import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/pdf_preview_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_information/contract_information.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_preview/contract_preview.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/additional_information/additional_information.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_uploading/contract_uploading_page.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../router/route_config.dart';

class CustommerInformationPage extends GetView<CustomerInformationLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: CustomerInformationLogic(context: context),
        builder: (controller) {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
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
                            Obx(() => Text(controller.titleScreen.value,
                                style: AppStyles.title)),
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
                              if (controller
                                      .itemPositionsListener.itemPositions.value
                                      .elementAt(0)
                                      .index ==
                                  1) {
                                controller.checkItem1.value = true;
                                controller.checkItem2.value = false;
                                controller.titleScreen.value =
                                    AppLocalizations.of(context)!
                                        .textCustomerInformation;
                                controller.scrollController.scrollTo(
                                  index: 0,
                                  duration: const Duration(milliseconds: 200),
                                );
                                return;
                              } else if (controller
                                      .itemPositionsListener.itemPositions.value
                                      .elementAt(0)
                                      .index ==
                                  2) {
                                controller.checkItem2.value = true;
                                controller.checkItem3.value = false;
                                controller.scrollController.scrollTo(
                                  index: 1,
                                  duration: const Duration(milliseconds: 200),
                                );
                                return;
                              }
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
                                circleMarkerView(
                                    check: controller.checkItem1, text: '1'),
                                const SizedBox(
                                  width: 22,
                                ),
                                circleMarkerView(
                                    check: controller.checkItem2, text: '2'),
                                const SizedBox(
                                  width: 22,
                                ),
                                circleMarkerView(
                                    check: controller.checkItem3, text: '3'),
                              ],
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Expanded(
                    child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemScrollController: controller.scrollController,
                        itemPositionsListener: controller.itemPositionsListener,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return AdditionalInformationWidget(
                              controller: controller,
                              callback: () {
                                controller.checkItem1.value = false;
                                controller.checkItem2.value = true;
                                controller.titleScreen.value =
                                    AppLocalizations.of(context)!
                                        .textRequestToContracting;
                                controller.scrollController.scrollTo(
                                  index: 1,
                                  duration: const Duration(milliseconds: 200),
                                );
                                controller.getCurrentTime();
                                if (controller.statusContract ==
                                    ContractStatus.Change_plan) {
                                  controller.getContractInfor();
                                }
                              },
                            );
                          } else if (index == 1) {
                            return ContractInformationWidget(
                              controller: controller,
                              callback: () {
                                controller.checkItem2.value = false;
                                controller.checkItem3.value = true;
                                controller.scrollController.scrollTo(
                                  index: 2,
                                  duration: const Duration(milliseconds: 200),
                                );
                              },
                            );
                          } else {
                            if (controller.valueCheckBypass &&
                                controller.showBypass()) {
                              return ContractUploadingPage();
                            } else {
                              return ContractPreviewWidget(
                                callback: (value) {
                                  Get.toNamed(RouteConfig.validateFingerprint,
                                      arguments: [
                                        value,
                                        controller.customer.custId,
                                        controller.getTypeCustomer(),
                                        controller.customer.idNumber,
                                        controller.contract.contractId
                                      ])?.then((value) {
                                    if (value != null && value) {
                                      controller.checkMainContract.value =
                                          false;
                                      controller.checkLendingContract.value =
                                          true;
                                    }
                                  });
                                },
                              );
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
