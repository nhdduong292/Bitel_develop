import 'dart:async';

import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
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
  RequestDetailModel requestModel;

  DialogSurveyMapPage(
      {super.key, required this.onSubmit, required this.requestModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSurveyMapLogic(context: context, requestModel: requestModel),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0.0,
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 16, right: 16, bottom: 26),
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
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: !controller.isLocation
                        ? Container()
                        : GoogleMap(
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController control) {
                              controller.controllerMap.complete(control);
                            },
                            initialCameraPosition: controller.kGooglePlex,
                            circles: controller.circles,
                            markers: controller.markers,
                            onTap: (argument) {
                              controller.setCircle(argument);
                            },
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 18),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.textTechnology,
                              style: AppStyles.r8.copyWith(
                                  color: AppColors.colorText1.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                            flex: 5,
                            child: spinnerFormV2(
                                context: context,
                                hint: AppLocalizations.of(context)!
                                    .textChooseTechnology,
                                required: false,
                                dropValue: controller.currentTechnology,
                                function: (value) {
                                  controller.setTechnology(value);
                                },
                                listDrop: controller.listTechnology))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!.textRadius,
                              style: AppStyles.r8.copyWith(
                                  color: AppColors.colorText1.withOpacity(0.85),
                                  fontWeight: FontWeight.w400),
                            )),
                        Expanded(
                            flex: 4,
                            child: spinnerFormV2(
                                context: context,
                                hint: controller.currentTechnology == "AON"
                                    ? AppLocalizations.of(context)!
                                        .textMaxRadius3
                                    : AppLocalizations.of(context)!
                                        .textMaxRadius5,
                                inputType: TextInputType.number,
                                required: false,
                                dropValue: "",
                                controlTextField: controller.textFieldRadius,
                                onSubmit: (value) {
                                  controller.setRadius(value);
                                },
                                listDrop: [])),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("m",
                                  style: AppStyles.r8.copyWith(
                                      color: AppColors.colorText1
                                          .withOpacity(0.85),
                                      fontWeight: FontWeight.w400)),
                            ))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // Expanded(
                      //     flex: 1,
                      //     child: Container(
                      //       width: double.infinity,
                      //       margin: const EdgeInsets.only(top: 30),
                      //       padding: const EdgeInsets.symmetric(vertical: 14),
                      //       decoration: BoxDecoration(
                      //         color: controller.isConnect ? AppColors.colorButton :Colors.white,
                      //         borderRadius: BorderRadius.circular(24),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             offset: const Offset(0, 1),
                      //             blurRadius: 2,
                      //             color: Colors.black.withOpacity(0.3),
                      //           ),
                      //         ],
                      //       ),
                      //
                      //       child: InkWell(
                      //         onTap: () {
                      //           if(controller.isConnect){
                      //             Get.back();
                      //             Timer(Duration(milliseconds: 600), () {
                      //               Get.offNamed(RouteConfig.productPayment,
                      //                   arguments:
                      //                   int.parse(requestId));
                      //             },);
                      //
                      //           }
                      //         },
                      //         child:  Center(
                      //             child: Text(
                      //               AppLocalizations.of(context)!.textConnect.toUpperCase(),
                      //               style: controller.isConnect ? AppStyles.r5.copyWith(fontWeight: FontWeight.w500) : AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                      //             )),
                      //       ),
                      //     )),
                      // const SizedBox(width: 15,),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              if (controller.isActive ||
                                  controller.checkValidate(context)) {
                                return;
                              }
                              _onLoading(context);
                              controller.createSurvey(
                                (isSuccess) {
                                  // onSubmit.call(isSuccess);
                                  if (isSuccess) {
                                    showDialogSurveySuccessful(context);
                                  } else {
                                    showDialogSurveyUnsuccessful(
                                        context, requestModel.id);
                                  }
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 30),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: controller.isActive
                                    ? Colors.white
                                    : AppColors.colorButton,
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
                                    .textSurvey
                                    .toUpperCase(),
                                style: controller.isActive
                                    ? AppStyles.r1
                                        .copyWith(fontWeight: FontWeight.w500)
                                    : AppStyles.r5
                                        .copyWith(fontWeight: FontWeight.w500),
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
      },
    );
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

  void showDialogSurveySuccessful(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveySuccessful(
            requestModel.id,
            requestModel.customerModel.type,
            requestModel.customerModel.idNumber,
            (isOnline) {},
          );
        });
  }

  void showDialogSurveyUnsuccessful(BuildContext context, int id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveyUnsuccessful(id, (isOnline) {});
        });
  }
}
