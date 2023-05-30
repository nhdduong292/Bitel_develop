import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/view_item/contract_uploading/contract_uploading_page.dart';
import 'package:bitel_ventas/main/ui/main/home/home_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_styles.dart';
import '../../../router/route_config.dart';
import '../../../utils/common.dart';
import '../drawer/utilitis/info_bussiness.dart';

class HomePage extends GetView<HomeLogic> {
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              child: Container(
                child: Center(
                    child: Text(
                  "${AppLocalizations.of(context)!.textPage} $index",
                  style: TextStyle(color: Colors.indigo),
                )),
              ),
            ));
    return GetBuilder(
      init: HomeLogic(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.bgHome), fit: BoxFit.fill),
              ),
            ),
            toolbarHeight: 280,
            leading: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: SvgPicture.asset(AppImages.icMenu),
                  )
                ],
              ),
              onTap: () {
                controller.openDrawer();
              },
            ),
            actions: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 20),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        // Get.toNamed(RouteConfig.forgotPassword);
                      },
                      child: SvgPicture.asset(AppImages.icNotification),
                    ),
                  )
                ],
              )
            ],
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.icAvatarDefault),
                  SizedBox(height: 10),
                  Text(
                      "${AppLocalizations.of(context)!.textHello.toUpperCase()}, ${InfoBusiness.getInstance()!.getUser().name}",
                      style: AppStyles.b2),
                  SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .textUser
                                  .toUpperCase(),
                              style: AppStyles.b3),
                          Text(InfoBusiness.getInstance()!.getUser().sub,
                              style: AppStyles.b1)
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                        child: VerticalDivider(
                          color: AppColors.colorLineVertical,
                          thickness: 1,
                          indent: 5,
                          endIndent: 0,
                          width: 20,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .textDateAndTime
                                  .toUpperCase(),
                              style: AppStyles.b3),
                          Text(
                              "${Common.getStringTimeToday()} - V.${Common.getVersionApp()}",
                              style: AppStyles.b1)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Padding(
              //   padding:
              //       EdgeInsets.only(left: 20, right: 20, top: 17, bottom: 24),
              //   child: Container(
              //     alignment: Alignment.topLeft,
              //     child: Text("Hola, Diego Guadalupe", style: AppStyles.b2),
              //   ),
              // ),
              // Expanded(
              //   child: PageView.builder(
              //     controller: controller.controllerPage,
              //     // itemCount: pages.length,
              //     itemBuilder: (_, index) {
              //       return pages[index % pages.length];
              //     },
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // SmoothPageIndicator(
              //   controller: controller.controllerPage,
              //   count: pages.length,
              //   effect: const WormEffect(
              //     dotHeight: 8,
              //     dotWidth: 16,
              //     spacing: 10,
              //     activeDotColor: AppColors.colorSelectBottomBar,
              //     dotColor: AppColors.colorDotIndicator,
              //     type: WormType.thin,
              //     // strokeWidth: 5,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
