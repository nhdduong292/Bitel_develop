class PackageModel {
  int? packageId;
  String? packageName;
  double? fee;
  String? code;
  int? numMonthPay;

  PackageModel();

  PackageModel.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    packageName = json['packageName'];
    fee = json['fee'];
    code = json['code'];
    numMonthPay = json['numMonthPay'];
  }
}
