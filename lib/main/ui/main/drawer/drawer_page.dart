// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/contracting/product/product_payment_method_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/drawer_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/change_language/dialog_change_language_page.dart';
import 'package:bitel_ventas/res/app_fonts.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../router/route_config.dart';
import '../activate_prepaid_pages/find_customer_page.dart';

class DrawerPage extends GetView<DrawerLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DrawerLogic(),
      builder: (controller) {
        controller.listItem = controller.getListItem(context).obs;
        return Scaffold(
          body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage(AppImages.bgHomeDrawer),
            //       fit: BoxFit.cover)
            //   ,
            // ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  AppImages.bgHomeDrawer,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height,
                ),
                Positioned(
                  left: 25,
                  top: 25,
                  child: IconButton(
                    iconSize: 30,
                    onPressed: () => Get.back(),
                    color: Colors.white,
                    icon: Icon(Icons.close),
                  ),
                ),
                Positioned(
                    top: 120,
                    left: 35,
                    right: 30,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ListView.builder(
                        itemCount: controller.listItem?.length,
                        itemBuilder: (context, index) {
                          DrawerItem drawerItem = controller.getListItem(context)[index];
                          if(drawerItem.list!.isEmpty){
                            return InkWell(
                              splashColor: Colors.black54,
                              onTap: () {
                                controller.onItemClick(index: index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Obx(
                                      () => Row(
                                    children: [
                                      SvgPicture.asset(controller.listItem![index].isSelected
                                          ? controller
                                          .listItem![index].selectedImg
                                          : controller.listItem![index]
                                          .unselectedImg),
                                      // Image(
                                      //   image: Svg(
                                      //       controller.listItem![index].isSelected
                                      //           ? controller
                                      //           .listItem![index].selectedImg
                                      //           : controller.listItem![index]
                                      //           .unselectedImg),
                                      //   width: 26,
                                      //   height: 26,
                                      // ),
                                      Padding(padding: EdgeInsets.only(left: 20)),
                                      Text(
                                        controller.listItem![index].label,
                                        style: TextStyle(
                                            color: controller
                                                .listItem![index].isSelected
                                                ? AppColors.colorBackground
                                                : Colors.white,
                                            fontSize: 19,
                                            fontFamily: AppFonts.Barlow),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return ListTileTheme(
                              // padding: EdgeInsets.symmetric(vertical: 20),
                              contentPadding: EdgeInsets.all(0),
                              minLeadingWidth: 0,
                              child: ExpansionTile(

                                trailing: SvgPicture.asset(AppImages.icArrowDown),
                                //     : SvgPicture.asset(AppImages.icOvalArrowRight),
                                leading:  SvgPicture.asset(drawerItem.unselectedImg),

                                title: Text(drawerItem.label!,
                                    style: TextStyle(
                                        color: controller
                                            .listItem![index].isSelected
                                            ? AppColors.colorBackground
                                            : Colors.white,
                                        fontSize: 19,
                                        fontFamily: AppFonts.Barlow)),
                                children: <Widget>[
                                  Column(
                                    children: _buildExpandableContent(drawerItem, context),
                                  ),
                                ],
                                onExpansionChanged: (value) {
                                  // controller.setStateSelectHelp(value);
                                },
                              ),
                            );
                          }
                        },
                      ),
                    )),
                Positioned(
                  bottom: 35,
                  left: 35,
                  child: InkWell(
                    onTap: () => controller.logOut(),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.icLogout),
                        // Image(
                        //   image: Svg(AppImages.icLogout),
                        //   width: 24,
                        //   height: 24,
                        // ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          AppLocalizations.of(context)!.textLogout,
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 17,
                              fontFamily: AppFonts.Barlow),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildExpandableContent(DrawerItem vehicle, BuildContext context) {
    List<Column> columnContent = [];
    for (int i = 0; i < vehicle.list!.length; i++) {
      String content = vehicle.list![i];
      columnContent.add(Column(
        children: [
          // const LineDash(color: AppColors.colorLineDash),
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 0),
            child: ListTile(
              title: Text(
                content,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontFamily: AppFonts.Barlow),
              ),
              // trailing: SvgPicture.asset(AppImages.icArrowRight),
              onTap: () {
                Future.delayed(Duration(milliseconds: 600));
                if(vehicle.label == AppLocalizations.of(context)!.textManageContact) {
                  if (i == 0) {
                    print("index: 0");
                    Get.to(() => FindCustomerPage());
                  } else if (i == 1) {
                    print("index: 1");
                    Get.toNamed(RouteConfig.manageContact);
                  }
                } else if(vehicle.label == AppLocalizations.of(context)!.textFTTH){
                  if (i == 0) {
                    print("index: 2");
                    Get.toNamed(RouteConfig.sale);
                  } else if (i == 1) {
                    print("index: 3");
                    Get.toNamed(RouteConfig.afterSale);
                  } else if (i == 2) {
                    // Get.toNamed(RouteConfig.manageWO);
                    Get.to(() => ProductPaymentMethodPage());
                    print("index: 4");
                  }
                }else if(vehicle.label == AppLocalizations.of(context)!.textUtilites){
                  print("index: 5");
                  if (i == 0) {
                    print("index: 5");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogChangeLanguagePage();
                      },
                    );
                  }
                }

              },
            ),
          )
        ],
      ));
    }
    return columnContent;
  }
}
