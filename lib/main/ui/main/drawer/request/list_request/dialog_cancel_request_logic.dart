import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/reason_model.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:get/get.dart';

class DialogCancelRequestLogic extends GetxController {
  String currentReason = "";
  List<ReasonModel> listReason = [];
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListReason();
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
            List<ReasonModel> list = (response.data as List)
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

  void changeStatusRequest(int id, String note, Function(bool isSuccess) callBack) async {
    isLoading = true;
    update();
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      "status": "CANCEL",
      "reasonId": currentReason,
      "note": note
    };
    print("note: $note");
    ApiUtil.getInstance()!.put(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/$id${ApiEndPoints.API_CHANGE_STATUS_REQUEST}",
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
