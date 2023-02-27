class ContractModel{
  String? contractNumber;
  String? notification;
  String? verificationAddress;
  String? signDate;
  String? printChargeDetail;
  String? subAddress;
  String? chargeCycle;
  String? email;
  String? payment;
  String? phone;

  ContractModel();
  ContractModel.fromJson(Map<String, dynamic> json) {
    contractNumber = json['contractNumber'];
    notification = json['notification'];
    verificationAddress = json['verificationAddress'];
    signDate = json['signDate'];
    printChargeDetail = json['printChargeDetail'];
    subAddress = json['subAddress'];
    chargeCycle = json['chargeCycle'];
    email = json['email'];
    payment = json['payment'];
    phone = json['phone'];
  }
}