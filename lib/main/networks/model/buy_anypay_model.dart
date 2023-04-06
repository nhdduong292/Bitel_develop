class BuyAnyPayModel {
  String? invoiceNo;
  String? bankCode;
  String? code;
  String? idNumber;
  String? name;
  double? amount;
  double? balance;
  double? discount;
  double? total;
  String? creationDate;

  BuyAnyPayModel();
  BuyAnyPayModel.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['invoiceNo'];
    bankCode = json['bankCode'];
    code = json['code'];
    idNumber = json['idNumber'];
    name = json['name'];
    amount = json['amount'];
    amount = json['balance'];
    discount = json['discount'];
    total = json['total'];
    creationDate = json['creationDate'];
  }
}
