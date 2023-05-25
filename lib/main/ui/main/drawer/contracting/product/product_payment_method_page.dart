import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/method_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/receipt_information_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';
import '../../../../../router/route_config.dart';
import '../../../../../utils/common_widgets.dart';
import '../../request/list_request/list_request_logic.dart';
import 'invoice_page.dart';

class ProductPaymentMethodPage extends GetView<ProductPaymentMethodLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ProductPaymentMethodLogic(context: context),
        builder: (controller) {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
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
                            Obx(
                              () => Text(
                                  controller.isOnMethodPage.value
                                      ? AppLocalizations.of(context)!
                                          .textProductPaymentMethod
                                      : controller.status == 'CREATE'
                                          ? AppLocalizations.of(context)!
                                              .textInvoiceInfo
                                          : 'Receipt information',
                                  style: AppStyles.title),
                            ),
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
                              if (controller.isLoadingProduct ||
                                  controller.isLoadingPackage) {
                                Get.back();
                                return;
                              }
                              if (controller.itemPositionsListener
                                      ?.itemPositions.value
                                      .elementAt(0)
                                      .index ==
                                  0) {
                                Get.back();
                                bool isExit =
                                    Get.isRegistered<ListRequestLogic>();
                                if (isExit) {
                                  ListRequestLogic listRequestLogic =
                                      Get.find();
                                  listRequestLogic
                                      .updateSearchRequestToIndex(2);
                                  listRequestLogic.refreshListRequest();
                                }
                              } else {
                                controller.isOnInvoicePage.value = false;
                                controller.isOnMethodPage.value = true;
                                controller.scrollController?.scrollTo(
                                  index: 0,
                                  duration: const Duration(milliseconds: 200),
                                );
                              }
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
                      // Positioned(
                      //     top: 50,
                      //     right: 15,
                      //     child: InkWell(
                      //       highlightColor: Colors.transparent,
                      //       splashColor: Colors.transparent,
                      //       onTap: () {},
                      //       child: SvgPicture.asset(AppImages.icNotify),
                      //     )),
                      Positioned(
                          top: 111,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SizedBox(
                              width: 120,
                              height: 36,
                              child: Row(
                                children: [
                                  circleMarkerView(
                                      check: controller.isOnMethodPage,
                                      text: '1'),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                  circleMarkerView(
                                      check: controller.isOnInvoicePage,
                                      text: '2'),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (controller.isLoadingProduct || controller.isLoadingPackage)
                      ? LoadingCirculApi()
                      : Expanded(
                          child: ScrollablePositionedList.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemScrollController: controller.scrollController,
                              itemPositionsListener:
                                  controller.itemPositionsListener,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return MethodPage(controller: controller);
                                } else {
                                  if (controller.status == 'CREATE') {
                                    return InvoicePage(controller: controller);
                                  } else {
                                    return ReceiptInformationPage(
                                        controller: controller);
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
