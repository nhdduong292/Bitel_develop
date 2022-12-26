// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/drawer_logic.dart';
import 'package:bitel_ventas/res/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        List<DrawerItem> drawerItems = controller.getListItem(context);
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
                    child: Container(
                      child: ListView.builder(
                        itemCount: drawerItems.length,
                        itemBuilder: (context, index) {
                          DrawerItem item = drawerItems[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  Image(
                                    image: Svg(item.isSelected
                                        ? item.selectedImg
                                        : item.unselectedImg),
                                    width: 34,
                                    height: 34,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 20)),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                        color: item.isSelected
                                            ? AppColors.colorBackground
                                            : Colors.white,
                                        fontSize: 20,
                                        fontFamily: AppFonts.Barlow),
                                  ),
                                ],
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
                        Icon(
                          Icons.arrow_circle_right,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          AppLocalizations.of(context)!.textLogout,
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 18,
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
