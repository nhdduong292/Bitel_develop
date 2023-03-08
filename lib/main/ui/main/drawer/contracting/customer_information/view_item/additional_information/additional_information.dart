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
                        text: '${controller.getTypeCustomer()}: ',
                        style: AppStyles.r3,
                        children: [
                          TextSpan(
                            text: controller.customer.idNumber,
                            style: AppStyles.r1,
                          )
                        ]),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            lockedBox(
                content: controller.customer.fullName,
                label: AppLocalizations.of(context)!.textFullName,
                required: false,
                isIcon: false,
                width: 210),
            lockedBox(
                content: controller.customer.nationality,
                label: AppLocalizations.of(context)!.textNationality,
                required: false,
                isIcon: false,
                width: 210),
            lockedBox(
                content: controller.customer.sex,
                label: AppLocalizations.of(context)!.textSex,
                required: false,
                isIcon: false,
                width: 210),
            lockedBox(
                content: controller.customer.birthDate,
                label: AppLocalizations.of(context)!.textDateOfBirth,
                required: false,
                isIcon: false,
                width: 210),
            lockedBox(
                content: controller.customer.idIssueDate,
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
            inputFormV3(
                hint: AppLocalizations.of(context)!.textEnterPhoneNumber,
                label: AppLocalizations.of(context)!.textPhoneNumber,
                required: true,
                textDefalut: controller.customer.telFax,
                inputType: TextInputType.text,
                width: 210),
            inputFormV3(
                hint: AppLocalizations.of(context)!.textEnterEmail,
                label: AppLocalizations.of(context)!.textEmail,
                required: true,
                textDefalut: controller.customer.email,
                inputType: TextInputType.text,
                width: 210),
            inputFormV3(
                hint: AppLocalizations.of(context)!.textEnterAddress,
                label: AppLocalizations.of(context)!.textAddressCustomerInfo,
                required: true,
                textDefalut: controller.customer.address,
                inputType: TextInputType.text,
                width: 210),
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
                        onTap: () {},
                        text: AppLocalizations.of(context)!
                            .textCancel
                            .toUpperCase())),
                Expanded(
                    flex: 1,
                    child: bottomButton(
                        onTap: () {
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
}
