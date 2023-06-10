import 'package:bitel_ventas/main/networks/model/debt_model.dart';
import 'package:expandable/expandable.dart';

class ClearDebtModel {
  String? subId;
  String? isdn;
  String? productCode;
  String? serviceType;
  String? serviceTypeCode;
  String? actStatus;
  String? actStatusCode;
  String? activeDate;
  String? idNo;
  String? idType;
  String? custName;
  String? isControl;
  String? phone;
  bool isLoadingListDebt = true;
  List<int> listValue = [];
  List<DebtModel> list = [];
  ExpandableController? controller;

  ClearDebtModel();
  ClearDebtModel.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    serviceTypeCode = json['serviceTypeCode'];
    serviceType = json['serviceType'];
    productCode = json['productCode'];
    isdn = json['isdn'];
    phone = json['phone'];
    idType = json['idType'];
    idNo = json['idNo'];
    custName = json['custName'];
    actStatus = json['actStatus'];
    activeDate = json['activeDate'];
    actStatusCode = json['actStatusCode'];
    isControl = json['isControl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'subId': subId,
      'service': serviceTypeCode,
      'productName': serviceType,
      'productCode': productCode,
      'isdn': isdn,
      'amount': phone,
      'idType': idType,
      'idNumber': idNo,
      'fullName': custName,
      'status': actStatus,
      'expireDate': activeDate,
    };
  }
}
