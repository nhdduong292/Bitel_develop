class PlanReasonModel {
  int? id;
  String? name;
  double? feeInstallation;
  String? reasonCode;
  double? fee;
  String? currency;
  int? packageId;
  String? packageName;
  int? numMonthPay;

  PlanReasonModel();

  PlanReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feeInstallation = json['feeInstallation'];
    reasonCode = json['reasonCode'];
    fee = json['fee'];
    currency = json['currency'];
    packageId = json['packageId'];
    packageName = json['packageName'];
    numMonthPay = json['numMonthPay'];
  }
}
