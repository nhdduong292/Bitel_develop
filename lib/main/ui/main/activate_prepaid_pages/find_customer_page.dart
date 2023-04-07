// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/activate_prepaid_pages/activate_prepaid_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/app_styles.dart';

class FindCustomerPage extends GetView<ActivatePrepaidLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: ActivatePrepaidLogic(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Wrap(children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF8FBFB),
                      ),
                      width: width,
                      height: height,
                    ),
                    SvgPicture.asset(
                      AppImages.bgAppbar,
                      width: width,
                    ),
                    Positioned(
                      top: 40,
                      left: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.textActivatePrepaid,
                              style: AppStyles.title),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SvgPicture.asset(AppImages.icTimeBar),
                              SizedBox(
                                width: 5,
                              ),
                              Text("28/12/2020 07:30 - V1.1",
                                  style: AppStyles.b1),
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
                    Positioned(
                        top: 35,
                        left: 20,
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13)),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 15,
                                color: AppColors.colorTitle,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 113,
                        width: width,
                        height: 28,
                        child: SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 65,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppImages
                                            .icPageActivatePrepaidOrder))),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "01",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Barlow'),
                                      ),
                                      Text(
                                        " / 07",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Barlow'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 150,
                        bottom: 150,
                        left: 15,
                        right: 15,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Color(0xFFE3EAF2)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFE3EAF2), blurRadius: 3)
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .textFindCustomer,
                                      style: TextStyle(
                                          fontFamily: 'Barlow',
                                          fontSize: 15.5,
                                          color: AppColors.colorContent,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                DottedLine(
                                  dashColor: Color(0xFFE3EAF2),
                                  dashGapLength: 3,
                                  dashLength: 4,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 30),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller
                                                      .step1Choice1Checked.value =
                                                  !controller
                                                      .step1Choice1Checked.value;
                                            },
                                            splashColor: Colors.black38,
                                            child: Obx(() => controller
                                                    .step1Choice1Checked.value
                                                ? iconChecked()
                                                : iconUnchecked())),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: width * 0.75,
                                          child: RichText(
                                            text: TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .textAcceptFindCustomer1,
                                              style: TextStyle(
                                                color: AppColors.colorContent,
                                                fontFamily: 'Barlow',
                                                fontSize: 14,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .textAcceptFindCustomer1sub1,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.colorContent,
                                                      fontFamily: 'Barlow',
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .textAcceptFindCustomer1sub2,
                                                  style: TextStyle(
                                                    color: AppColors.colorContent,
                                                    fontFamily: 'Barlow',
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 30),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller
                                                      .step1Choice2Checked.value =
                                                  !controller
                                                      .step1Choice2Checked.value;
                                            },
                                            splashColor: Colors.black38,
                                            child: Obx(() => controller
                                                    .step1Choice2Checked.value
                                                ? iconChecked()
                                                : iconUnchecked())),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: width * 0.75,
                                          child: RichText(
                                            text: TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .textAcceptFindCustomer2,
                                              style: TextStyle(
                                                color: AppColors.colorContent,
                                                fontFamily: 'Barlow',
                                                fontSize: 14,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .textAcceptFindCustomer2sub1,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.colorContent,
                                                      fontFamily: 'Barlow',
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(height: 35,),
                                inputForm(
                                    label: AppLocalizations.of(context)!
                                        .textDNINumber,
                                    hint: '',
                                    required: true,
                                    inputType: TextInputType.number),
                              ],
                            ))),
                    Positioned(
                        bottom: 70,
                        left: 30,
                        right: 30,
                        child: InkWell(
                          splashColor: Colors.black38,
                          onTap: () => controller.gotoNextStep(step: 2),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.colorText3),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .textContinue
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ))
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
