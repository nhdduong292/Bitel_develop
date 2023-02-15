import 'package:bitel_ventas/main/ui/main/drawer/ftth/sale/sale_logic.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalePage extends GetWidget{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: SaleLogic(),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WO management", style: AppStyles.title),
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(AppLocalizations.of(context)!.textFunction, style: AppStyles.r7.copyWith(fontWeight: FontWeight.w700, color: Colors.black),),
              ),
              // Container(
                // child:GridView.builder(
                //   itemCount: controller.getListOptionSale(context).length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: 4.0,
                //       mainAxisSpacing: 4.0
                //   ),
                //   itemBuilder: (BuildContext context, int index){
                //     return Text(controller.getListOptionSale(context)[index].title);
                //   },
                // )),
            ],
          ),
        ),
      );
    },);
  }

}
