// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/drawer_logic.dart';
import 'package:bitel_ventas/res/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';

class DrawerPage extends GetView<DrawerLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DrawerLogic(),
      builder: (controller) {
        controller.listItem = controller.getListItem(context).obs;
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Svg(AppImages.bgHomeDrawer), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: controller.listItem?.length,
                        itemBuilder: (context, index) {
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
                                    Image(
                                      image: Svg(
                                          controller.listItem![index].isSelected
                                              ? controller
                                                  .listItem![index].selectedImg
                                              : controller.listItem![index]
                                                  .unselectedImg),
                                      width: 26,
                                      height: 26,
                                    ),
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
                        Image(
                          image: Svg(AppImages.icLogout),
                          width: 24,
                          height: 24,
                        ),
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
}
