import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/choose_service/choose_service_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/find_service/find_service_page.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterSaleSearchPage extends GetWidget {
  String title;
  String type;

  AfterSaleSearchPage(this.title, this.type);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: AfterSaleSearchLogic(title, context, type),
      builder: (controller) {
        return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
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
                        height: 147,
                      ),
                      SvgPicture.asset(
                        AppImages.bgAppbar,
                        width: width,
                      ),
                      Positioned(
                        top: 50,
                        left: 70,
                        child: Text(title, style: AppStyles.title),
                      ),
                      Positioned(
                          top: 45,
                          left: 20,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              // if (controller.isLoadingProduct) {
                              //   Get.back();
                              //   return;
                              // }
                              if (controller.index == 0) {
                                Get.back();
                              } else {
                                controller.isTabTwo.value = false;
                                controller.isTabOne.value = true;
                                controller.nextPage(0);
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
                      Positioned(
                          top: 111,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SizedBox(
                              width: 120,
                              height: 36,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  circleMarkerView(
                                      check: controller.isTabOne, text: '1'),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                  circleMarkerView(
                                      check: controller.isTabTwo, text: '2'),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: TabBarView(
                          controller: controller.tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [FindServicePage(), ChooseServicePage()]))
                ],
              ),
            ));
      },
    );
  }
}
