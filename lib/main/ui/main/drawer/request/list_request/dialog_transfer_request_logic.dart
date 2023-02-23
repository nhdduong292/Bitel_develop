import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:get/get.dart';

class DialogTransferRequestLogic extends GetxController{
  String currentReason="";
  List<String> listReason = ["HN", "HCM", "PQ"];
  bool isLoading = false;

  void transferRequest(int id, String staffCode, Function(bool isSuccess) callBack) async {
    isLoading = true;
    update();
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
          isLoading = false;
          update();
        },
        onError: (error) {
          print("error: " + error.toString());
          callBack.call(false);
          isLoading = false;
          update();
        });
  }
}