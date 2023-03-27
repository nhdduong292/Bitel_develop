import 'package:bitel_ventas/main/ui/main/drawer/contracting/register_finger_print/register_finger_print_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/cretate_contact_page_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data/client_data.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data_dni/client_data_dni_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/client_data_dni/client_data_dni.dart';
import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/document_scanning.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../utils/common.dart';
import '../../contracting/register_finger_print/register_finger_print_page.dart';
import '../../utilitis/info_bussiness.dart';

class CreateContactPage extends GetView<CreateContactPageLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: CreateContactPageLogic(),
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
                            Text(
                                AppLocalizations.of(context)!
                                    .textEscanoDeDocumento,
                                style: AppStyles.title),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.icTimeBar),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(Common.getStringTimeToday(),
                                    style: AppStyles.b1),
                                const SizedBox(
                                  width: 20,
                                ),
                                SvgPicture.asset(AppImages.icAccountBar),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(InfoBusiness.getInstance()!.getUser().sub,
                                    style: AppStyles.b1)
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 50,
                          left: 20,
                          child: InkWell(
                            onTap: () {
                              if (controller
                                      .itemPositionsListener.itemPositions.value
                                      .elementAt(0)
                                      .index ==
                                  1) {
                                controller.checkItem2.value = false;
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
                                circleMarkerView(check: true.obs, text: '1'),
                                const SizedBox(
                                  width: 16,
                                ),
                                circleMarkerView(
                                    check: controller.checkItem2, text: '2'),
                                const SizedBox(
                                  width: 16,
                                ),
                                Visibility(
                                  visible: controller.typeCustomer != 'DNI',
                                  child: Row(
                                    children: [
                                      circleMarkerView(
                                          check: controller.checkItem3,
                                          text: '3'),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                )
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
                        itemCount: 4,
                        itemScrollController: controller.scrollController,
                        itemPositionsListener: controller.itemPositionsListener,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return DocumentScanningWidget(
                              callback: () {
                                controller.checkItem2.value = true;
                                controller.scrollController.scrollTo(
                                  index: 1,
                                  duration: const Duration(milliseconds: 200),
                                );

                                ClientDataDNILogic clientDataDNILogic =
                                    Get.find();
                                clientDataDNILogic.setCustomerDNIModel();
                              },
                            );
                          } else if (index == 1) {
                            return ClientDataDNIWidget(
                              callback: () {
                                controller.checkItem3.value = true;
                                controller.scrollController.scrollTo(
                                  index: 2,
                                  duration: const Duration(milliseconds: 200),
                                );

                                RegisterFingerPrintLogic registerFingerLogic =
                                    Get.find();
                                registerFingerLogic.setupBodyCreateCustomer();
                              },
                            );
                            // if (controller.typeCustomer == 'DNI') {
                            //   return ClientDataDNIWidget(
                            //     callback: () {
                            //       controller.checkItem3.value = true;
                            //       _scrollController.scrollTo(
                            //         index: 2,
                            //         duration: const Duration(milliseconds: 200),
                            //       );
                            //     },
                            //   );
                            // } else {
                            //   return ClientDataWidget(
                            //     callback: () {
                            //       controller.checkItem3.value = true;
                            //       _scrollController.scrollTo(
                            //         index: 2,
                            //         duration: const Duration(milliseconds: 200),
                            //       );
                            //       RegisterFingerPrintLogic registerFingerLogic =
                            //           Get.find();
                            // registerFingerLogic.setupBodyCreateCustomer();
                            //     },
                            //   );
                            // }
                          } else {
                            return RegisterFingerPrintPage(
                                // callback: () {
                                //   _scrollController.scrollTo(
                                //     index: 3,
                                //     duration: const Duration(milliseconds: 200),
                                //   );
                                // },
                                );
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
