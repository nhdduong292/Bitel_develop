import 'package:bitel_ventas/main/ui/main/home/home_page.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'main_logic.dart';
import 'setting/setting_page.dart';

class MainPage extends GetWidget {
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
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
                icon: Icon(Icons.home),
                label: AppLocalizations.of(context)!.textHome,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                label: AppLocalizations.of(context)!.textReport,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.warehouse),
                label: AppLocalizations.of(context)!.textWare,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
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
          drawer: Drawer(child: Text("Drawer sdfsdf sdf sdf sdf asdf sdaf sdf sdf ")),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.adb), onPressed: () {
            controller.openDrawer();
          },),
        );
      },
    );
  }
}
