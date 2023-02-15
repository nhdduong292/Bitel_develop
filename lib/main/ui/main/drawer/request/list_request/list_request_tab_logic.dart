import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:get/get.dart';

class ListRequestTabLogic extends GetxController{
  List<RequestModel> listRequest = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListRequest();
  }

  void getListRequest(){
    Map<String, dynamic> params = {
      "page":"0",
      "pageSize":"10",
      "sort":"createdDate"
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_LIST_REQUEST,
        params: params,
        onSuccess: (response) {
          if(response.isSuccess){
            print("success :");
            ListRequestResponse listRequestResponse = ListRequestResponse.fromJson(response.data);
            listRequest.addAll(listRequestResponse.list);
            update();
          } else {
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          print("error: " + error.toString());
        });
  }
}