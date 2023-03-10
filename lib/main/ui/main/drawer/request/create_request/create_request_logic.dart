import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/model/contact_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/networks/response/search_contact_response.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRequestLogic extends GetxController {
  String currentService = "FTTH";
  List<String> listService = ["FTTH", "OFFICE_WAN", "LEASED_LINE"];
  String currentIdentityType = "DNI";
  String currentIdentity = "";
  List<String> listIdentity = ["DNI", "CE", "PP", "PTP"];
  AddressModel currentProvince = AddressModel();
  List<AddressModel> listProvince = [];
  AddressModel currentDistrict = AddressModel();
  List<AddressModel> listDistrict = [];
  AddressModel currentPrecinct = AddressModel();
  List<AddressModel> listPrecinct = [];
  String currentAddress = "";
  bool isAddContact = true;
  ContactModel contactModel = ContactModel();
  bool isLoading = false;
  String currentName ="";
  String currentPhone = "";
  bool isCheckAgree = true;

  TextEditingController textFieldIdNumber = TextEditingController();
  TextEditingController textFieldPhone = TextEditingController();
  TextEditingController textFieldName = TextEditingController();
  TextEditingController textFieldProvince = TextEditingController();
  TextEditingController textFieldDistrict = TextEditingController();
  TextEditingController textFieldPrecinct = TextEditingController();
  TextEditingController textFieldAddress = TextEditingController();
  FocusNode focusIdNumber = FocusNode();
  FocusNode focusName = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusProvince = FocusNode();
  FocusNode focusDistrict = FocusNode();
  FocusNode focusPrecinct = FocusNode();
  FocusNode focusAddress = FocusNode();
  RequestModel requestModel = RequestModel();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getMaxLengthIdNumber(currentIdentityType);
  }

  void setIdentityType(String value){
    currentIdentityType = value;
    update();
  }

  void setPrecinct(AddressModel value){
    if(value.name == currentPrecinct.name) return;
    currentPrecinct = value;
    textFieldPrecinct.text = value.name;
    update();
  }
  void setDistrict(AddressModel value){
    if(value.name == currentDistrict.name) return;
    currentDistrict = value;
    textFieldDistrict.text = value.name;
    textFieldPrecinct.text = "";
    listPrecinct.clear();
    update();
  }

  void setProvince(AddressModel value){
    if(value.name == currentProvince.name) return;
    currentProvince = value;
    textFieldProvince.text = value.name;
    textFieldDistrict.text = "";
    textFieldPrecinct.text = "";
    listDistrict.clear();
    listPrecinct.clear();
    update();
  }
  void setAddress(String value){
    currentAddress = value;
    update();
  }

  void setName(String value){
    currentName = value;
    update();
  }

  void setPhone(String value){
    currentPhone = value;
    update();
  }

  void setService(String value){
    currentService = value;
    update();
  }

  bool checkValidateCreate(){
    if(textFieldIdNumber.value.text.isEmpty){
      focusIdNumber.requestFocus();
      return true;
    }
    if(textFieldName.value.text.isEmpty){
      focusName.requestFocus();
      return true;
    }
    if(textFieldPhone.value.text.isEmpty || textFieldPhone.value.text.length < 9) {
      focusPhone.requestFocus();
      Common.showToastCenter("Số điện thoại ít nhất phải 9 chữ số");
      return true;
    }
    // if(currentProvince.isEmpty){
    //   focusProvince.requestFocus();
    //   return true;
    // }
    // if(currentDistrict.isEmpty){
    //   focusDistrict.requestFocus();
    //   return true;
    // }
    // if(currentPrecinct.isEmpty){
    //   focusPrecinct.requestFocus();
    //   return true;
    // }
    if(textFieldAddress.value.text.isEmpty){
      focusAddress.requestFocus();
      return true;
    }
    if(!isCheckAgree || currentIdentity.isEmpty || currentName.isEmpty|| currentPhone.isEmpty || currentProvince.name.isEmpty || currentPrecinct.name.isEmpty || currentDistrict.name.isEmpty || currentAddress.isEmpty){
      Common.showToastCenter("Vui lòng nhập đầy đủ thông tin!");
      return true;
    }
    return false;
  }

  void createRequest(Function(bool isSuccess, int id) function) async {
    Map<String, dynamic> body = {
      "address": currentAddress.trim(),
      "district": currentDistrict.name.trim(),
      "idNumber": currentIdentity.trim(),
      "name": currentName.trim(),
      "phone": currentPhone.trim(),
      "precinct": currentPrecinct.name.trim(),
      "province": currentProvince.name.trim(),
      "service": currentService.trim(),
      "identityType": currentIdentityType.trim()
    };
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_CREATE_REQUEST,
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            requestModel = RequestModel.fromJson(response.data['data']);
            update();
            print("success");
            function.call(true,requestModel.id);
          } else {
            print("error: ${response.status}");
            function.call(false,0);
          }
        },
        onError: (error) {
          function.call(false,0);
        });
  }


  void setIdentity(String value){
    currentIdentity = value;
    update();
  }

  void searchNumberContact(String id) async {
    Map<String, dynamic> params = {
      "phone": "",
      "identityType": currentIdentityType,
      "idNumber": id,
      "page": "0",
      "pageSize": "10",
      "sort": "createdDate"
    };
    ApiUtil.getInstance()!.get(
        url: "${ApiEndPoints.API_SEARCH_CONTACT}",
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            SearchContactResponse contactResponse = SearchContactResponse.fromJson(response.data['data']);
            if(contactResponse.list.isNotEmpty){
              contactModel = contactResponse.list[0];
              print("${contactModel.toString()}");
            }
          } else {
            print("error: ${response.status}");
            isAddContact = false;
            update();
          }
        },
        onError: (error) {
        });
  }

  void getListProvince(Function(bool isSuccess) function) async{
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PROVINCES,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listProvince = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listProvince.isNotEmpty){
              update();
            }
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }

        },
        onError: (error) {
          function.call(false);
        });
  }

  void getListPrecincts(String areaCode, Function(bool isSuccess) function) async{
    Map<String, dynamic> params = {
      "areaCode":areaCode
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PRECINCTS,
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listPrecinct = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listPrecinct.isNotEmpty){
              update();
            }
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }

        },
        onError: (error) {
          function.call(false);
        });
  }

  void getListDistrict(String areaCode, Function(bool isSuccess) function) async{

    Map<String, dynamic> params = {
      "areaCode":areaCode
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_DISTRICTS,
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listDistrict = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listDistrict.isNotEmpty){
              update();
            }
            function.call(true);
          } else {
            print("error: ${response.status}");
            function.call(false);
          }

        },
        onError: (error) {
          function.call(false);
        });
  }

  void createSurveyOffline(Function (bool isSuccess) callBack) async{
    Map<String, dynamic> body = {
      "status": RequestStatus.CREATE_REQUEST,
      "reasonId": "",
      "note": ""
    };
    ApiUtil.getInstance( )!.put(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/${requestModel.id}${ApiEndPoints.API_CHANGE_STATUS_REQUEST}",
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            // requestModel = RequestModel.fromJson(response.data);
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
        });
  }

  void createSurveyOnline(Function(bool isSuccess) callBack) async{
    ApiUtil.getInstance( )!.get(
        url: "${ApiEndPoints.API_SURVEY}/${requestModel.id}${ApiEndPoints.API_SURVEY_ONLINE}",
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
          callBack.call(false);
        });
  }

  void setCheckAgree(bool value){
    isCheckAgree = value;
    update();
  }

  int getMaxLengthIdNumber(String value){
    if(value == listIdentity[0]){
      return 8;
    } else if(value == listIdentity[2]){
      return 15;
    } else {
      return 9;
    }
  }

}
