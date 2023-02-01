import 'package:bitel_ventas/main/ui/main/stock/stock_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_styles.dart';

class StockPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: StockLogic(),
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
                  Text("Almacén", style: AppStyles.title),
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
          body: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 24, left: 10, right: 10, bottom: 5),
                child: Text(
                  "Información de almacén del código LI1CD04 ",
                  style: AppStyles.r3,
                ),
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  padding:
                  EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: SvgPicture.asset(AppImages.icSimMobile),
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.textSimMobile,
                            style: AppStyles.r1,
                          )),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "2,815",
                          style: AppStyles.r3,
                        ),
                      ),
                      SvgPicture.asset(AppImages.icOvalArrowRight)
                    ],
                  ),
                ),
                onTap: () {

                },
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  padding:
                  EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: SvgPicture.asset(AppImages.icKit),
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.textKit,
                            style: AppStyles.r1,
                          )),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "280",
                          style: AppStyles.r3,
                        ),
                      ),
                      SvgPicture.asset(AppImages.icOvalArrowRight)
                    ],
                  ),
                ),
                onTap: () {

                },
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  padding:
                  EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: SvgPicture.asset(AppImages.icHandSet),
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.textHandset,
                            style: AppStyles.r1,
                          )),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "30",
                          style: AppStyles.r3,
                        ),
                      ),
                      SvgPicture.asset(AppImages.icOvalArrowRight)
                    ],
                  ),
                ),
                onTap: () {

                },
              ),
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  padding:
                  EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: SvgPicture.asset(AppImages.icAnyPay),
                        width: 35,
                        height: 35,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.textAnyPay,
                            style: AppStyles.r1,
                          )),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "2,815",
                          style: AppStyles.r3,
                        ),
                      ),
                      SvgPicture.asset(AppImages.icOvalArrowRight)
                    ],
                  ),
                ),
                onTap: () {

                },
              )
            ],
          ),
        );
      },
    );
  }
}
