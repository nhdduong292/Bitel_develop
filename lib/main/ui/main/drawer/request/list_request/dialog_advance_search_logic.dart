import 'dart:math';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:get/get.dart';

class DialogAdvanceSearchLogic extends GetxController {
  var fromDate = "".obs;
  var toDate = "".obs;
  DateTime selectDate = DateTime.now();
  String currentReason = "";
  List<String> listReason = ["HN", "HCM", "PQ"];
  String currentService = "FTTH";
  List<String> listService = ["FTTH", "Office Wan", "Leased Line"];
  String currentStatus="";
  List<String> listStatus = ["CREATE_REQUEST","CREATE_REQUEST_WITHOUT_SURVEY","CONNECTED","DEPLOYING","COMPLETE","CANCEL"];
  String currentProvince = "";
  List<AddressModel> listProvince = [];

  void setToDate(DateTime picked) {
    toDate.value = "${picked.day}/${picked.month}";
    update();
  }

  void setFromDate(DateTime picked) {
    fromDate.value = "${picked.day}/${picked.month}";
    update();
  }

  void setStatus(String value){
    currentStatus = value;
    update();
  }

  void getListProvince(Function(bool isSuccess) function) async{
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PROVINCES,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listProvince = (response.data as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listProvince.isNotEmpty){
              update();
            }
          } else {
            print("error: ${response.status}");
          }
          function.call(false);

        },
        onError: (error) {
          print("error: " + error.toString());
          function.call(false);
        });
  }
}
