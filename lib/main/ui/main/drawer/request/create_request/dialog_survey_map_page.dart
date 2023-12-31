import 'dart:async';

import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/transfer_service/create_transfer_service_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_successful.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_unsuccesful.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

class DialogSurveyMapPage extends GetWidget {
  final Function(bool isSuccess) onSubmit;
  RequestDetailModel requestModel;
  bool isTimekeeping;

  DialogSurveyMapPage(
      {super.key,
      required this.onSubmit,
      required this.requestModel,
      required this.isTimekeeping});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogSurveyMapLogic(
          context: context,
          requestModel: requestModel,
          isTimekeeping: isTimekeeping),
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0.0,
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 16, right: 16, bottom: 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(AppImages.icClose)),
                  ),
                  Visibility(
                    visible: !isTimekeeping,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        controller.getCurrentLocation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 229, 222, 226)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset(
                                  AppImages.icCurrentLocation,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .textUseMyCurrentLocation,
                                style: AppStyles.bText1_14_500,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                    child: GoogleMap(
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
                  Visibility(
                    visible: !isTimekeeping,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 18),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .textTechnology,
                                    style: AppStyles.r8.copyWith(
                                        color: AppColors.colorText1
                                            .withOpacity(0.85),
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
                                        color: AppColors.colorText1
                                            .withOpacity(0.85),
                                        fontWeight: FontWeight.w400),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: spinnerFormV2(
                                      context: context,
                                      hint:
                                          controller.currentTechnology == "AON"
                                              ? AppLocalizations.of(context)!
                                                  .textMaxRadius3
                                              : AppLocalizations.of(context)!
                                                  .textMaxRadius5,
                                      inputType: TextInputType.number,
                                      required: false,
                                      dropValue: "",
                                      controlTextField:
                                          controller.textFieldRadius,
                                      function: (value) {
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
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.isSuccessGetLocation,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: bottomButton(
                                color: AppColors.colorButton,
                                text: AppLocalizations.of(context)!.textReload,
                                onTap: () {
                                  controller.getLocationAddress(true);
                                }))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.isSuccessGetLocation &&
                        !(isTimekeeping &&
                            (controller.checkInModel.isCheckin == null)),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: bottomButton(
                                color: controller.isActive
                                    ? Colors.white
                                    : AppColors.colorButton,
                                text: isTimekeeping
                                    ? controller.checkInModel.isCheckin ?? false
                                        ? AppLocalizations.of(context)!
                                            .textCheckIn
                                        : AppLocalizations.of(context)!
                                            .textCheckOut
                                    : AppLocalizations.of(context)!.textSurvey,
                                onTap: () async {
                                  if (controller.isActive ||
                                      controller.checkValidate(context)) {
                                    return;
                                  }

                                  if (isTimekeeping) {
                                    final service = FlutterBackgroundService();
                                    var isRunning = await service.isRunning();
                                    if (controller.checkInModel.isCheckin ==
                                        null) {
                                      return;
                                    }
                                    if (!controller.checkInModel.isCheckin!) {
                                      controller.checkOut(
                                          controller.currentPoint, (isSuccess) {
                                        if (isSuccess) {
                                          controller.checkInModel.isCheckin =
                                              null;
                                          controller.update();
                                          if (isRunning) {
                                            service.invoke("stopService");
                                          }
                                        }
                                      });
                                    } else {
                                      controller.checkIn(
                                          controller.currentPoint, (isSuccess) {
                                        if (isSuccess) {
                                          controller.checkInModel.isCheckin =
                                              null;
                                          controller.update();
                                          service.startService();
                                        }
                                      });
                                    }
                                    return;
                                  }

                                  FocusScope.of(context).unfocus();

                                  bool isExit = Get.isRegistered<
                                      CreateTransferServiceLogic>();
                                  if (isExit) {
                                    _onLoading(context);
                                    controller.createSurveyTransfer(
                                      (isSuccess) {
                                        // onSubmit.call(isSuccess);
                                        if (isSuccess) {
                                          showDialogSurveySuccessful(context);
                                        } else {
                                          try {
                                            showDialogSurveyUnsuccessful(
                                                context, requestModel.id);
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                        }
                                      },
                                    );
                                    return;
                                  }

                                  _onLoading(context);
                                  controller.createSurvey(
                                    (isSuccess) {
                                      // onSubmit.call(isSuccess);
                                      if (isSuccess) {
                                        showDialogSurveySuccessful(context);
                                      } else {
                                        try {
                                          showDialogSurveyUnsuccessful(
                                              context, requestModel.id);
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      }
                                    },
                                  );
                                }))
                      ],
                    ),
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
            requestModel,
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
