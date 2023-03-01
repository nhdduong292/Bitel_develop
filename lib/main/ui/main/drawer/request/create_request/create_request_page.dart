
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_successful.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
            child: Text(AppLocalizations.of(context)!.textCreateNewRequest, style: AppStyles.title),
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
                            text: AppLocalizations.of(context)!
                                .textInfoCreateRequest1,
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
                      function: (value) {
                        controller.setService(value);
                      },
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
                                dropValue: controller.currentIdentityType,
                                function: (value) {
                                  controller.setIdentityType(value);
                                },
                                listDrop: controller.listIdentity
                            )
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                            flex: 2,
                          child: Container(
                            height: 45,
                            child: TextField(
                                controller: controller.textFieldIdNumber,
                                keyboardType: TextInputType.number,
                                focusNode: controller.focusIdNumber,
                                textInputAction: TextInputAction.send,
                                style: AppStyles.r2.copyWith(
                                    color: AppColors.colorTitle,
                                    fontWeight: FontWeight.w500),
                                onSubmitted: (value) {
                                  controller.searchNumberContact(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 5,left: 10, right: 10),
                                  hintText: AppLocalizations.of(context)!.hintIdentityNumber,
                                  hintStyle: AppStyles.r2.copyWith(
                                      color: AppColors.colorHint1,
                                      fontWeight: FontWeight.w400),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(width: 1, color: Colors.redAccent)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                                  ),

                                )),
                          ),
                        )
                      ],
                    ),
                    controller.isAddContact ? Container() : Container(
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
                    Container(
                      height: 45,
                      child: TextField(
                          controller: controller.textFieldName,
                          focusNode: controller.focusName,
                          style: AppStyles.r2.copyWith(
                              color: AppColors.colorTitle,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            controller.setName(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 5,left: 10, right: 10),
                            hintText: AppLocalizations.of(context)!.hintContactPerson,
                            hintStyle: AppStyles.r2.copyWith(
                                color: AppColors.colorHint1,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: Colors.redAccent)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),

                          )),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textContactPhone, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      height: 45,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          focusNode: controller.focusPhone,
                          controller: controller.textFieldPhone,
                          style: AppStyles.r2.copyWith(
                              color: AppColors.colorTitle,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            controller.setPhone(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 5,left: 10, right: 10),
                            hintText: AppLocalizations.of(context)!.textContactPhone,
                            hintStyle: AppStyles.r2.copyWith(
                                color: AppColors.colorHint1,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: Colors.redAccent)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),

                          )),
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
                    InkWell(
                      onTap: () {
                        if(controller.listProvince.isEmpty){
                          _onLoading(context);
                          controller.getListProvince((isSuccess) {
                            Get.back();
                          },);
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Color(0xFFE3EAF2))),
                        child: DropdownButtonFormField2(
                          autofocus: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          // selectedItemHighlightColor: Colors.red,
                          focusNode: controller.focusProvince,
                          buttonHeight: 60,
                          buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Color(0xFFE3EAF2))),
                          isExpanded: true,
                          // value: controller.currentProvince.name!.isNotEmpty ? controller.currentProvince.name! : null,
                          onChanged: (value) {
                            controller.setProvince(value!.areaCode!);
                          },

                          items: controller.listProvince.map<DropdownMenuItem<AddressModel>>((AddressModel value) {
                            return DropdownMenuItem(value: value, child: Text(value.name!));
                          }).toList(),
                          style: AppStyles.r2.copyWith(
                              color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                          icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                          hint: Text(
                            AppLocalizations.of(context)!
                                .hintProvince,
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                          },

                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textDistrict, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    InkWell(
                      onTap: () {
                        if(controller.currentProvince.isNotEmpty && controller.listDistrict.isEmpty){
                          _onLoading(context);
                          controller.getListDistrict(controller.currentProvince, (isSuccess) {
                            Get.back();
                          },);
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Color(0xFFE3EAF2))),
                        child: DropdownButtonFormField2(
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          // selectedItemHighlightColor: Colors.red,
                          buttonHeight: 60,
                          focusNode: controller.focusDistrict,
                          buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Color(0xFFE3EAF2))),
                          isExpanded: true,
                          // value: controller.currentDistrict.isNotEmpty ? controller.currentDistrict : null,
                          onChanged: (value) {
                            controller.setDistrict(value!.areaCode!);
                          },
                          items: controller.listDistrict.map<DropdownMenuItem<AddressModel>>((AddressModel value) {
                            return DropdownMenuItem(value: value, child: Text(value.name!));
                          }).toList(),
                          style: AppStyles.r2.copyWith(
                              color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                          icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                          hint: Text(AppLocalizations.of(context)!.hintDistrict,
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textPrecinct, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    InkWell(
                      onTap: () {
                        if(controller.currentDistrict.isNotEmpty && controller.listPrecinct.isEmpty){
                          _onLoading(context);
                          controller.getListPrecincts(controller.currentDistrict, (isSuccess) {
                            Get.back();
                          },);


                        }
                      },
                      child:  Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Color(0xFFE3EAF2))),
                        child: DropdownButtonFormField2(
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                          // selectedItemHighlightColor: Colors.red,
                          buttonHeight: 60,
                          focusNode: controller.focusPrecinct,
                          buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Color(0xFFE3EAF2))),
                          focusColor: Colors.redAccent,
                          isExpanded: true,
                          // value: controller.currentPrecinct.isNotEmpty ? controller.currentPrecinct : null,
                          onChanged: (value) {
                            controller.setPrecinct(value!.areaCode!);
                          },
                          items: controller.listPrecinct.map<DropdownMenuItem<AddressModel>>((AddressModel value) {
                            return DropdownMenuItem(value: value, child: Text(value.name!));
                          }).toList(),
                          style: AppStyles.r2.copyWith(
                              color: AppColors.colorTitle, fontWeight: FontWeight.w500),
                          icon: SvgPicture.asset(AppImages.icDropdownSpinner),
                          hint: Text(AppLocalizations.of(context)!.hintPrecinct,
                            style: AppStyles.r2.copyWith(
                                color: AppColors.colorHint1, fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 10),
                      child: Text( AppLocalizations.of(context)!
                          .textAddress, style: AppStyles.r1.copyWith(fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      height: 45,
                      child: TextField(
                        focusNode: controller.focusAddress,
                          controller: controller.textFieldAddress,
                          style: AppStyles.r2.copyWith(
                              color: AppColors.colorTitle,
                              fontWeight: FontWeight.w500),
                          onSubmitted: (value) {
                            controller.setAddress(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 5,left: 10, right: 10),
                            hintText: AppLocalizations.of(context)!.hintAddress,
                            hintStyle: AppStyles.r2.copyWith(
                                color: AppColors.colorHint1,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: Colors.redAccent)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: const BorderSide(width: 1, color: AppColors.colorLineDash)
                            ),

                          )),
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
                        margin: EdgeInsets.only(top: 30, left: 25, right: 5),
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
                        margin: const EdgeInsets.only(top: 30, left: 5, right: 25),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.colorButton,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: InkWell(
                          onTap: () {
                            _onLoading(context);
                            controller.createRequest((isSuccess, id) {
                              Get.back();
                              if(isSuccess){
                                showDialogSurveyMap(context, controller, id);
                              }else {
                                print("Có lỗi xảy ra");
                              }
                            },);

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
              const SizedBox(height: 50,)
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
             onSubmit: (isOnline){
               _onLoading(context);
               if(isOnline){
                    controller.createSurveyOnline((isSuccess) {
                      Get.back();
                      if(isSuccess){
                        Get.back();
                      }
                    },);
               } else {
                    controller.createSurveyOffline((isSuccess) {
                      Get.back();
                      if(isSuccess){
                        Get.back();
                      }
                    },);
               }
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
                controller.createSurveyOffline((isSuccess) {
                  if(isSuccess){
                    Get.back();
                  }
                },);
            },);
        });
  }

  void showDialogSurveyMap(BuildContext context, CreateRequestLogic controller, int id){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveyMapPage(
            onSubmit: (isSuccess){
                if(isSuccess) {
                  showDialogSurveySuccessful(context, controller);
                } else {
                  showDialogSurveyUnsuccessful(context, controller);
                }
            },requestId: "$id",);
        });
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

}