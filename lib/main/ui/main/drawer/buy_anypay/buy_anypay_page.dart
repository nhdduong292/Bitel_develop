import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/info_bussiness.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuyAnyPayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.textBuyAnypay,
                  style: AppStyles.title),
              const SizedBox(height: 5),
              Row(
                children: [
                  SvgPicture.asset(AppImages.icTimeBar),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${Common.getStringTimeToday()}", style: AppStyles.b1),
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(AppImages.icAccountBar),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(InfoBusiness.getInstance()!.getUser().sub,
                      style: AppStyles.b1)
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
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              padding: const EdgeInsets.only(
                  left: 16, top: 13, bottom: 13, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(width: 1, color: AppColors.colorLineDash),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    color: AppColors.colorLineDash,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: SvgPicture.asset(AppImages.icCreateOrder),
                    width: 35,
                    height: 35,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context)!.textCreateOrder,
                    style: AppStyles.r1,
                  )),
                  SvgPicture.asset(AppImages.icOvalArrowRight)
                ],
              ),
            ),
            onTap: () {
              Get.toNamed(RouteConfig.createOrder);
            },
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              padding: const EdgeInsets.only(
                  left: 16, top: 13, bottom: 13, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(width: 1, color: AppColors.colorLineDash),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    color: AppColors.colorLineDash,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: SvgPicture.asset(AppImages.icOrderManagement),
                    width: 35,
                    height: 35,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context)!.textOrderManagement,
                    style: AppStyles.r1.copyWith(fontWeight: FontWeight.w400),
                  )),
                  SvgPicture.asset(AppImages.icOvalArrowRight)
                ],
              ),
            ),
            onTap: () {
              Get.toNamed(RouteConfig.orderManagement);
            },
          ),
          GestureDetector(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(width: 1, color: AppColors.colorLineDash),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    color: AppColors.colorLineDash,
                  ),
                ],
              ),
              child: Column(
                children: [
                  RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!.textTitleAnypay1,
                          style: AppStyles.r415263_14_600,
                          children: [
                        TextSpan(
                            text:
                                AppLocalizations.of(context)!.textTitleAnypay2,
                            style: AppStyles.r415263_14_400)
                      ]),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: IntrinsicHeight(
                      child:  Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: SvgPicture.asset(AppImages.icAnypayBBVA)),
                          VerticalDivider(
                            color: AppColors.colorLineDash,

                          ),
                          Expanded(child: SvgPicture.asset(AppImages.icAnypayBCP))
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
