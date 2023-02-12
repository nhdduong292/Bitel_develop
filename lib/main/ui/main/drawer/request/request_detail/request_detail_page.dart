import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestDetailPage extends GetWidget{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: RequestDetailLogic(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: EdgeInsets.only(left: 18, bottom: 18, top: 2),
                child: GestureDetector(
                  child: SvgPicture.asset(AppImages.icBack),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              elevation: 0.0,
              title: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(AppLocalizations.of(context)!.textRequestDetail, style: AppStyles.title),
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
          );
        },);
  }

}