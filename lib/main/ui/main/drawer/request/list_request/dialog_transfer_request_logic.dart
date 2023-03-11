import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/reason_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogTransferRequestLogic extends GetxController{
  String currentReason="";
  String currentStaffCode = "";
  List<ReasonModel> listReason = [];
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListReason();
  }

  void setStaffCode(String value){
    currentStaffCode = value;
    update();
  }

  void getListReason(){
    Map<String, dynamic> params = {
      "type": Reason.REASON_REQUEST,
    };
    ApiUtil.getInstance()!.get(
      url: "${ApiEndPoints.API_REASONS}",
      params: params,
      onSuccess: (response) {
        if(response.isSuccess){
          List<ReasonModel> list = (response.data['data'] as List)
              .map((postJson) => ReasonModel.fromJson(postJson))
              .toList();
          if(list.isNotEmpty) {
            listReason.addAll(list);
            update();
          }
        }else {

        }
      },
      onError: (error) {

      },);
  }

  bool checkValidate(BuildContext context){
    if(currentStaffCode.isEmpty || currentReason.isEmpty){
      Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
      return true;
    }
    return false;
  }

  void transferRequest(int id, String staffCode, Function(bool isSuccess) callBack) async {
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      "staffCode": staffCode,
      "reason": currentReason
    };
    print("staffCode: $staffCode");
    ApiUtil.getInstance()!.put(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/$id${ApiEndPoints.API_TRANSFER_REQUEST}",
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          Get.back();
          // callBack.call(false);
        });
  }
}