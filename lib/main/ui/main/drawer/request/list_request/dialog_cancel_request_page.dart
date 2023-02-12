import 'dart:async';

import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_cancel_request_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogCancelRequest extends GetWidget {
  final Function? onSubmit;

  DialogCancelRequest({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogCancelRequestLogic(),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Stack(
                  children: [
                    Center(
                        child: Text(
                      AppLocalizations.of(context)!.textCancelRequest,
                      style: AppStyles.r6.copyWith(
                          color: AppColors.colorText1,
                          fontWeight: FontWeight.w500),
                    )),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(AppImages.icClose)),
                    )
                  ],
                ),
              ),
              const LineDash(color: AppColors.colorLineDash),
              Container(
                padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          AppLocalizations.of(context)!.textReason,
                          style: AppStyles.r8.copyWith(
                              color: AppColors.colorText1.withOpacity(0.85),
                              fontWeight: FontWeight.w400),
                        )),
                    Expanded(
                        flex: 5,
                        child: spinnerFormV2(
                            context: context,
                            hint: AppLocalizations.of(context)!.hintReason,
                            required: false,
                            dropValue: controller.currentReason,
                            listDrop: controller.listReason))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          AppLocalizations.of(context)!.textNote,
                          style: AppStyles.r8.copyWith(
                              color: AppColors.colorText1.withOpacity(0.85),
                              fontWeight: FontWeight.w400),
                        )),
                    Expanded(
                        flex: 5,
                        child: spinnerFormV2(
                            context: context,
                            hint: AppLocalizations.of(context)!.hintNote,
                            required: false,
                            dropValue: "",
                            listDrop: [],
                            height: 150))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin:
                    EdgeInsets.only(top: 30, bottom: 36, left: 16, right: 16),
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {
                    onSubmit!.call();
                  },
                  child: Center(
                      child: Text(
                    AppLocalizations.of(context)!.textCancel.toUpperCase(),
                    style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
