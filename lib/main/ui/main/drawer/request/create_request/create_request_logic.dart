import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/model/contact_model.dart';
import 'package:bitel_ventas/main/networks/response/search_contact_response.dart';
import 'package:get/get.dart';

class CreateRequestLogic extends GetxController {
  String currentService = "FTTH";
  List<String> listService = ["FTTH", "Office Wan", "Leased Line"];
  String currentIdentity = "DNI";
  List<String> listIdentity = ["DNI", "CE", "PP", "PTP"];
  String currentProvince = "";
  List<AddressModel> listProvince = [];
  String currentDistrict = "";
  List<AddressModel> listDistrict = [];
  String currentPrecinct = "";
  List<AddressModel> listPrecinct = [];
  String currentAddress = "";
  List<String> listAddress = ["TDP", "Xa", "Phuong"];
  bool isAddContact = true;
  ContactModel contactModel = ContactModel();
  bool isLoading = false;

  void createRequest() async {
    Map<String, dynamic> body = {
      "address": "proid",
      "district": "irure magna in",
      "idNumber": "1234564",
      "name": "amet",
      "phone": "097845535634563",
      "precinct": "nisi",
      "province": "ea est magna esse ut",
      "service": "FTTH",
      "identityType": "PTP"
    };
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_CREATE_REQUEST,
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
          } else {
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          print("error: " + error.toString());
        });
  }

  void searchNumberContact(String id) async {
    Map<String, dynamic> params = {
      "phone": "",
      "identityType": currentIdentity,
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
            SearchContactResponse contactResponse = SearchContactResponse.fromJson(response.data);
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
          print("error: " + error.toString());
        });
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
            listPrecinct = (response.data as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listPrecinct.isNotEmpty){
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
            listDistrict = (response.data as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listDistrict.isNotEmpty){
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
