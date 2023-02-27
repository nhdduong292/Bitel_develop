import 'package:bitel_ventas/main/utils/values.dart';

class SearchRequest {
  String service = "";
  String code = "";
  String status = "";
  String province = "";
  String staffCode = "";
  String fromDate = "";
  String toDate = "";

  List<String> listStatus = [
    RequestStatus.CREATE_REQUEST,
    RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY,
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
    } else if (status == RequestStatus.CONNECTED) {
      return 2;
    } else if (status == RequestStatus.DEPLOYING) {
      return 3;
    } else if (status == RequestStatus.COMPLETE) {
      return 4;
    } else if (status == RequestStatus.CANCEL) {
      return 5;
    }
    return 0;
  }
}
