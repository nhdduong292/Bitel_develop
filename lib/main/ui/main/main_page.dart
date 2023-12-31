// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:bitel_ventas/main/ui/main/home/home_page.dart';
import 'package:bitel_ventas/main/ui/main/report/report_page.dart';
import 'package:bitel_ventas/main/ui/main/stock/stock_page.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'drawer/drawer_page.dart';
import 'main_logic.dart';
import 'setting/setting_page.dart';

class MainPage extends GetWidget {
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ReportPage(),
    StockPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: MainLogic(),
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          body: Center(
            child: _widgetOptions.elementAt(controller.index.toInt()),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AppImages.icHome)),
                label: AppLocalizations.of(context)!.textHome,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AppImages.icReport)),
                label: AppLocalizations.of(context)!.textReport,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AppImages.icWarehouse)),
                label: AppLocalizations.of(context)!.textWare,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(AppImages.icConfig)),
                label: AppLocalizations.of(context)!.textConfig,
              ),
            ],
            selectedItemColor: AppColors.colorSelectBottomBar,
            backgroundColor: AppColors.colorBgBottomBar,
            unselectedItemColor: AppColors.colorUnSelectBottomBar,
            onTap: (value) {
              controller.setIndex(value);
            },
            currentIndex: controller.index.toInt(),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
          drawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.85,
            child: DrawerPage(),
          ),
        );
      },
    );
  }
}
