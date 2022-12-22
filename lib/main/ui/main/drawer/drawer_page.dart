// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/login/login_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/drawer_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors.dart';
import '../../../utils/common_widgets.dart';

class DrawerPage extends GetView<DrawerLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DrawerLogic(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                color: AppColors.colorSelectBottomBar,
              ),
              Positioned(
                left: 25,
                top: 25,
                child: IconButton(
                  iconSize: 40,
                  onPressed: () => Get.back(),
                  color: Colors.white,
                  icon: Icon(Icons.close),
                ),
              ),
              Positioned(
                  top: 120,
                  left: 35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      drawerItemWidget(
                          icon: Icons.arrow_circle_right,
                          text: AppLocalizations.of(context)!.textActivatePrepaid),
                      drawerItemWidget(
                          icon: Icons.arrow_circle_right,
                          text: AppLocalizations.of(context)!.textActivatePostpaid),
                      drawerItemWidget(
                          icon: Icons.arrow_circle_right,
                          text: AppLocalizations.of(context)!.textPortability),
                      drawerItemWidget(
                          icon: Icons.arrow_circle_right,
                          text: AppLocalizations.of(context)!.textMigration),
                      drawerItemWidget(
                          icon: Icons.arrow_circle_right,
                          text: AppLocalizations.of(context)!.textAnyPay),
                      drawerItemWidget(
                          icon: Icons.arrow_circle_right,
                          text: AppLocalizations.of(context)!.textUtilities),
                    ],
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
                        style: TextStyle(color: Colors.yellow, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
