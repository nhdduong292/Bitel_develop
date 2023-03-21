import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AfterSalePage extends StatelessWidget{
  const AfterSalePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
          child: GestureDetector(
            child: SvgPicture.asset(AppImages.icBack),
            onTap: () {
              Get.back();
            },
          ),
        ),
        elevation: 0.0,
        title: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(AppLocalizations.of(context)!.textAfterSaleFuntion, style: AppStyles.title),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              padding:
              const EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
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
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.textChangePlan,
                        style: AppStyles.r1,
                      )),
                  SvgPicture.asset(AppImages.icOvalArrowRight)
                ],
              ),
            ),
            onTap: () {
              Get.to(AfterSaleSearchPage(AppLocalizations.of(context)!.textChangePlan));
            },
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              padding:
              const EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
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
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.textTransferService,
                        style: AppStyles.r1.copyWith(fontWeight: FontWeight.w400),
                      )),
                  SvgPicture.asset(AppImages.icOvalArrowRight)
                ],
              ),
            ),
            onTap: () {
              Get.to(AfterSaleSearchPage(AppLocalizations.of(context)!.textTransferService));
            },
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              padding:
              const EdgeInsets.only(left: 16, top: 13, bottom: 13, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
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
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.textCancelService,
                        style: AppStyles.r1,
                      )),
                  SvgPicture.asset(AppImages.icOvalArrowRight)
                ],
              ),
            ),
            onTap: () {
                Get.to(AfterSaleSearchPage(AppLocalizations.of(context)!.textCancelService));
            },
          ),
        ],
      ),
    );
  }

}