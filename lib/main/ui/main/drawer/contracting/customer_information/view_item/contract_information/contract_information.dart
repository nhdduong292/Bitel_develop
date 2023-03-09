// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bitel_ventas/main/ui/main/drawer/contracting/customer_information/customer_information_logic.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../utils/common_widgets.dart';

typedef void TouchUpadte();

class ContractInformationWidget extends GetView<CustomerInformationLogic> {
  final TouchUpadte callback;
  CustomerInformationLogic controller;
  ContractInformationWidget({required this.controller, required this.callback});
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
              height: 52,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.textContractInformation,
                  style: AppStyles.r00A5B1_15d5_500,
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
            lockedBox(
                content: 'Forced term',
                label: AppLocalizations.of(context)!.textContactType,
                required: false,
                isIcon: true,
                width: 210),
            lockedBox(
                content: '123456/XXXXXX',
                label: AppLocalizations.of(context)!.textContractNumber,
                required: false,
                isIcon: false,
                width: 210),
            lockedBox(
                content: '1',
                label: AppLocalizations.of(context)!.textQuantitySubscriber,
                required: true,
                isIcon: false,
                width: 210),
            Obx(() => lockedBox(
                content: controller.signDate.value,
                label: AppLocalizations.of(context)!.textSignDate,
                required: false,
                isIcon: false,
                width: 210)),
            Obx(
              () => lockedBox(
                  content: controller.billCycle.value,
                  label: AppLocalizations.of(context)!.textBillCycle,
                  required: true,
                  isIcon: true,
                  width: 210),
            ),
            lockedBox(
                content: 'Email',
                label: AppLocalizations.of(context)!.textChangeNotification,
                required: false,
                isIcon: true,
                width: 210),
            lockedBox(
                content: 'Email',
                label: AppLocalizations.of(context)!.textPrintBillDetail,
                required: false,
                isIcon: true,
                width: 210),
            lockedBox(
                content: 'SOL',
                label: AppLocalizations.of(context)!.textCurrency,
                required: true,
                isIcon: true,
                width: 210),
            spinnerFormNormalV2(
                context: context,
                label: AppLocalizations.of(context)!.textContractLanguage,
                hint: '',
                required: false,
                items: controller.contractLanguages,
                dropdownValue: controller.contractLanguagetValue,
                width: 210),
            inputFormV3(
                hint: 'Enter billing address',
                label: AppLocalizations.of(context)!.textBillingAddress,
                required: true,
                textDefault: controller.customer.address,
                inputType: TextInputType.streetAddress,
                width: 210),
            SizedBox(
              height: 27,
            )
          ]),
        ),
        SizedBox(
          height: 16,
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
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.textProtectionFilterAdvertising,
                  style: AppStyles.r00A5B1_15d5_500,
                ),
              ),
            ),
            DottedLine(
              dashColor: Color(0xFFE3EAF2),
              dashGapLength: 3,
              dashLength: 4,
            ),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!.textIAcceptToActivate,
                check: controller.checkOption1,
                changeValue: (value) {
                  controller.checkOption1.value = value;
                }),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!
                    .textIAcceptToReceiveInformatioin,
                check: controller.checkOption2,
                changeValue: (value) {
                  controller.checkOption2.value = value;
                }),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!
                    .textIAcceptToReceiveAdvertising,
                check: controller.checkOption3,
                changeValue: (value) {
                  controller.checkOption3.value = value;
                }),
            customRadioMutiple(
                width: width,
                text: AppLocalizations.of(context)!
                    .textIAcceptToReceiveInformatioin,
                check: controller.checkOption4,
                changeValue: (value) {
                  controller.checkOption4.value = value;
                }),
            SizedBox(
              height: 24,
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
                          controller.createContract();
                          // controller
                          //     .fromAsset('assets/demo-link.pdf', 'demo.pdf')
                          //     .then((value) {
                          //   // Get.to(PDFScreen(
                          //   //   path: value.path,
                          //   // ));
                          //   // controller.path.value = value.path;

                          //   callback();
                          // });

                          // controller.setPath();

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
