import 'package:bitel_ventas/main/utils/values.dart';

class SearchRequest {
  String service = "FTTH";
  String code = "";
  String status = "";
  String province = "";
  String staffCode = "";
  String fromDate = "";
  String toDate = "";

  List<String> listStatus = [
    RequestStatus.CREATE_REQUEST,
    RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY,
    RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY,
    RequestStatus.CONNECTED,
    RequestStatus.DEPLOYING,
    RequestStatus.COMPLETE,
    RequestStatus.CANCEL
  ];

  SearchRequest();

  int getPositionStatus() {
    if (status == RequestStatus.CREATE_REQUEST) {
      return 0;
    } else if (status == RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY) {
      return 1;
    } else if (status == RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY) {
      return 2;
    } else if (status == RequestStatus.CONNECTED) {
      return 3;
    } else if (status == RequestStatus.DEPLOYING) {
      return 4;
    } else if (status == RequestStatus.COMPLETE) {
      return 5;
    } else if (status == RequestStatus.CANCEL) {
      return 6;
    }
    return 0;
  }

  void reset(){
    service = "FTTH";
    code = "";
    status = "";
    province = "";
    staffCode = "";
    fromDate = "";
    toDate = "";
  }
}
