class ClearDebtModel {
  String? subId;
  String? service;
  String? productName;
  String? productCode;
  String? isdn;
  String? idType;
  String? idNumber;
  String? fullName;
  String? status;
  double? amount;
  String? expireDate;

  ClearDebtModel();
  ClearDebtModel.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    service = json['service'];
    productName = json['productName'];
    productCode = json['productCode'];
    isdn = json['isdn'];
    amount = json['amount'];
    idType = json['idType'];
    idNumber = json['idNumber'];
    fullName = json['fullName'];
    status = json['status'];
    expireDate = json['expireDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'subId': subId,
      'service': service,
      'productName': productName,
      'productCode': productCode,
      'isdn': isdn,
      'amount': amount,
      'idType': idType,
      'idNumber': idNumber,
      'fullName': fullName,
      'status': status,
      'expireDate': expireDate,
    };
  }
}
