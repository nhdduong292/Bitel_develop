class PlanReasonModel {
  int? id;
  String? name;
  double? feeInstallation;
  String? reasonCode;
  double? fee;

  PlanReasonModel();

  PlanReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feeInstallation = json['feeInstallation'];
    reasonCode = json['reasonCode'];
    fee = json['fee'];
  }
}
