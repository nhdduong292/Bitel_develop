import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:get/get.dart';

class RequestDetailLogic extends GetxController {
  RequestDetailModel requestModel =  RequestDetailModel();
  bool isLoading = false;
  int currentId = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    currentId = Get.arguments;
    print("id: $currentId");
    super.onInit();
    getRequestDetail(currentId);
  }

  void getRequestDetail(int id) async {
    isLoading = true;
    update();
    Future.delayed(Duration(seconds: 1));
    ApiUtil.getInstance()!.get(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/$id",
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            requestModel = RequestDetailModel.fromJson(response.data);
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
