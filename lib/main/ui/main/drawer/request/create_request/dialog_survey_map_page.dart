import 'dart:async';

import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_successful.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_unsuccesful.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogSurveyMapPage extends GetWidget {
  final Function(bool isSuccess) onSubmit;
  String requestId;
  DialogSurveyMapPage({super.key, required this.onSubmit, required this.requestId});





  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSurveyMapLogic(requestId: requestId),
      builder: (controller) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child:SingleChildScrollView(
          child:  Padding(
            padding:
            const EdgeInsets.only(top: 22, left: 16, right: 16, bottom: 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(AppImages.icClose)),
                ),
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: !controller.isLocation ? Container() : GoogleMap(
                    onMapCreated: (GoogleMapController control) {
                      controller.controllerMap.complete(control);
                    },
                    initialCameraPosition: controller.kGooglePlex,
                    circles: controller.circles,
                    markers: controller.markers,
                    mapType: MapType.normal,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textTechnology,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint:
                              AppLocalizations.of(context)!.textChooseTechnology,
                              required: false,
                              dropValue: "",
                              function: (value) {
                                controller.setTechnology(value);
                              },
                              listDrop: controller.listTechnology))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child:  Text(
                        AppLocalizations.of(context)!.textRadius,
                        style: AppStyles.r8.copyWith(
                            color: AppColors.colorText1.withOpacity(0.85),
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 5,
                          child: spinnerFormV2(
                              context: context,
                              hint: AppLocalizations.of(context)!.textMaxRadius,
                              inputType: TextInputType.number,
                              required: false,
                              dropValue: "",
                              function: (value) {
                                controller.setRadius(value);
                              },
                              listDrop: []))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 30),
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
                              Get.back();
                            },
                            child:  Center(
                                child: Text(
                                  AppLocalizations.of(context)!.textConnect.toUpperCase(),
                                  style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                                )),
                          ),
                        )),
                    SizedBox(width: 15,),
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 30),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: InkWell(
                            onTap: () {
                              // _onLoading(context);
                              controller.createSurvey((isSuccess) {
                              //     Get.back();
                                  onSubmit.call(isSuccess);
                              },);
                              // onSubmit!.call();
                            },
                            child:  Center(
                                child: Text(
                                  AppLocalizations.of(context)!.textSurvey.toUpperCase(),
                                  style: AppStyles.r5.copyWith(fontWeight: FontWeight.w500),
                                )),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }

  void showDialogSurveySuccessful(BuildContext context){
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return DialogSurveySuccessful(
    //         onSubmit: (){
    //           // controller.createRequest();
    //         },);
    //     });
  }

  void showDialogSurveyUnsuccessful(BuildContext context){
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (context) {
    //       return DialogSurveyUnsuccessful(
    //         onSubmit: (){
    //           // controller.createRequest();
    //         },);
    //     });
  }
}
