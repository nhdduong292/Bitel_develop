class BuyAnyPayModel {
  String? saleOrderId;
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
    saleOrderId = json['saleOrderId'];
    bankCode = json['bankCode'];
    code = json['code'];
    idNumber = json['idNumber'];
    name = json['name'];
    amount = json['amount'];
    balance = json['balance'];
    discount = json['discount'];
    total = json['total'];
    creationDate = json['creationDate'];
  }
}
