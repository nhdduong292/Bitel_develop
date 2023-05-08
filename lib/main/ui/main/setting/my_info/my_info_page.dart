import 'package:bitel_ventas/main/ui/main/setting/my_info/my_info_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../res/app_colors.dart';
import '../../../../../res/app_styles.dart';

class MyInfoPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: MyInfoLogic(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading:  Padding(
              padding: EdgeInsets.only(left: 18, bottom: 18,top: 2),
              child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                child: SvgPicture.asset(AppImages.icBack),
                onTap: () {
                  Get.back();
                },
              ),
            ),

            elevation: 0.0,
            title: Container(
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.textConfiguracion, style: AppStyles.title),
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
          body: Text(AppLocalizations.of(context)!.textMyInfo),
        );
      },
    );
  }
}
