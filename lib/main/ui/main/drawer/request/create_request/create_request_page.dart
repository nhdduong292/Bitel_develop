
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_successful.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dialog_survey_unsuccesful.dart';

class CreateRequestPage extends GetWidget{
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: CreateRequestLogic(),
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
            child: Text("Create new request", style: AppStyles.title),
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        iconChecked(),
                        SizedBox(width: 14,),
                        Expanded(
                          flex: 1,
                            child: RichText(
                          text: TextSpan(
                            text: "I freely, previously, expressly, informed and unequivocally accept authorize Bitel to carry out the ",
                            style: AppStyles.r2.copyWith(color: AppColors.colorText1),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: 'processing of my personal and sensitive data',
                                  style: TextStyle(color: AppColors.colorUnderText, decoration: TextDecoration.underline)),
                              TextSpan(
                                  text: ", with the collection of the same"
                              )
                            ],

                          ),
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textChooseService, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                      context: context,
                      hint: AppLocalizations.of(context)!
                          .textChooseService,
                      required: false,
                      dropValue: controller.currentService,
                      listDrop: controller.listService
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textIdentityNumber, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1
                        , child: spinnerFormV2(
                                context: context,
                                hint: AppLocalizations.of(context)!
                                    .hintIdentityNumber,
                                required: false,
                                dropValue: controller.currentIdentity,
                                listDrop: controller.listIdentity
                            )
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                            flex: 2, child: spinnerFormV2(
                            context: context,
                            hint: AppLocalizations.of(context)!
                                .hintIdentityNumber,
                            required: false,
                            dropValue: "",
                            listDrop: []
                        )
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500, color: AppColors.colorTitle,decoration: TextDecoration.underline),AppLocalizations.of(context)!
                          .textAddNewContact.toUpperCase()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text(AppLocalizations.of(context)!
                          .textContactPerson, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                        context: context,
                        hint: AppLocalizations.of(context)!
                            .hintContactPerson,
                        required: false,
                        dropValue: "",
                        listDrop: []
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textContactPhone, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                        context: context,
                        hint: AppLocalizations.of(context)!
                            .textContactPhone,
                        required: false,
                        dropValue: "",
                        listDrop: [],
                        inputType: TextInputType.number
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Text( AppLocalizations.of(context)!
                              .textSurveyAddress, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          child: SvgPicture.asset(AppImages.icSurveyAddress),
                          onTap: () {
                            // showDialogSurveyMap(context);
                          },
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textProvince, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                        context: context,
                        hint: AppLocalizations.of(context)!
                            .hintProvince,
                        required: false,
                        dropValue: controller.currentProvince,
                        listDrop: controller.listProvince
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textDistrict, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                        context: context,
                        hint: AppLocalizations.of(context)!
                            .hintDistrict,
                        required: false,
                        dropValue: controller.currentDistrict,
                        listDrop: controller.listDistrict
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textPrecinct, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                        context: context,
                        hint: AppLocalizations.of(context)!
                            .hintPrecinct,
                        required: false,
                        dropValue: controller.currentPrecinct,
                        listDrop: controller.listPrecinct
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textAddress, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    spinnerFormV2(
                        context: context,
                        hint: AppLocalizations.of(context)!
                            .hintAddress,
                        required: false,
                        dropValue: controller.currentAddress,
                        listDrop: controller.listAddress
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
                        margin: EdgeInsets.only(top: 30, left: 25, right: 25),
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
                                AppLocalizations.of(context)!.textCancel.toUpperCase(),
                                style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),
                              )),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30, left: 25, right: 25),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialogSurveyMap(context, controller);
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
              SizedBox(height: 50,)
            ],
          ),
        ),
      );
    },);
  }
  
  void showDialogSurveySuccessful(BuildContext context, CreateRequestLogic controller){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
           return DialogSurveySuccessful(
             onSubmit: (){
               controller.createRequest();
           },);
        });
  }

  void showDialogSurveyUnsuccessful(BuildContext context, CreateRequestLogic controller){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveyUnsuccessful(
            onSubmit: (){
                controller.createRequest();
            },);
        });
  }

  void showDialogSurveyMap(BuildContext context, CreateRequestLogic controller){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveyMap(
            onSubmit: (){
                bool isOffline = false;
                if(isOffline) {
                  showDialogSurveySuccessful(context, controller);
                } else {
                  showDialogSurveyUnsuccessful(context, controller);
                }
            },);
        });
  }

}