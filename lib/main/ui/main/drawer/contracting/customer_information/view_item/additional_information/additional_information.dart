// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../../res/app_colors.dart';
import '../../../../../../../router/route_config.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

typedef void TouchContinue();

class AdditionalInformationWidget extends GetView<CustomerInformationLogic> {
  final TouchContinue callback;
  CustomerInformationLogic controller;
  AdditionalInformationWidget(
      {required this.controller, required this.callback});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFFE3EAF2),
              width: 1.0,
            ),
            boxShadow: [
              const BoxShadow(
                color: Color.fromRGBO(185, 212, 220, 0.2),
                offset: Offset(0, 2),
                blurRadius: 7.0,
              ),
            ],
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(26),
              dashPattern: [2, 2],
              strokeWidth: 1,
              color: Color(0xFF9454C9),
              child: SizedBox(
                width: 234,
                height: 41,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RichText(
                    text: TextSpan(
                        text: '${controller.getTypeCustomer()} ',
                        style: AppStyles.r9454C9_14_500.copyWith(
                            fontSize: 13, fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(
                            text: controller.customer.idNumber,
                            style: AppStyles.r2B3A4A_12_500.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          )
                        ]),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            lockedBoxV1(
                content: controller.customer.fullName,
                label: AppLocalizations.of(context)!.textFullName,
                required: false,
                isIcon: false,
                width: 210),
            lockedBoxV1(
                content: controller.customer.nationality,
                label: AppLocalizations.of(context)!.textNationality,
                required: false,
                isIcon: false,
                width: 210),
            lockedBoxV1(
                content: controller.getSex(),
                label: AppLocalizations.of(context)!.textSex,
                required: false,
                isIcon: false,
                width: 210),
            lockedBoxV1(
                content: controller.customer.birthDate.isNotEmpty
                    ? Common.fromDate(
                        DateTime.parse(controller.customer.birthDate),
                        'dd/MM/yyyy')
                    : "---",
                label: AppLocalizations.of(context)!.textDateOfBirth,
                required: false,
                isIcon: false,
                width: 210),
            lockedBoxV1(
                content: controller.customer.idIssueDate.isNotEmpty
                    ? Common.fromDate(
                        DateTime.parse(controller.customer.idIssueDate),
                        'dd/MM/yyyy')
                    : "---",
                label: AppLocalizations.of(context)!.textIssuedate,
                required: false,
                isIcon: false,
                width: 210),
            SizedBox(
              height: 27,
            )
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFFE3EAF2),
              width: 1.0,
            ),
            boxShadow: [
              const BoxShadow(
                color: Color.fromRGBO(185, 212, 220, 0.2),
                offset: Offset(0, 2),
                blurRadius: 7.0,
              ),
            ],
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(children: [
            SizedBox(
              height: 52,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    AppLocalizations.of(context)!.textAdditionalInformation,
                    style: AppStyles.r00A5B1_15d5_500,
                  ),
                ),
              ),
            ),
            DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            SizedBox(
              height: 15,
            ),
            inputFormMaxLenght(
                hint: AppLocalizations.of(context)!.textEnterPhoneNumber,
                label: AppLocalizations.of(context)!.textPhoneNumber,
                required: true,
                maxLength: 11,
                controller: controller.phoneController,
                inputType: TextInputType.number,
                width: 210,
                onChange: (value) {
                  controller.phone = value;
                }),
            inputFormV3(
                hint: AppLocalizations.of(context)!.textEnterEmail,
                label: AppLocalizations.of(context)!.textEmail,
                required: true,
                controller: controller.emailController,
                inputType: TextInputType.text,
                width: 210,
                onChange: (value) {
                  controller.email = value;
                }),
            inputFormV3(
                hint: AppLocalizations.of(context)!.textEnterAddress,
                label: AppLocalizations.of(context)!.textAddressCustomerInfo,
                required: true,
                controller: controller.addressController,
                inputType: TextInputType.text,
                isReadOnly: true,
                width: 210,
                onChange: (value) {
                  controller.address = value;
                }),
            SizedBox(
              height: 27,
            )
          ]),
        ),
        SizedBox(
            width: width,
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: bottomButtonV2(
                        onTap: () {
                          Get.back();
                        },
                        text: AppLocalizations.of(context)!
                            .textCancel
                            .toUpperCase())),
                Expanded(
                    flex: 1,
                    child: bottomButton(
                        onTap: () {
                          if (controller.checkValidateAddInfo()) {
                            return;
                          }
                          if (!controller.checkValidate()) {
                            return;
                          }
                          callback();
                        },
                        text: AppLocalizations.of(context)!
                            .textContinue
                            .toUpperCase())),
              ],
            )),
      ]),
    );
  }

  Widget lockedBoxV1(
      {required String label,
      required String content,
      required bool required,
      required bool isIcon,
      required double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: label,
                style: AppStyles.r2B3A4A_12_500
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: required ? ' *' : '',
                      style: TextStyle(
                        color: AppColors.colorTextError,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Container(
              height: 45,
              width: width,
              padding: EdgeInsets.only(left: 18, right: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Color(0xFFE3EAF2), width: 1)),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        content,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xFFCFCFCF),
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isIcon,
                      child: SvgPicture.asset(AppImages.icArrowDownLockedBox))
                ],
              )),
        ),
      ],
    );
  }
}
