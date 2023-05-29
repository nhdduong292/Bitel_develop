// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/sale/sale_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/info_bussiness.dart';
import 'package:bitel_ventas/main/utils/common.dart';
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
    return GetBuilder(
      init: SaleLogic(context: context),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.textRequestOrderManagement,
                      style: AppStyles.title),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.icTimeBar),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${Common.getStringTimeToday()}",
                          style: AppStyles.b1),
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
          body: controller.isLoading
              ? RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.colorBackground,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textRequestManagement,
                                  style: AppStyles.r7.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 150,
                              padding: EdgeInsets.only(left: 12, right: 6),
                              margin: const EdgeInsets.only(
                                  top: 16, right: 16, bottom: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: Color(0xFFE3EAF2))),
                              child: Obx(
                                () => DropdownButton<String>(
                                  isExpanded: true,
                                  underline: Container(),
                                  value: controller.selectedMonthFilter.value,
                                  onChanged: (String? value) {
                                    controller.selectedMonthFilter.value =
                                        value!;
                                    controller.setDate(value);
                                  },
                                  items: controller
                                      .getMonthFilterItems()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  alignment: AlignmentDirectional.centerStart,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Barlow',
                                      color: Color(0xFF415263),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
                              itemCount: controller
                                  .getListRequestManagement(context)
                                  .length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: (width / 330),
                                      crossAxisSpacing: 6.0,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                OptionSale optionSale = controller
                                    .getListRequestManagement(context)[index];
                                return InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    controller.setIndexSelect(optionSale.index);
                                    Timer(
                                      const Duration(milliseconds: 500),
                                      () {
                                        if (index == 0) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 1);
                                        } else if (index == 1) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 2);
                                        } else if (index == 2) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 3);
                                        } else if (index == 3) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 4);
                                        } else if (index == 4) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 5);
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDEF9FE),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: optionSale.index ==
                                                    controller.indexSelect
                                                ? AppColors.colorTitle
                                                : AppColors.colorBackground1)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          optionSale.content,
                                          style: AppStyles.b4.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          optionSale.title,
                                          style: AppStyles.r2.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5
                                                      .withOpacity(0.5),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
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
                            AppLocalizations.of(context)!.textKPICommission,
                            style: AppStyles.r7.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
                              itemCount: controller
                                  .getListKPICommission(context)
                                  .length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: (width / 400),
                                      crossAxisSpacing: 6.0,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                OptionSale optionSale = controller
                                    .getListKPICommission(context)[index];
                                return InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    controller.setIndexSelect(optionSale.index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDEF9FE),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: optionSale.index ==
                                                    controller.indexSelect
                                                ? AppColors.colorTitle
                                                : AppColors.colorBackground1)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          optionSale.title,
                                          style: AppStyles.r2.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5
                                                      .withOpacity(0.5),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          optionSale.content,
                                          style: AppStyles.b4.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child: Wrap(
                                            children: [
                                              Text(
                                                optionSale.unit,
                                                style: AppStyles.r2.copyWith(
                                                    color: optionSale.index ==
                                                            controller
                                                                .indexSelect
                                                        ? AppColors.colorTitle
                                                        : AppColors.colorText5
                                                            .withOpacity(0.5),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                              Container(
                                                margin: index == 1
                                                    ? const EdgeInsets.only(
                                                        left: 4)
                                                    : const EdgeInsets.only(
                                                        left: 0),
                                                padding: index == 1
                                                    ? const EdgeInsets.all(2)
                                                    : const EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Colors.white),
                                                child: index == 1
                                                    ? Text(
                                                        "${controller.getPerformanceKPI()}%",
                                                        style: AppStyles.r2
                                                            .copyWith(
                                                                color: AppColors
                                                                    .color_83BF6E,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14),
                                                      )
                                                    : const Text(""),
                                              )
                                            ],
                                          ),
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
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 16, right: 16),
                            child: GridView.builder(
                              itemCount: controller
                                  .getListWalletControl(context)
                                  .length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: (width / 350),
                                      crossAxisSpacing: 6.0,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                OptionSale optionSale = controller
                                    .getListWalletControl(context)[index];
                                return InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    controller.setIndexSelect(optionSale.index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDEF9FE),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: optionSale.index ==
                                                    controller.indexSelect
                                                ? AppColors.colorTitle
                                                : AppColors.colorBackground1)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          optionSale.title,
                                          style: AppStyles.r2.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5
                                                      .withOpacity(0.5),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          optionSale.content,
                                          style: AppStyles.b4.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          optionSale.unit,
                                          style: AppStyles.r2.copyWith(
                                              color: optionSale.index ==
                                                      controller.indexSelect
                                                  ? AppColors.colorTitle
                                                  : AppColors.colorText5
                                                      .withOpacity(0.5),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
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
                            AppLocalizations.of(context)!.textFunction,
                            style: AppStyles.r7.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xFFDEF9FE),
                                  Color(0xFFFFFFFF),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                GridView.builder(
                                  itemCount: controller
                                      .getListOptionSale(context)
                                      .length,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: (width / 276),
                                          crossAxisSpacing: 6.0,
                                          mainAxisSpacing: 10.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    OptionSale optionSale = controller
                                        .getListOptionSale(context)[index];
                                    return InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        if (optionSale.title ==
                                            AppLocalizations.of(context)!
                                                .textCreateRequest) {
                                          Get.toNamed(
                                              RouteConfig.createRequest);
                                        } else if (optionSale.title ==
                                            AppLocalizations.of(context)!
                                                .textSearchRequest) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 0);
                                        } else if (optionSale.title ==
                                            AppLocalizations.of(context)!
                                                .textConnectSubscriber) {
                                          Get.toNamed(RouteConfig.listRequest,
                                              arguments: 2);
                                        } else if (optionSale.title ==
                                            AppLocalizations.of(context)!
                                                .textClearDebt) {
                                          Get.toNamed(RouteConfig.clearDebt);
                                        } else if (optionSale.title ==
                                            AppLocalizations.of(context)!
                                                .textRechargeAnypay) {
                                          Get.toNamed(RouteConfig.buyAnyPay);
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(optionSale.icon),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              textAlign: TextAlign.center,
                                              optionSale.title,
                                              style: AppStyles.r7.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              : Center(child: LoadingCirculApi()),
        );
      },
    );
  }

  Future _onRefresh() async {
    SaleLogic logic = Get.find<SaleLogic>();
    logic.getHomeSale();
  }
}
