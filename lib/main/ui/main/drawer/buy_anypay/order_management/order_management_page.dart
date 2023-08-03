import 'package:bitel_ventas/main/networks/model/buy_anypay_comfirm_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/order_management/order_management_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/info_bussiness.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../networks/model/buy_anypay_create_model.dart';
import '../../../../../networks/model/buy_anypay_search_model.dart';

class OrderManagementPage extends GetWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: OrderManagementLogic(context: context),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.textOrderManagement,
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
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 20, left: 15, right: 15, bottom: 20),
                        padding: const EdgeInsets.only(
                            left: 16, top: 13, bottom: 13, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              width: 1, color: AppColors.colorLineDash),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              color: AppColors.colorLineDash,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                  AppLocalizations.of(context)!.textBankCode,
                                  style: AppStyles.r8.copyWith(
                                      color: AppColors.colorText1
                                          .withOpacity(0.85),
                                      fontWeight: FontWeight.w400)),
                            ),
                            spinnerFormV2(
                                context: context,
                                hint:
                                    AppLocalizations.of(context)!.hintEnterCode,
                                required: false,
                                dropValue: "",
                                function: (value) {
                                  controller.textBankCode = value;
                                },
                                onSubmit: (value) {},
                                listDrop: []),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              child: Text(
                                  AppLocalizations.of(context)!.textStatus,
                                  style: AppStyles.r8.copyWith(
                                      color: AppColors.colorText1
                                          .withOpacity(0.85),
                                      fontWeight: FontWeight.w400)),
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: const Color(0xFFE3EAF2))),
                              child: DropdownButtonFormField2(
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                // selectedItemHighlightColor: Colors.red,
                                buttonPadding:
                                    const EdgeInsets.only(left: 0, right: 10),
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        color: const Color(0xFFE3EAF2))),
                                isExpanded: true,
                                value: controller.currentStatus.isNotEmpty
                                    ? controller.currentStatus
                                    : null,
                                onChanged: (value) {
                                  controller.setStatus(value!);
                                },
                                buttonHeight: 60,
                                items: controller
                                    .getListStatus()
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                style: AppStyles.r2.copyWith(
                                    color: AppColors.color_415263,
                                    fontWeight: FontWeight.w500),
                                icon: SvgPicture.asset(
                                    AppImages.icDropdownSpinner),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select gender.';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              child: Text(
                                  AppLocalizations.of(context)!.textOrderDate,
                                  style: AppStyles.r8.copyWith(
                                      color: AppColors.colorText1
                                          .withOpacity(0.85),
                                      fontWeight: FontWeight.w400)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        _selectDate(context, controller, true);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFFE3EAF2))),
                                        padding: const EdgeInsets.only(
                                            top: 11,
                                            bottom: 11,
                                            left: 16,
                                            right: 16),
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible:
                                                  controller.from.value.isEmpty,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: SvgPicture.asset(
                                                    AppImages.icSelectDate),
                                              ),
                                            ),
                                            Text.rich(TextSpan(
                                                style: AppStyles.r2.copyWith(
                                                    color: controller
                                                            .from.value.isEmpty
                                                        ? AppColors.colorHint1
                                                        : AppColors.colorText1,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                            .from.value.isEmpty
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .textFrom
                                                        : controller.from.value,
                                                  )
                                                ])),
                                          ],
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        _selectDate(context, controller, false);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            border: Border.all(
                                                color:
                                                    const Color(0xFFE3EAF2))),
                                        padding: const EdgeInsets.only(
                                            top: 11,
                                            bottom: 11,
                                            left: 16,
                                            right: 16),
                                        child: Row(
                                          children: [
                                            Visibility(
                                              visible:
                                                  controller.to.value.isEmpty,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: SvgPicture.asset(
                                                    AppImages.icSelectDate),
                                              ),
                                            ),
                                            Text.rich(TextSpan(
                                                style: AppStyles.r2.copyWith(
                                                    color: controller
                                                            .to.value.isEmpty
                                                        ? AppColors.colorHint1
                                                        : AppColors.colorText1,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: [
                                                  TextSpan(
                                                    text: controller
                                                            .to.value.isEmpty
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .textTo
                                                        : controller.to.value,
                                                  )
                                                ])),
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        controller.isSearched = true;

                        controller.searchBuyAnyPay(
                            bankCode: controller.textBankCode,
                            status: controller.currentStatus,
                            from: controller.from.value,
                            to: controller.to.value);
                        controller.update();
                      },
                      child: Container(
                        width: width / 2,
                        margin: const EdgeInsets.only(
                            bottom: 30, left: 25, right: 25, top: 20),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!
                              .textSearch
                              .toUpperCase(),
                          style: AppStyles.r5
                              .copyWith(fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    Visibility(
                      visible: controller.isSearched,
                      child: Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(top: 1, left: 10, right: 10),
                        padding: const EdgeInsets.only(
                            left: 16, top: 13, bottom: 13, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              width: 1, color: AppColors.colorLineDash),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              color: AppColors.colorLineDash,
                            ),
                          ],
                        ),
                        constraints: const BoxConstraints(minHeight: 200),
                        child: controller.isLoading
                            ? LoadingCirculApi()
                            : controller.listBuyAnyPay.isNotEmpty
                                ? ListView.separated(
                                    padding: const EdgeInsets.only(top: 0),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) {
                                      return _itemOrderSearch(
                                        controller: controller,
                                        buyAnyPayModel:
                                            controller.listBuyAnyPay[index],
                                        index: index,
                                        onDelete: (value) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ConfirmDialog(
                                                height: 277,
                                                bankNumber: controller
                                                    .listBuyAnyPay[value]
                                                    .saleOrderCode,
                                                onSuccess: () {
                                                  controller.deleteBuyAnyPay(
                                                      saleOrderId: controller
                                                          .listBuyAnyPay[value]
                                                          .saleOrderId,
                                                      isSuccess: (isSuccess) {
                                                        if (isSuccess) {
                                                          Get.back();
                                                          controller.searchBuyAnyPay(
                                                              bankCode: controller
                                                                  .textBankCode,
                                                              status: controller
                                                                  .currentStatus,
                                                              from: controller
                                                                  .from.value,
                                                              to: controller
                                                                  .to.value);
                                                          Common.showToastCenter(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .textCancelBuyAnyPaySuccess,
                                                              context);
                                                        }
                                                      });
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: AppColors.colorLineDash,
                                        height: 1,
                                        thickness: 1,
                                      );
                                    },
                                    itemCount: controller.listBuyAnyPay.length)
                                : Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .textNoResultIsFound),
                                  ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 50, left: 10, right: 10, bottom: 50),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                              width: 1, color: AppColors.colorLineDash),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              color: AppColors.colorLineDash,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .textTitleAnypay1,
                                  style: AppStyles.r415263_14_600,
                                  children: [
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .textTitleAnypay2,
                                        style: AppStyles.r415263_14_400)
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: SvgPicture.asset(
                                              AppImages.icAnypayBBVA)),
                                      const VerticalDivider(
                                        color: AppColors.colorLineDash,
                                      ),
                                      Expanded(
                                          child: SvgPicture.asset(
                                              AppImages.icAnypayBCP))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  _selectDate(
      BuildContext context, OrderManagementLogic control, bool from) async {
    var selecDate = from ? control.fromDate : control.toDate;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selecDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked == null) {
      return;
    }
    if (from) {
      control.setFromDate(picked);
    } else {
      control.setToDate(picked);
    }
  }
}

class _itemOrderSearch extends StatelessWidget {
  BuyAnyPaySearchModel buyAnyPayModel;
  OrderManagementLogic controller;
  int index;
  var onDelete;
  _itemOrderSearch(
      {required this.controller,
      required this.buyAnyPayModel,
      required this.index,
      required this.onDelete});
  @override
  Widget build(BuildContext context) {
    Color? colorStatus;
    if (buyAnyPayModel.status == 'NEW') {
      colorStatus = AppColors.colorBackground3;
    } else if (buyAnyPayModel.status == 'PAID') {
      colorStatus = Colors.grey;
    } else if (buyAnyPayModel.status == 'SOLD') {
      colorStatus = Colors.orange;
    } else {
      colorStatus = Colors.red;
    }
    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(buyAnyPayModel.saleOrderCode,
                                style: AppStyles.bContent_17_700
                                    .copyWith(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Visibility(
                            visible: buyAnyPayModel.status == 'NEW',
                            child: Container(
                              margin: const EdgeInsets.only(left: 8, right: 10),
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9),
                                border: Border.all(
                                    width: 1, color: AppColors.colorContent),
                              ),
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: buyAnyPayModel.saleOrderCode));
                                  Common.showToastCenter(
                                      AppLocalizations.of(context)!
                                          .textCopySuccess,
                                      context);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.icCopyOrder),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.textCopy,
                                      style: AppStyles.bContent_10_400,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            'S/ ${buyAnyPayModel.totalToPay} (${buyAnyPayModel.quantity} ANYPAY)',
                            style: AppStyles.bText1_14_500,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            Common.convertDateTime(
                                buyAnyPayModel.saleOrderDate, 'HH:mm'),
                            style: AppStyles.bText1_13_300,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  )),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 2),
                      margin: const EdgeInsets.only(right: 9),
                      decoration: BoxDecoration(
                        color: colorStatus,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        controller.getTextStatus(buyAnyPayModel.status),
                        style: AppStyles.rText1_13_500
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const VerticalDivider(
                      color: AppColors.colorLineDash,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: buyAnyPayModel.status == 'NEW',
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            onDelete(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SvgPicture.asset(AppImages.icDeleteOrder),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ConfirmDialog extends Dialog {
  final double height;
  String bankNumber;
  var onSuccess;

  ConfirmDialog(
      {super.key,
      required this.height,
      required this.bankNumber,
      required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
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
            Text(
              AppLocalizations.of(context)!.textConfirm,
              style: AppStyles.r16,
            ),
            const SizedBox(
              height: 16,
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
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                '${AppLocalizations.of(context)!.textAreYouSureToCancel} $bankNumber?',
                style: AppStyles.r15,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: bottomButtonV2(
                        text: AppLocalizations.of(context)!.textCancel,
                        onTap: () => Get.back())),
                Expanded(
                    child: bottomButton(
                        text: AppLocalizations.of(context)!.textConfirm,
                        onTap: () {
                          onSuccess();
                        }))
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ]),
    );
  }
}
