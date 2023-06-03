// ignore_for_file: prefer_const_constructors

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

import '../../../../../utils/common.dart';

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
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.textNoData),
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
                                          fontFamily: 'Barlow'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel.customerModel
                                                .fullName.isEmpty
                                            ? controller.requestModel
                                                    .customerModel.name.isEmpty
                                                ? '---'
                                                : controller.requestModel
                                                    .customerModel.name
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
                                          fontFamily: 'Barlow'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel.customerModel
                                                .telFax.isEmpty
                                            ? "---"
                                            : controller.requestModel
                                                .customerModel.telFax,
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
                                          fontFamily: 'Barlow'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${controller.requestModel.customerModel.type} - ${controller.requestModel.customerModel.idNumber.isEmpty ? "---" : controller.requestModel.customerModel.idNumber}',
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
                                          fontFamily: 'Barlow'),
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.requestModel
                                                .getInstalAddress()
                                                .isEmpty
                                            ? "---"
                                            : controller.requestModel
                                                .getInstalAddress(),
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
                                            fontFamily: 'Barlow'),
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller
                                                  .requestModel
                                                  .subscriptionModel
                                                  .productName
                                                  .isEmpty
                                              ? "---"
                                              : controller
                                                  .requestModel
                                                  .subscriptionModel
                                                  .productName,
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
                                            fontFamily: 'Barlow'),
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller
                                                      .requestModel
                                                      .subscriptionModel
                                                      .pricePlan <
                                                  1
                                              ? "---"
                                              : Common.numberFormat(controller
                                                  .requestModel
                                                  .subscriptionModel
                                                  .pricePlan),
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.contractModel
                                              .contractNo,
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.getBillCycle(controller
                                              .requestModel
                                              .contractModel
                                              .billCycleFrom),
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.contractModel
                                                  .signDate.isNotEmpty
                                              ? Common.convertDateTime(
                                                  controller.requestModel
                                                      .contractModel.signDate)
                                              : "---",
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.getStatusContract(),
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
                                            fontFamily: 'Barlow'),
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
                                            fontFamily: 'Barlow'),
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
                                            fontFamily: 'Barlow'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          controller.requestModel.listWO.isEmpty
                                              ? '---'
                                              : controller.getTeamName(
                                                  controller
                                                      .requestModel.listWO[0]),
                                          textAlign: TextAlign.right,
                                          style: AppStyles.r415263_13_500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 12, left: 15, right: 15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Table(
                                      border: TableBorder.all(),
                                      columnWidths: const {
                                        0: FixedColumnWidth(150),
                                        1: FixedColumnWidth(150),
                                        2: FixedColumnWidth(150),
                                        3: FixedColumnWidth(100),
                                        4: FixedColumnWidth(100),
                                      },
                                      children: List.generate(
                                          controller
                                                  .requestModel.listWO.length +
                                              1, (index) {
                                        if (index == 0) {
                                          return buildRow([
                                            AppLocalizations.of(context)!
                                                .textWOType,
                                            AppLocalizations.of(context)!
                                                .textStaff,
                                            AppLocalizations.of(context)!
                                                .textStatus,
                                            AppLocalizations.of(context)!
                                                .textStartDate,
                                            AppLocalizations.of(context)!
                                                .textEndDate,
                                          ], true);
                                        } else {
                                          WorkOrderModel model = controller
                                              .requestModel.listWO[index - 1];
                                          return buildRow([
                                            model.woType,
                                            controller.getStaffName(model),
                                            model.status,
                                            model.creationDate.isNotEmpty
                                                ? Common.convertDateTime(
                                                    model.creationDate)
                                                : '---',
                                            model.expectedDate.isNotEmpty
                                                ? Common.convertDateTime(
                                                    model.expectedDate)
                                                : '---'
                                          ], false);
                                        }
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: controller.isShowCancel,
                                child: Expanded(
                                    flex: 1,
                                    child: bottomButton(
                                        isBoxShadow: true,
                                        color: Colors.white,
                                        text: AppLocalizations.of(context)!
                                            .textCancel,
                                        onTap: () {
                                          showDialogCancelRequest(context,
                                              controller.requestModel.id);
                                        })),
                              ),
                              controller.isShowBtnConnect
                                  ? Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          if (controller.requestModel.status ==
                                                  RequestStatus
                                                      .CREATE_REQUEST_WITHOUT_SURVEY ||
                                              controller.requestModel.status ==
                                                  RequestStatus
                                                      .SURVEY_OFFLINE_SUCCESSFULLY) {
                                            Get.toNamed(
                                                RouteConfig.productPayment,
                                                arguments: [
                                                  controller.requestModel,
                                                  ProductStatus.Create
                                                ]);
                                          } else if (controller
                                                  .requestModel.status ==
                                              RequestStatus.CONTRACTING) {
                                            //todo show dialog cancel
                                            showDialogChooseProduct(
                                                context, controller);
                                          } else if (controller
                                                      .requestModel.status ==
                                                  RequestStatus.DEPLOYING ||
                                              controller.requestModel.status ==
                                                  RequestStatus.COMPLETE ||
                                              controller.requestModel.status ==
                                                  RequestStatus.CANCEL) {
                                            Get.back();
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 15,
                                              top: 24,
                                              right: 15,
                                              bottom: 10),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: AppColors.colorText3,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xFFB3BBC5),
                                                      blurRadius: 5)
                                                ]),
                                            child: Center(
                                                child: Text(
                                              controller.textConnect
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          controller.isShowBtnCancelTransfer
                              ? Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: bottomButton(
                                            isBoxShadow: true,
                                            color: Colors.white,
                                            text: AppLocalizations.of(context)!
                                                .textCancel,
                                            onTap: () {
                                              showDialogCancelRequest(context,
                                                  controller.requestModel.id);
                                            })),
                                    Expanded(
                                        flex: 1,
                                        child: bottomButton(
                                            text: AppLocalizations.of(context)!
                                                .textTransfer,
                                            onTap: () {
                                              showDialogTransferRequest(context,
                                                  controller.requestModel.id);
                                            }))
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
          return DialogCancelRequest(
            onSubmit: () {},
            id: id,
          );
        });
  }

  void showDialogChooseProduct(
      BuildContext context, RequestDetailLogic controller) {
    showDialog(
        context: context,
        builder: (context) {
          return ChooseProductAgainDialog(
            context: context,
            onAgain: () {
              Get.toNamed(RouteConfig.productPayment,
                  arguments: [controller.requestModel, ProductStatus.ReSelect]);
            },
            onContinue: () {
              Get.toNamed(RouteConfig.resignContract);
            },
          );
        });
  }

  TableRow buildRow(List<String> cells, bool isHeader) => TableRow(
      decoration: BoxDecoration(
        color: isHeader ? AppColors.colorBackground2 : Colors.white,
      ),
      children: cells.map(
        (e) {
          return Container(
            // color: isHeader ? Color.fromARGB(255, 189, 189, 218) : Colors.white,
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

class ChooseProductAgainDialog extends Dialog {
  BuildContext context;
  Function onContinue;
  Function onAgain;
  ChooseProductAgainDialog({
    required this.context,
    required this.onContinue,
    required this.onAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Wrap(children: [
        Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            SvgPicture.asset(AppImages.imgNotify),
            const SizedBox(
              height: 15,
            ),
            const DottedLine(
              dashColor: AppColors.colorLineDash,
              dashGapLength: 3,
              dashLength: 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      AppLocalizations.of(context)!
                          .textDoYouWantToContinueOrChooseTheProduct,
                      style: AppStyles.r415263_14_600.copyWith(fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: bottomButtonV2(
                              text: AppLocalizations.of(context)!.textAgain,
                              onTap: () {
                                Get.back();
                                onAgain();
                              })),
                      Expanded(
                          child: bottomButton(
                              text: AppLocalizations.of(context)!.textContinue,
                              onTap: () {
                                Get.back();
                                onContinue();
                              }))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
