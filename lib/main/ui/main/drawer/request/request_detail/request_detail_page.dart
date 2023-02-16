import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_cancel_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_transfer_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestDetailPage extends GetWidget{
  const RequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: RequestDetailLogic(),
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
                margin: EdgeInsets.only(bottom: 20),
                child: Text(AppLocalizations.of(context)!.textRequestDetail, style: AppStyles.title),
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
            body: controller.isLoading   ? LoadingCirculApi() : (controller.requestModel.id == 0 ? Center(child: Text("No data"),)  : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  expandableV1(
                    label: AppLocalizations.of(context)!.textInformationRequired,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textCustomerName,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textContactPhone,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textInstallationAddress,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textService,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textTechnology,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textLine,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hintISDNAccount,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textTechnicalTeam,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only( left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textStatus,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  expandableV1(
                    label: AppLocalizations.of(context)!.textWorkProgressStatus,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textNo,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hintISDNAccount,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textServices,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textTypeOfWork,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textStartDate,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textEndDate,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textStaffCode,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textPhone,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textTeams,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xFFE3EAF2),
                          dashGapLength: 3,
                          dashLength: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only( left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textStatus,
                                style: const TextStyle(
                                    color: AppColors.colorText2,
                                    fontSize: 15,
                                    fontFamily: 'Roboto'),
                              ),
                              Expanded(
                                child: Text(
                                  "wo.customerName",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Color(0xFF415263),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 30, left: 25, right: 15),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),

                            child: InkWell(
                              onTap: () {
                                showDialogCancelRequest(context, controller.requestModel.id);
                              },
                              child:  Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.textCancel.toUpperCase(),
                                    style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                                  )),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 30, left: 15, right: 25),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.colorButton,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: InkWell(
                              onTap: () {
                                showDialogTransferRequest(context, controller.requestModel.id);
                              },
                              child:  Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.textTransfer.toUpperCase(),
                                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            )),
          );
        },);
  }

  void showDialogTransferRequest(BuildContext context, int id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogTransferRequest(
            id: id,
            onSubmit: () {},
          );
        });
  }

  void showDialogCancelRequest(BuildContext context, int id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogCancelRequest(onSubmit: (){

          }, id: id,);
        });
  }

}