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
import 'package:group_radio_button/group_radio_button.dart';

import '../../../../res/app_styles.dart';

class CustomerInfoPage extends GetView<ActivatePrepaidLogic> {
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
                          Text(
                              AppLocalizations.of(context)!.textActivatePrepaid,
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
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
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
                                        "02",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .textCustomerInfo,
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
                                inputForm(
                                    label: AppLocalizations.of(context)!
                                        .textFullLevelAddress,
                                    hint: AppLocalizations.of(context)!
                                        .hintFullLevelAddress,
                                    required: true,
                                    inputType: TextInputType.text),
                                inputForm(
                                    label: AppLocalizations.of(context)!
                                        .textDirectionProfile,
                                    hint: AppLocalizations.of(context)!
                                        .hintDirection,
                                    required: true,
                                    inputType: TextInputType.text),
                                inputForm(
                                    label: AppLocalizations.of(context)!
                                        .textContractNumber,
                                    hint: AppLocalizations.of(context)!
                                        .hintContractNumber,
                                    required: false,
                                    inputType: TextInputType.text),
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 15),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textSendDocuments,
                                    style: TextStyle(
                                      color: AppColors.colorText1,
                                      fontFamily: 'Barlow',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width * 0.6,
                                  margin: EdgeInsets.only(left: 5),
                                  child: Obx(
                                    () => RadioGroup<String>.builder(
                                      direction: Axis.horizontal,
                                      groupValue: controller
                                          .groupSendDocumentValue.value,
                                      horizontalAlignment:
                                          MainAxisAlignment.start,
                                      onChanged: (value) {
                                        controller.groupSendDocumentValue
                                            .value = value ?? '';
                                      },
                                      items: controller.sendDocumentValues,
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.colorText2,
                                          fontFamily: "Barlow"),
                                      itemBuilder: (item) => RadioButtonBuilder(
                                        item,
                                      ),
                                      fillColor: AppColors.colorSubContent,
                                      activeColor: AppColors.colorSubContent,
                                    ),
                                  ),
                                ),
                                inputForm(
                                    label:
                                        AppLocalizations.of(context)!.textEmail,
                                    hint:
                                        AppLocalizations.of(context)!.hintEmail,
                                    required: true,
                                    inputType: TextInputType.text),
                              ],
                            ))),
                    Positioned(
                        bottom: 70,
                        left: 30,
                        right: 30,
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          onTap: () => controller.gotoNextStep(step: 3),
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
