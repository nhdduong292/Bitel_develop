import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:get/get.dart';

class DialogSurveySuccessfulLogic extends GetxController{
  bool isSelectOffline = false;
  int id;


  DialogSurveySuccessfulLogic(this.id);

  void setSurveyOffline(bool value){
    isSelectOffline = value;
    update();
  }

  void createSurveyOnline(Function(bool isSuccess) callBack) {
    ApiUtil.getInstance( )!.get(
        url: "${ApiEndPoints.API_SURVEY}/${id}${ApiEndPoints.API_SURVEY_ONLINE}",
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

  void createSurveyOffline(Function (bool isSuccess) callBack) {
    Map<String, dynamic> body = {
      "status": RequestStatus.CREATE_REQUEST,
      "reasonId": "",
      "note": ""
    };
    ApiUtil.getInstance( )!.put(
        url: "${ApiEndPoints.API_REQUEST_DETAIL}/${id}${ApiEndPoints.API_CHANGE_STATUS_REQUEST}",
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
}