class PlanReasonModel {
  int? id;
  String? name;
  double? feeInstallation;
  String? reasonCode;
  String? currency;

  PlanReasonModel();

  PlanReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feeInstallation = json['feeInstallation'];
    reasonCode = json['reasonCode'];
    currency = json['currency'];
  }
}
