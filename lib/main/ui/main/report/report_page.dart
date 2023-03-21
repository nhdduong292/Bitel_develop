import 'package:bitel_ventas/main/ui/main/report/report_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_styles.dart';

class ReportPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: ReportLogic(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.textReporteDeVentas, style: AppStyles.title),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.icTimeBar),
                      SizedBox(
                        width: 5,
                      ),
                      Text("28/12/2020 07:30 - V1.1", style: AppStyles.b1),
                      SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(AppImages.icAccountBar),
                      SizedBox(
                        width: 5,
                      ),
                      Text("GUADALUPECC-LI4", style: AppStyles.b1)
                    ],
                  )
                ],
              ),
            ),
            toolbarHeight: 100,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(width / 2, 20),
                      bottomRight: Radius.elliptical(width / 2, 20))),
            ),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 25, bottom: 15),
              child: Column(
                children: [
                  Container(
                    height: 45,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 1,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: controller.tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: AppColors.colorSelectTab,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.colorText2,
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(style: AppStyles.r2, AppLocalizations.of(context)!.textToday),
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(style: AppStyles.r2, AppLocalizations.of(context)!.textYesterday),
                        ),
                        Tab(
                          child: Text(style: AppStyles.r2, AppLocalizations.of(context)!.textPersonal),
                        ),
                      ],
                    ),
                  ),
                  // tab bar view here
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        // first tab bar view widget
                        Center(
                          child: Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // second tab bar view widget
                        Center(
                          child: Text(
                            'Yesterday',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Cá nhân',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
