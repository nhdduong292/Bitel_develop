import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/sale/sale_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalePage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // _onLoading(context);
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
          body: controller.isLoading ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context)!.textRequestManagement,
                    style: AppStyles.r7.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      itemCount: controller.getListRequestManagement(context).length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:1.5,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        OptionSale optionSale = controller.getListRequestManagement(context)[index];
                        return  GestureDetector(
                          onTap: () {
                            controller.setIndexSelect(optionSale.index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: optionSale.index == controller.indexSelect ? Colors.white : AppColors.colorBackground1,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorBackground1)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(optionSale.title, style: AppStyles.r2.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5.withOpacity(0.5), fontWeight: FontWeight.w400),),
                                SizedBox(height: 10,),
                                Text(optionSale.content, style: AppStyles.b4.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5, fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context)!.textKPICommission,
                    style: AppStyles.r7.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      itemCount: controller.getListKPICommission(context).length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:1.2,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        OptionSale optionSale = controller.getListKPICommission(context)[index];
                        return  GestureDetector(
                          onTap: () {
                            controller.setIndexSelect(optionSale.index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: optionSale.index == controller.indexSelect ? Colors.white : AppColors.colorBackground1,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorBackground1)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(optionSale.title, style: AppStyles.r2.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5.withOpacity(0.5), fontWeight: FontWeight.w400),),
                                SizedBox(height: 10,),
                                Text(optionSale.content, style: AppStyles.b4.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5, fontWeight: FontWeight.w600),),
                                SizedBox(height: 6,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(optionSale.unit, style: AppStyles.r2.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5.withOpacity(0.5), fontWeight: FontWeight.w400),),
                                    Container(
                                      margin: index == 1 ? EdgeInsets.only(left: 8) : EdgeInsets.only(left: 0),
                                      padding: index == 1 ? EdgeInsets.all(2) : EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.white
                                      ) ,
                                      child: index == 1 ? Text("${controller.getPerformanceKPI()}%", style: AppStyles.r2.copyWith(color: AppColors.color_83BF6E, fontWeight: FontWeight.w600),) : Text(""),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context)!.textWalletControl,
                    style: AppStyles.r7.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: GridView.builder(
                      itemCount: controller.getListWalletControl(context).length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:1.2,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        OptionSale optionSale = controller.getListWalletControl(context)[index];
                        return GestureDetector(
                          onTap: () {
                            controller.setIndexSelect(optionSale.index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: optionSale.index == controller.indexSelect ? Colors.white : AppColors.colorBackground1,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorBackground1)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(optionSale.title, style: AppStyles.r2.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5.withOpacity(0.5), fontWeight: FontWeight.w400),),
                                SizedBox(height: 10,),
                                Text(optionSale.content, style: AppStyles.b4.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5, fontWeight: FontWeight.w600),),
                                SizedBox(height: 6,),
                                Text(optionSale.unit, style: AppStyles.r2.copyWith(color: optionSale.index == controller.indexSelect ? AppColors.colorTitle: AppColors.colorText5.withOpacity(0.5), fontWeight: FontWeight.w400),),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context)!.textFunction,
                    style: AppStyles.r7.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                Container(
                    child: GridView.builder(
                      itemCount: controller.getListOptionSale(context).length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:6,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        OptionSale optionSale = controller.getListOptionSale(context)[index];
                        return GestureDetector(
                          onTap: () {
                            if(optionSale.title == AppLocalizations.of(context)!.textCreateRequest){
                              Get.toNamed(RouteConfig.createRequest);
                            } else if(optionSale.title == AppLocalizations.of(context)!.textSearchRequest){
                              Get.toNamed(RouteConfig.listRequest);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                SvgPicture.asset(optionSale.icon),
                                SizedBox(width: 10,),
                                Text(
                                  optionSale.title, style: AppStyles.r7.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ) :Center(child: LoadingCirculApi()),
        );
      },
    );
  }
}
