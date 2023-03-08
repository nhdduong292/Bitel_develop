import 'dart:async';

import 'package:bitel_ventas/main/networks/model/work_order_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_cancel_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_transfer_request_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestDetailPage extends GetWidget {
  const RequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: RequestDetailLogic(context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 18, top: 2),
              child: GestureDetector(
                child: SvgPicture.asset(AppImages.icBack),
                onTap: () {
                  Get.back();
                },
              ),
            ),
            elevation: 0.0,
            title: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(AppLocalizations.of(context)!.textRequestDetail,
                  style: AppStyles.title),
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
              ? LoadingCirculApi()
              : (controller.requestModel.id == 0
                  ? const Center(
                      child: Text("No data"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          expandableV1(
                            label: AppLocalizations.of(context)!
                                .textCustomerInformation,
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 15, left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .textFullName,
                                      style: const TextStyle(
                                          color: AppColors.colorText2,
                                          fontSize: 15,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel.customerModel
                                                .fullName.isEmpty
                                            ? "---"
                                            : controller.requestModel
                                                .customerModel.fullName,
                                        textAlign: TextAlign.right,
                                        style: AppStyles.r415263_13_500,
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
                                margin: const EdgeInsets.only(
                                    bottom: 15, left: 15, right: 15, top: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .textPhoneNumber,
                                      style: const TextStyle(
                                          color: AppColors.colorText2,
                                          fontSize: 15,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel.customerModel
                                                .idNumber.isEmpty
                                            ? "---"
                                            : controller.requestModel
                                                .customerModel.fullName,
                                        textAlign: TextAlign.right,
                                        style: AppStyles.r415263_13_500,
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
                                margin: const EdgeInsets.only(
                                    bottom: 15, left: 15, right: 15, top: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.textID,
                                      style: const TextStyle(
                                          color: AppColors.colorText2,
                                          fontSize: 15,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel.customerModel.custId < 1
                                            ? "---"
                                            : controller.requestModel
                                                .customerModel.fullName,
                                        textAlign: TextAlign.right,
                                        style: AppStyles.rU00A5B1_13_500,
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
                                margin: const EdgeInsets.only(
                                    bottom: 15, left: 15, right: 15, top: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .textInstallationAddress,
                                      style: const TextStyle(
                                          color: AppColors.colorText2,
                                          fontSize: 15,
                                          fontFamily: 'Roboto'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel.customerModel.getInstalAddress().isEmpty
                                            ? "---"
                                            : controller.requestModel
                                                .customerModel.getInstalAddress(),
                                        textAlign: TextAlign.right,
                                        style: AppStyles.r415263_13_500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          expandableV1(
                            label: AppLocalizations.of(context)!
                                .textSubscriptionInformation,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textService,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller
                                                  .requestModel.service.isEmpty
                                              ? "---"
                                              : controller.requestModel.service,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.textPlan,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.customerModel
                                                  .fullName.isEmpty
                                              ? "---"
                                              : "${controller.requestModel.subscriptionModel.productCode} + ${controller.requestModel.subscriptionModel.speed}",
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textTechnology,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.technology
                                                  .isEmpty
                                              ? "---"
                                              : controller
                                                  .requestModel.technology,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textMonthlyFee,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.subscriptionModel.pricePlan < 1
                                              ? "---"
                                              : "${controller.requestModel
                                                  .subscriptionModel.pricePlan}",
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          expandableV1(
                            label: AppLocalizations.of(context)!
                                .textContractInformation,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textContractNumber,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.contractModel.contractId < 1
                                              ? "---"
                                              : "${controller.requestModel.contractModel.contractId}",
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textBillingCycle,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.contractModel.billCycleFrom < 1
                                              ? "---"
                                              : "${controller.requestModel
                                                  .contractModel.billCycleFrom}",
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textSignDate,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.contractModel
                                                  .signDate.isEmpty
                                              ? "---"
                                              : controller.requestModel
                                                  .contractModel.signDate,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textStatus,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.contractModel.status < 1
                                              ? "---"
                                              : "${controller.requestModel
                                                  .contractModel.status}",
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          expandableV1(
                            label: AppLocalizations.of(context)!
                                .textWorkOrderInformation,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .hintISDNAccount,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.isdnAccount
                                                  .isEmpty
                                              ? "---"
                                              : controller
                                                  .requestModel.isdnAccount,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .textPassword,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller
                                                  .requestModel
                                                  .subscriptionModel
                                                  .password
                                                  .isEmpty
                                              ? "---"
                                              : controller.requestModel
                                                  .subscriptionModel.password,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.textTeam,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.listWO.isEmpty
                                              ? "---"
                                              : controller.requestModel
                                                  .listWO[0].teamName,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
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
                                  margin: const EdgeInsets.only(
                                      bottom: 15, left: 15, right: 15, top: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.textStaff,
                                        style: const TextStyle(
                                            color: AppColors.colorText2,
                                            fontSize: 15,
                                            fontFamily: 'Roboto'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.listWO.isEmpty
                                              ? "---"
                                              : controller.requestModel
                                                  .listWO[0].staffName,
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 12, left: 15, right: 15),
                            child: Table(
                              border: TableBorder.all(),
                              columnWidths: const {
                                0: FractionColumnWidth(0.2),
                                1: FractionColumnWidth(0.4),
                                2: FractionColumnWidth(0.2),
                                3: FractionColumnWidth(0.2),
                              },
                              children: List.generate(
                                  controller.requestModel.listWO.length + 1,
                                  (index) {
                                if (index == 0) {
                                  return buildRow([
                                    AppLocalizations.of(context)!.textWOType,
                                    AppLocalizations.of(context)!.textStartDate,
                                    AppLocalizations.of(context)!.textEndDate,
                                    AppLocalizations.of(context)!.textStatus
                                  ], true);
                                } else {
                                  WorkOrderModel model =
                                      controller.requestModel.listWO[index - 1];
                                  return buildRow([
                                    model.woType,
                                    model.creationDate,
                                    model.expectedDate,
                                    model.status
                                  ], false);
                                }
                              }),
                            ),
                          ),
                          controller.isShowBtnConnect
                              ? Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 15, right: 15),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorButton,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (controller.status ==
                                              RequestStatus
                                                  .CREATE_REQUEST_WITHOUT_SURVEY ||
                                          controller.status ==
                                              RequestStatus
                                                  .SURVEY_OFFLINE_SUCCESSFULLY) {
                                        Get.toNamed(RouteConfig.productPayment);
                                      } else if (controller.status ==
                                          RequestStatus.CONNECTED) {
                                        //todo show dialog cancel
                                        showDialogCancelRequest(context,
                                            controller.requestModel.id);
                                      } else if (controller.status ==
                                              RequestStatus.DEPLOYING ||
                                          controller.status ==
                                              RequestStatus.COMPLETE ||
                                          controller.status ==
                                              RequestStatus.CANCEL) {
                                        Get.back();
                                      }
                                    },
                                    child: Center(
                                        child: Text(
                                      controller.textConnect.toUpperCase(),
                                      style: AppStyles.r5.copyWith(
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                )
                              : Container(),
                          controller.isShowBtnCancelTransfer
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              top: 30, left: 25, right: 15),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 1),
                                                blurRadius: 2,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              showDialogCancelRequest(context,
                                                  controller.requestModel.id);
                                            },
                                            child: Center(
                                                child: Text(
                                              AppLocalizations.of(context)!
                                                  .textCancel
                                                  .toUpperCase(),
                                              style: AppStyles.r1.copyWith(
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              top: 30, left: 15, right: 25),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          decoration: BoxDecoration(
                                            color: AppColors.colorButton,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              showDialogTransferRequest(context,
                                                  controller.requestModel.id);
                                            },
                                            child: Center(
                                                child: Text(
                                              AppLocalizations.of(context)!
                                                  .textTransfer
                                                  .toUpperCase(),
                                              style: AppStyles.r5.copyWith(
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        ))
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    )),
        );
      },
    );
  }

  void showDialogTransferRequest(BuildContext context, int id) {
    Timer(const Duration(milliseconds: 500), () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return DialogTransferRequest(
              id: id,
              onSubmit: () {},
            );
          });
    });
  }

  void showDialogCancelRequest(BuildContext context, int id) {
    Timer(const Duration(milliseconds: 500), () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return DialogCancelRequest(
              onSubmit: () {},
              id: id,
            );
          });
    });
  }

  TableRow buildRow(List<String> cells, bool isHeader) => TableRow(
          children: cells.map(
        (e) {
          return Container(
            color: isHeader ? AppColors.colorBackground2 : Colors.white,
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                e,
                style: AppStyles.r8.copyWith(
                    color: AppColors.colorText5, fontWeight: FontWeight.w400),
              ),
            ),
          );
        },
      ).toList());
}
