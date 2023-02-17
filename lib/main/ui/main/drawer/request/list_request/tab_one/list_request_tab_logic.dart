import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:get/get.dart';

class ListRequestTabLogic extends GetxController{
  ListRequestLogic listRequestLogic = Get.find();
  List<RequestModel> listRequest = [];
  bool isLoading = false;
  String status;

  ListRequestTabLogic(this.status);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListRequest(status);
  }

  void getListRequest(String status) async{
    isLoading = true;
    update();
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> params = {
      "service":listRequestLogic.currentService,
      "code":listRequestLogic.currentCode,
      "status":status,
      "province":listRequestLogic.currentProvince,
      "staffCode":listRequestLogic.currentStaffCode,
      "fromDate":listRequestLogic.currentFromDate,
      "toDate":listRequestLogic.currentToDate,
      "key":"",
      "page":"0",
      "pageSize":"10",
      "sort":""
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_LIST_REQUEST,
        params: params,
        onSuccess: (response) {
          if(response.isSuccess){
            print("success :");
            ListRequestResponse listRequestResponse = ListRequestResponse.fromJson(response.data);
            listRequest.addAll(listRequestResponse.list);
          } else {
            print("error: ${response.status}");
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("error: " + error.toString());
          isLoading = false;
          update();
        });
  }
}