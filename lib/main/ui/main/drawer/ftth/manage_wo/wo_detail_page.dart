import 'package:bitel_ventas/main/ui/main/drawer/ftth/manage_wo/manage_wo_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../res/app_colors.dart';
import '../../../../../../res/app_images.dart';
import '../../../../../../res/app_styles.dart';

class WODetailPage extends GetView<ManageWOLogic> {
  WorkOrder wo;
  WODetailPage({
    required this.wo,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: ManageWOLogic(),
        builder: (controller) {
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8FBFB),
                        ),
                        width: width,
                        height: 150,
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
                            Text(AppLocalizations.of(context)!.textWOManagement,
                                style: AppStyles.title),
                            const SizedBox(height: 5),
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
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 15,
                                  color: AppColors.colorTitle,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!.textCustomerInfo,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textCustomerName,
                                  style: const TextStyle(
                                      color: AppColors.colorText2,
                                      fontSize: 15,
                                      fontFamily: 'Barlow'),
                                ),
                              ),
                              Text(
                                wo.customerName,
                                style: const TextStyle(
                                    color: Color(0xFF415263),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Barlow'),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .textCustomerPhoneNumber,
                                  style: const TextStyle(
                                      color: AppColors.colorText2,
                                      fontSize: 15,
                                      fontFamily: 'Barlow'),
                                ),
                              ),
                              Text(
                                wo.phoneNumber,
                                style: const TextStyle(
                                    color: Color(0xFF415263),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Barlow'),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.textAddress,
                                  style: const TextStyle(
                                      color: AppColors.colorText2,
                                      fontSize: 15,
                                      fontFamily: 'Barlow'),
                                ),
                              ),
                              Text(
                                wo.address,
                                style: const TextStyle(
                                    color: Color(0xFF415263),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Barlow'),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(
                                  wo.type == 'Survey'
                                      ? AppLocalizations.of(context)!.textLine
                                      : AppLocalizations.of(context)!
                                          .textAccount,
                                  style: const TextStyle(
                                      color: AppColors.colorText2,
                                      fontSize: 15,
                                      fontFamily: 'Barlow'),
                                ),
                              ),
                              Text(
                                wo.type == 'Survey' ? wo.line : wo.account,
                                style: const TextStyle(
                                    color: AppColors.colorText3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Barlow'),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!.textWOInformation,
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!.textStaffInfo,
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!
                        .textInfrastructureInformation,
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!
                        .textMaterialsGoodsInformation,
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!.textAcceptanceRecord,
                    child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: bottomButtonV2(
                              text: AppLocalizations.of(context)!.textCancel,
                              onTap: () {})),
                      Expanded(
                          child: bottomButton(
                              text: AppLocalizations.of(context)!.textSave,
                              onTap: () {}))
                    ],
                  )
                ],
              ),
            ),
          ));
        });
  }
}
