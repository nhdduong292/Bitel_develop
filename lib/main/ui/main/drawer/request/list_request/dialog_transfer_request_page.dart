import 'dart:async';

import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/dialog_transfer_request_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogTransferRequest extends GetWidget {
  final Function? onSubmit;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  DialogTransferRequest({super.key, this.onSubmit});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogTransferRequestLogic(),
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
                    Center(child: Text(
                      AppLocalizations.of(context)!.textTransferRequest,
                      style: AppStyles.r6.copyWith(
                          color: AppColors.colorText1,
                          fontWeight: FontWeight.w500),
                    )),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
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
                    Expanded(flex: 2, child: Text(
                      AppLocalizations.of(context)!.textStaffCode,
                      style: AppStyles.r8.copyWith(
                          color: AppColors.colorText1.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    )),
                    Expanded(
                        flex: 5,
                        child: spinnerFormV2(
                            context: context,
                            hint:
                                AppLocalizations.of(context)!.hintStaffCode,
                            required: false,
                            dropValue: "",
                            listDrop: []))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  children: [
                    Expanded(flex: 2, child:  Text(
                      AppLocalizations.of(context)!.textReason,
                      style: AppStyles.r8.copyWith(
                          color: AppColors.colorText1.withOpacity(0.85),
                          fontWeight: FontWeight.w400),
                    )),
                    Expanded(
                        flex: 5,
                        child: spinnerFormV2(
                            context: context,
                            hint:
                                AppLocalizations.of(context)!.hintReason,
                            required: false,
                            dropValue: controller.currentReason,
                            listDrop: controller.listReason))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30,bottom: 36, left: 16, right: 16),
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
                    AppLocalizations.of(context)!.textTransfer.toUpperCase(),
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
