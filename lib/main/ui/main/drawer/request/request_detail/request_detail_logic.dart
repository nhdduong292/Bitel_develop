import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:get/get.dart';

class RequestDetailLogic extends GetxController {
  RequestModel requestModel =  RequestModel();
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRequestDetail(3);
  }

  void getRequestDetail(int id) async {
    isLoading = true;
    update();
    Future.delayed(Duration(seconds: 1));
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
    ApiUtil.getInstance()!.get(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/$id",
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            requestModel = RequestModel.fromJson(response.data);
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
