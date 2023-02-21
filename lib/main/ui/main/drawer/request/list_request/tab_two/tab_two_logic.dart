import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:get/get.dart';

class TabTwoLogic extends GetxController{
  List<RequestModel> listRequest = [];
  bool isLoading = false;
  String status;

  TabTwoLogic(this.status);

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
      "service":"",
      "code":"",
      "status":status,
      "province":"",
      "staffCode":"",
      "fromDate":"",
      "toDate":"",
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