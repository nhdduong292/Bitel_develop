import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/clear_debt_detail/clear_debt_detail_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/otp_clear_debt/otp_clear_debt_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/search/search_clear_debt_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';

import '../../../../utils/common_widgets.dart';
import '../ftth/after_sale/choose_service/choose_service_page.dart';

class ClearDebtPage extends GetView<ClearDebtLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
        init: ClearDebtLogic(context: context),
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
                          Text(AppLocalizations.of(context)!.textClearDebt,
                              style: AppStyles.title),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 50,
                        left: 20,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (controller.index == 1) {
                              controller.isTabTwo.value = false;
                              controller.isTabOne.value = true;
                              controller.nextPage(0);
                              return;
                            } else if (controller.index == 2) {
                              controller.isTabTwo.value = true;
                              controller.isTabOne.value = false;
                              controller.isTabThree.value = false;
                              controller.nextPage(1);
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
                                  check: controller.isTabOne, text: '1'),
                              const SizedBox(
                                width: 16,
                              ),
                              circleMarkerView(
                                  check: controller.isTabTwo, text: '2'),
                              const SizedBox(
                                width: 16,
                              ),
                              Row(
                                children: [
                                  circleMarkerView(
                                      check: controller.isTabThree, text: '3'),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
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
                    child: Container(
                  color: Colors.white,
                  child: TabBarView(
                      controller: controller.tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SearchClearDebtPage(),
                        ClearDebtDetailPage(),
                        OTPClearDebtPage()
                      ]),
                )),
              ],
            ),
          );
        });
  }
}
