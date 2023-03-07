class PlanReasonModel {
  int? id;
  String? name;
  int? feeInstallation;
  String? reasonCode;
  int? fee;

  PlanReasonModel();

  PlanReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feeInstallation = json['feeInstallation'];
    reasonCode = json['reasonCode'];
    fee = json['fee'];
  }
}
